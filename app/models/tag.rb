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

	has_many :taggings, :dependent => :destroy, order: "taggings.created_at DESC"

	has_many :microposts, :through => :taggings, order: "microposts.created_at DESC"

  has_many :users, through: :microposts, order: "microposts.created_at DESC"

  has_many :authors, through: :microposts, order: "microposts.created_at DESC"

  validates :name,  :length   => { :maximum => 20 }

	  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


end
