class ChangeColomnToFeeds < ActiveRecord::Migration[5.1]
  def change
    rename_column :feeds, :url, :feed_url
    add_column :feeds, :url, :text
  end
end
