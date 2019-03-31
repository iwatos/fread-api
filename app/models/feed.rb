class Feed
    require "feedjira"
    
    def get_feed(url)
        feed = Feedjira::Feed.fetch_and_parse(url)
        return feed
    end

end