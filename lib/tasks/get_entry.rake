namespace :get_entry do
    desc "get_entry"
    task feeds: [:environment] do
        Feed.all.each do |feed|
          content = Feedjira::Feed.fetch_and_parse feed.feed_url
          content.entries.reverse.each do |entry|
            local_entry = feed.entries.where(title: entry.title).first_or_initialize
            
            title = entry.title
            url = entry.url
            content = entry.respond_to?("content") ? entry.content : nil
            author = entry.respond_to?("author") ? entry.author : nil
            image = entry.respond_to?("image") ? entry.image : nil
            published = entry.published

            local_entry.update_attributes(
              title: title, 
              url: url, 
              content: content, 
              author: author, 
              image: image, 
              published: published)
          end
          p "Synced Feed - #{feed.title}"
        end
      end

end
