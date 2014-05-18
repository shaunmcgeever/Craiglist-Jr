class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :body, presence: true
  validates :title, presence: true
end
