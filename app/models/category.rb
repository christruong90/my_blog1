class Category < ActiveRecord::Base
    validates(:title, {presence: {message: "must be present!"}})
    has_many :posts, dependent: :destroy
end
