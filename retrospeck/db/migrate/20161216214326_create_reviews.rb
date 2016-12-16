class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :content
      t.string :review_link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
