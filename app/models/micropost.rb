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
  attr_accessible :content, :tag_names, :author_id, :author_name, :origem
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  belongs_to :user
  belongs_to :author

  validates :content, :presence => true, :length => { :maximum => 240 },
                      :uniqueness => { :case_sensitive => false }

  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  scope :from_authors_idols_of, lambda { |author| idols_of(author) }

  attr_accessor :author_name
  attr_writer :tag_names
  before_save :assign_author
  after_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end

  private

    def assign_tags
      if @tag_names
        self.tags = @tag_names.split(/\s+/).map do |name|
          Tag.find_or_create_by_name(name.downcase)    
        end
      end   
    end

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

    def assign_author
      author = Author.find_or_create_by_name(author_name.titlecase)
      self.author_id = author ? author.id : 0
    end

    def self.search(search)
      if search
        find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end
end
