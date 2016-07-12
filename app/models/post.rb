class Post < ActiveRecord::Base
    validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

    belongs_to :category
    belongs_to :user

    has_many :comments, dependent: :destroy
    has_many :users, through: :favourites
    has_many :favourites, dependent: :destroy

    def favourited_by?(user)
      favourites.exists?(user: user)
    end

    def favourite_for(user)
      favourites.find_by_user_id user
    end

end
