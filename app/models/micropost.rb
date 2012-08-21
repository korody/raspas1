# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  author_id  :integer
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :tag_names, :author_id, :author_name, :origin_name, :origin_id, :origin_type
  
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :favourites, source: :user

  belongs_to :user
  belongs_to :author

  belongs_to :origin
  belongs_to :book
  belongs_to :song
  belongs_to :other

  validates :content, presence: true, length: { maximum: 345 }, 
                                  uniqueness: { :case_sensitive => false }

  validates :user_id, presence: true

  scope :PUBLISHED, where(published: true)
  scope :UNPUBLISHED, where(published: false)

  scope :recent, order("microposts.created_at DESC")
  
  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user).recent }
  scope :from_authors_idols_of, lambda { |user| idols_of(user).recent }
  scope :from_microposts_favourites_of, lambda { |micropost| favourites_of(micropost).recent }
  scope :user_feed, lambda { |user| from_users_followed_by(user).concat(from_authors_idols_of(user)).concat(from_microposts_favourites_of(user)) }

  attr_accessor :author_name, :origin_name, :origin_type
  attr_writer :tag_names, :author_name, :origin_name, :origin_type
  before_save :assign_author, :assign_origin, :normalize
  after_save :assign_tags 

  def normalize
    if content
      self.content = content.gsub('"', '').gsub("'", '`').gsub("\r\n", ' ')
    end  
  end

  def favourites?(micropost)
    favourites.find_by_micropost_id(micropost)
  end

  def tag_names
    @tag_names || tags.map(&:name).join(',')
  end

  private

    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { user_id: user })
    end 

    def self.idols_of(user)
      idols_ids = %(SELECT author_id FROM subscriptions
                            WHERE user_id = :user_id)
      where("author_id IN (#{idols_ids}) OR user_id = :user_id",
            { user_id: user })
    end

    def self.favourites_of(user)
      eleitas_ids = %(SELECT micropost_id FROM favourites
                            WHERE user_id = :user_id)
      where("id IN (#{eleitas_ids}) OR user_id = :user_id",
            { user_id: user })
    end
  
    def assign_tags
      if @tag_names
        self.tags = @tag_names.gsub(', ', ',').split(',').map do |name|
          Tag.find_or_create_by_name(name.downcase)    
        end
      end   
    end

    def assign_author
      if author_name
        @some_author = Author.find_or_create_by_name(author_name)
        self.author_id = @some_author ? @some_author.id : 0
      end
    end

    def assign_origin
      if origin_name
        origin = Origin.find_or_create_by_name(origin_name)
        if origin
          if origin.user_id.blank?
            origin.update_attributes(user_id: user.id)
          end
          if !origin_type.blank?
            origin.update_attributes(type: origin_type)
          else
            if origin.type.blank?
              origin.update_attributes(type: 'Other')
            end
          end  
          if !author_name.blank?
            origin.update_attributes(author_id: @some_author.id)
          end
        end
        self.origin_id = origin ? origin.id : 0
      end
    end

    include PgSearch
    pg_search_scope :search, against: :content,
    using: {tsearch: {dictionary: "portuguese"}},
    associated_against: {author: :name, user: :name, tags: :name},
    ignoring: :accents  

    def self.text_search(query)
      if query.present?
        search(query)
      else
        scoped
      end
    end
end