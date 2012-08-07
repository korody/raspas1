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
  attr_accessible :name, :image, :bio, :job, :tipo, :origin, :born

  mount_uploader :image, ImageUploader

  scope :PUBLISHED, where(published: true)
  scope :UNPUBLISHED, where(published: false)

  has_many :microposts, :dependent => :destroy, order: "microposts.created_at DESC"

  has_many :tags, through: :microposts, order: "tags.created_at DESC", select: "DISTINCT tags.*"

  has_many :subscriptions, :dependent => :destroy

  has_many :reverse_subscriptions, :class_name => "Subscription",
                                   :dependent => :destroy

  has_many :fans, :through => :reverse_subscriptions, :source => :user

  has_many :users, :through => :microposts, order: "users.created_at DESC", select: "DISTINCT users.*"

  has_many :favourites

  has_many :eleitas, through: :favourites, source: :micropost, order: "favourites.created_at DESC"

	validates :name,  :presence => true,
                    :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }

  include PgSearch
  pg_search_scope :search, against: [:name, :job, :origin],
    using: {tsearch: {prefix: true, dictionary: "portuguese"}},
    associated_against: {tags: :name},
    ignoring: :accents  

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def idols?(author)
    subscriptions.find_by_author_id(author)
  end

end