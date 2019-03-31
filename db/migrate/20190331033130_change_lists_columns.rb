class ChangeListsColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :tab_id, :integer
    add_column :lists, :url, :string
    remove_column :lists, :name, :string
  end
end
