class AddColumnToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :cover, :string
  end
end
