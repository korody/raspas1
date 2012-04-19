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
  attr_accessible :name, :email, :photo, :bio, :job, :tipo, :origin, :born

  has_attached_file(:photo,
                    :path => ":rails_root/app/assets/images/photos/users/:id/:style/:basename.:extension",
                    :url => "photos/users/:id/:style/:basename.:extension",
                    :default_url => "photos/default/user.jpg",
                    :styles => {
                                :tiny => "30x30#",
                                :medium => "130x130#",
                                :regular => "200x200#" })


  has_many :microposts, :dependent => :destroy
  
  has_many :favourites, dependent: :destroy

  has_many :eleitas, through: :favourites, source: :micropost

  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy

  has_many :following, :through => :relationships, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy

  has_many :followers, :through => :reverse_relationships, :source => :follower

  has_many :subscriptions, :foreign_key => "user_id",
                           :dependent => :destroy

  has_many :idols, through: :subscriptions, source: :author

  has_many :authors, through: :microposts#, :uniq => true

  has_many :tags, through: :microposts#, :uniq => true


	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  :presence => true,
            	      :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }

 # validates :email, :presence   => true,
 #                     :format     => { :with => email_regex },
 #                     :uniqueness => { :case_sensitive => false }
	

  validates_attachment_size :photo, :less_than => 5.megabytes

  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


  def self.create_with_omniauth(auth)
      create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.origin = auth["info"]["location"]
      user.photo = auth["info"]["image"]    
    end
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
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
    user_feed = Micropost.from_users_followed_by(self)
    author_feed = Micropost.from_authors_idols_of(self)
    user_feed.merge(author_feed)
  end  
end
