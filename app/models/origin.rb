class Origin < ActiveRecord::Base
	attr_accessible :name, :date, :image, :info, :content, :author_id, :user_id, :author_name, :link, :type
  attr_accessor :author_name
  before_save :assign_author, :assign_origin
  before_create :titlelize

  mount_uploader :image, ImageUploader

  belongs_to :author
  belongs_to :user
	has_many :microposts, order: "microposts.created_at DESC"
  has_many :users, through: :microposts, order: "users.created_at DESC", select: "DISTINCT users.*"
  has_many :tags, through: :microposts, order: "tags.created_at DESC", select: "DISTINCT tags.*"

  validates :name,  presence: true,
            	      length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :user_id,  presence: true

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def titlelize
    if name
      self.name = name.titlecase
    end
  end

  def assign_origin
    if type.blank?
      self.type = 'Other'
    end
  end

  def assign_author
    if author_name
      author = Author.find_or_create_by_name(author_name)
      self.author_id = author ? author.id : 0
    end
  end
end

# def self.inherited(child)
#   child.instance_eval do
#     def model_name
#       Origin.model_name
#     end
#   end
#   super
# end
  
class Book < Origin
end

class Poem < Origin
end

class Song < Origin
end

class Film < Origin
end

class Other < Origin
end