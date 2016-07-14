class Post < ActiveRecord::Base
    validates(:title, {presence: {message: "must be present!"}, uniqueness: true})

    belongs_to :category
    belongs_to :user

    has_many :taggings
    has_many :tags, through: :taggings
    has_many :comments, dependent: :destroy
    has_many :users, through: :favourites
    has_many :favourites, dependent: :destroy

    def favourited_by?(user)
      favourites.exists?(user: user)
    end

    def favourite_for(user)
      favourites.find_by_user_id user
    end

    def tag_ids=(val)
      tags = Tag.where(id: val)
      self.tags=tags
    end

    def all_tags=(names)
      self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
      end
    end

    def all_tags
      self.tags.map(&:name).join(", ")
    end

end
