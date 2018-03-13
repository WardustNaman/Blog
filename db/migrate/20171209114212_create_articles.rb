class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :category_id
      t.date :publish_date
      t.string :feature_image_url
      t.boolean :is_published
      t.timestamps
    end
  end
end
