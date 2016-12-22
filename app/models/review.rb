class Review < ApplicationRecord
  belongs_to :user

    def self.search(search)
      where("title LIKE ?", "%#{search}%")
      # where("content LIKE ?", "%#{search}%")
    end

end
