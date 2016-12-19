class User < ApplicationRecord
  has_many :reviews

  validates :password, length: { minimum: 5 }
  validates :user_name, presence: true
  validates :email, presence: true
  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

end
