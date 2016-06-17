class Comment < ActiveRecord::Base
    validates(:body, {presence: {message: "must be present!"}, uniqueness: true})
    
    belongs_to :post
end
