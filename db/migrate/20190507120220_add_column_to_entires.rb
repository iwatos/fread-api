class AddColumnToEntires < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :author, :text, after: :url
    add_column :entries, :image, :text, after: :url
    add_column :entries, :published, :datetime, after: :url
    remove_column :entries, :thumbnail, :varchar
  end
end
