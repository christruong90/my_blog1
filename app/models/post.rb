class Post < ActiveRecord::Base
    validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

    belongs_to :category
    belongs_to :user
    has_many :comments, dependent: :destroy
    
end
