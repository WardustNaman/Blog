class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :article_id
      t.float :rating

      t.timestamps
    end
  end
end
