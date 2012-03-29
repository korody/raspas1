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

	has_many :taggings, :dependent => :destroy 

	has_many :microposts, :through => :taggings

  has_many :users, through: :microposts#, :uniq => true

  has_many :authors, through: :microposts#, :uniq => true

  validates :name,  :length   => { :maximum => 15 }

	  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end


end
