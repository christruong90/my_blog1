class User < ActiveRecord::Base
  has_secure_password

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  #   def full_name
  # User.find(session[:user_id]).first_name + " " +
  #   User.find(session[:user_id]).last_name
  #   end


  def full_name
    "#{first_name} #{last_name}"
  end
end
