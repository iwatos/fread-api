class Feed
    require "feedjira"
    
    def get_feed(url)
        feed = Feedjira::Feed.fetch_and_parse(url)
        return feed
    end

    def certification(name,token)
        result = false
        if token == User.find_by(name: name).remember_digest
            result = true
        end
        return result
    end

end