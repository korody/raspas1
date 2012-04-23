# == Schema Information
#
# Table name: authors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  bio        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  attr_accessible :name, :photo, :bio, :job, :tipo, :origin, :born

  scope :PUBLISHED, where(published: true)
  scope :UNPUBLISHED, where(published: false)

  has_attached_file(:photo,
                    :path => ":rails_root/app/assets/images/photos/authors/:id/:style/:basename.:extension",
                    :url => "photos/authors/:id/:style/:basename.:extension",
                    :default_url => "photos/default/:style/author.jpg",
                    :styles => {
                                :tiny => "30x30#",
                                :medium => "100x100#",
                                :regular => "200x200#" })

  has_many :microposts, :dependent => :destroy

  has_many :tags, through: :microposts#, :uniq => true

  has_many :subscriptions, :dependent => :destroy

  has_many :reverse_subscriptions, :class_name => "Subscription",
                                   :dependent => :destroy

  has_many :fans, :through => :reverse_subscriptions, :source => :user

  has_many :users, :through => :microposts#, :uniq => true

  has_many :eleitas, through: :users

	validates :name,  :presence => true,
                    :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }

  validates_attachment_size :photo, :less_than => 5.megabytes

  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def idols?(author)
    subscriptions.find_by_author_id(author)
  end

    private


  # add validations
  # add default scope
  # modify the micropost before_save callback to use find_by_or_create
  # Do a auto-suggest/auto-complete menu for the other name in the view
end