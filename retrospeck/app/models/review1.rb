class Review < ApplicationRecord
  belongs_to :user, class_name: Users

  validates :content, :title, presence: false
end
