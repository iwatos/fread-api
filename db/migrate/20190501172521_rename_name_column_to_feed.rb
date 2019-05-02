class RenameNameColumnToFeed < ActiveRecord::Migration[5.1]
  def change
    rename_column :feeds, :name, :title
  end
end
