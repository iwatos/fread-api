class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :feed_id
      t.text :title
      t.text :url
      t.string :thumbnail
      t.text :content

      t.timestamps
    end
  end
end
