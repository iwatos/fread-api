class User < ApplicationRecord
    has_secure_password
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def User.get_urls
        tabs = Tab.where(user_id: user.id)
          list = Array.new(0)
            tabs.each do | tab |
                urls = List.where(tab_id: tab.id)
                urls.each do | url |
                    list.push(url.url)
                end
            end
        return list
    end


end
