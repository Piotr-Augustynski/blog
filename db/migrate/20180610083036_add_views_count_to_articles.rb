class AddViewsCountToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :views_count, :integer, null: false, default: 0
  end
end
