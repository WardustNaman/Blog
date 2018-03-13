class RemoveColumnCoverFromArticles < ActiveRecord::Migration[5.1]
  def change
  remove_column :articles, :cover
  end
end
