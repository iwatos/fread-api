class Feed < ApplicationRecord
    has_many :entries, dependent: :destroy
    validates :title, presence: true
    validates :url, presence: true, uniqueness: true

    def self.create(feedUrl)
        feed = Feedjira::Feed.fetch_and_parse(feedUrl)
        dbFeed = Feed.find_by(feed_url: feedUrl)
        if dbFeed == nil
            dbFeed = Feed.new()
        end
        dbFeed.update_attributes(feed_url: feedUrl, title: feed.title, url: feed.url, description: feed.description)
    end
end
