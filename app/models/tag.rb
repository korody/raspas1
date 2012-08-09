# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  attr_accessible :name

	has_many :taggings, dependent: :destroy, order: "taggings.created_at DESC"

	has_many :microposts, through: :taggings, order: "microposts.created_at DESC"

  has_many :users, through: :microposts, order: "users.created_at DESC", select: "DISTINCT users.*"

  has_many :authors, through: :microposts, order: "authors.created_at DESC", select: "DISTINCT authors.*"

  validates :name, length: { maximum: 20 }

 include PgSearch
  pg_search_scope :search, against: :name,
    using: {tsearch: {prefix: true, dictionary: "portuguese"}},
    ignoring: :accents  

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
