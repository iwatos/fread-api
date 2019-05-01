class Feed
    require "feedjira"

    def certification(name,token)
        result = false
        if token == User.find_by(name: name).remember_digest
            result = true
        end
        return result
    end

end