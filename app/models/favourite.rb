class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: {scope: :post_id}


  def favourited_by?(user)
    favourites.exists?(user: user)
  end
  
end
