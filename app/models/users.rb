
class User < ActiveRecord::Base
    has_many :user_categories
    has_many :categories, through: :user_categories
end