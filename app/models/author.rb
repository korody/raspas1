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
  attr_accessible :name, :image, :bio, :job, :tipo, :origin, :born, :user_id
  before_create :titlelize

  mount_uploader :image, ImageUploader

  scope :PUBLISHED, where(published: true)
  scope :UNPUBLISHED, where(published: false)

  has_many :microposts, :dependent => :destroy, order: "microposts.created_at DESC"

  has_many :tags, -> { order("tags.created_at DESC") }, through: :microposts

  has_many :subscriptions, :dependent => :destroy

  has_many :reverse_subscriptions, :class_name => "Subscription",
                                   :dependent => :destroy

  has_many :fans, through: :reverse_subscriptions, source: :user

  belongs_to :user

  has_many :users, -> { order("users.created_at DESC") }, through: :microposts

  has_many :favourites

  has_many :eleitas, -> { order("microposts.created_at DESC").uniq }, through: :favourites, source: :micropost

  has_many :origins
  has_many :books
  has_many :poems
  has_many :songs
  has_many :films
  has_many :others


	validates :name,  :presence => true,
                    :length   => { :maximum => 50 },
                    :uniqueness => { :case_sensitive => false }

  def titlelize
    if name
      self.name = name.titlecase
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

  def idols?(author)
    subscriptions.find_by_author_id(author)
  end

end