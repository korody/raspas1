# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  bio                :string(255)
#  origin             :string(255)
#  born               :string(255)
#  tipo               :string(255)
#


  require 'digest'
  class User < ActiveRecord::Base
  attr_accessible :name, :email, :image, :bio, :job, :tipo, :origin, :born
  before_save :create_remember_token

  mount_uploader :image, ImageUploader

  has_many :microposts, dependent: :destroy, order: "microposts.created_at DESC"
  
  has_many :favourites, dependent: :destroy

  has_many :eleitas, through: :favourites, source: :micropost, order: "favourites.created_at DESC"

  has_many :reverse_favourites, foreign_key: "poster_id",
                                   class_name: "Favourite",
                                   dependent: :destroy

  has_many :favoritadas, through: :reverse_favourites, source: :micropost, order: "microposts.created_at DESC", select: "DISTINCT microposts.*"#, 
                                              # :select => "microposts.id, count(favoritadas.id) AS favouritadas_count",
                                              # :joins => :favourites,
                                              # :order => "favouritadas_count"
                                              # group_clause

  has_many :relationships, foreign_key: "follower_id",
                           dependent: :destroy

  has_many :following, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy

  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :subscriptions, foreign_key: "user_id",
                           dependent: :destroy

  has_many :idols, through: :subscriptions, source: :author
  
  has_many :authors, through: :microposts, order: "authors.created_at DESC", select: "DISTINCT authors.*"

  has_many :authors

  has_many :tags, through: :microposts, order: "tags.created_at DESC", select: "DISTINCT tags.*"

  has_many :origins

  has_many :books, through: :microposts, source: :origin, conditions: "type = 'Book'", order: "origins.created_at DESC", select: "DISTINCT origins.*"
  has_many :poems, through: :microposts, source: :origin, conditions: "type = 'Poem'", order: "origins.created_at DESC", select: "DISTINCT origins.*"
  has_many :songs, through: :microposts, source: :origin, conditions: "type = 'Song'", order: "origins.created_at DESC", select: "DISTINCT origins.*"
  has_many :films, through: :microposts, source: :origin, conditions: "type = 'Film'", order: "origins.created_at DESC", select: "DISTINCT origins.*"
  has_many :others, through: :microposts, source: :origin, conditions: "type = 'Other'", order: "origins.created_at DESC", select: "DISTINCT origins.*"

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  presence: true,
            	      length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }

  validates :email, presence: true,
                   format: { with: email_regex },
                   uniqueness: { case_sensitive: false },
                   on: :update

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"] 
      user.origin = auth["info"]["location"]
      user.bio = auth["info"]["description"]
      user.image = auth["info"]["image"]
      user.tipo = auth["extra"]["raw_info"]["link"] 
      #user.image = auth["extra"]["raw_info"]["image"] 
    end
  end

  include PgSearch
  pg_search_scope :search, against: [:name, :job, :origin],
    using: {tsearch: {prefix: true, dictionary: "portuguese"}},
    ignoring: :accents  

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def idols?(author)
    subscriptions.find_by_author_id(author)
  end

  def fan!(author)
    subscriptions.create!(:author_id => author.id)
  end

  def unfan!(author)
    subscriptions.find_by_author_id(author.id).destroy
  end  

  def feed
    Micropost.user_feed(self).reverse
  end

  def favo
    Micropost.from_microposts_favourites_of(self)
  end

  private

    def create_remember_token
      self.salt = SecureRandom.urlsafe_base64
    end
end