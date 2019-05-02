# lib/tasks/sync.rake
namespace :sync do
    task feeds: [:environment] do
      Feed.all.each do |feed|
        content = Feedjira::Feed.fetch_and_parse feed.feed_url
        content.entries.each do |entry|
          local_entry = feed.entries.where(title: entry.title).first_or_initialize
          local_entry.update_attributes(content: entry.content, url: entry.url, title:entry.title)
          p "Synced Entry - #{entry.title}"
        end
        p "Synced Feed - #{feed.title}"
      end
    end
  end