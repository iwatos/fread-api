class Feed
    require "feedjira"
    
    def get_feed
        feed = Feedjira::Feed.fetch_and_parse("http://staff.hatenablog.com/feed")
        return feed
    end

end