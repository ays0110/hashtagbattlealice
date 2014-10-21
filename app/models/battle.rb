class Battle < ActiveRecord::Base
    has_many :battlepoints
    belongs_to :user
    
    Battle.connection
    def self.updatecounts
        battles = Battle.where(:status=>1)
        if battles.count > 0
            battles.each do |battle|
                #Sanitize hashtags and add the hashtag
                hashtag1 = "#"+ battle.hashtag1.sub('#', '')
                hashtag2 = "#"+ battle.hashtag2.sub('#', '')
                
                #Pull in since_id of the battle
                since = battle.since_number
                
                #Pull in the newest 100 tweets for both since the last time checked
                init1 = tweetcounter(hashtag1, since, "")
                init2 = tweetcounter(hashtag2, since, "")
                
                number1 = init1[0]
                currentmax1 = init1[1]
                currentcount1 = number1
                
                number2 = init2[0]
                currentmax2 = init2[1]
                currentcount2 = number2
                
                #Update the battle's new since_id
                if (init1[2].to_i != 0 || init2[2].to_i != 0)
                    battle.since_number = [init1[2].to_i, init2[2].to_i].max
                    battle.save
                end
                
                
                #While there are 100 tweets pulled in for each, keep pulling backwards using the lowest tweet id as the maximum until you reach the since_id
                while number1 > 99
                    a = tweetcounter(hashtag1, since, currentmax1)
                    number1 = a[0]
                    currentmax1 = (a[1].to_i - 1).to_s
                    currentcount1 += number1
                end
                
                while number2 > 99
                    a = tweetcounter(hashtag2, since, currentmax2)
                    number2 = a[0]
                    currentmax2 = (a[1].to_i - 1).to_s
                    currentcount2 += number2
                end
                
                #Insert the new count as a battlepoint
                battlepoint1 = Battlepoint.new(:battle_id=>battle.id, :hashtag=>1, :tweetcount=>currentcount1.to_i + battle.battlepoints.where(:hashtag=>1).last.tweetcount)
                battlepoint2 = Battlepoint.new(:battle_id=>battle.id, :hashtag=>2, :tweetcount=>currentcount2.to_i + battle.battlepoints.where(:hashtag=>2).last.tweetcount)
                battlepoint1.save
                battlepoint2.save
            end
        end
    end
    
    
    def self.tweetcounter(hashtag, since_id, max_id)
        client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ""
            config.consumer_secret     = ""
            config.access_token        = ""
            config.access_token_secret = ""
        end
        
        if max_id == ""
            tweets =  client.search(hashtag, :result_type => "recent", :since_id=>since_id).take(100)
        else
            tweets =  client.search(hashtag, :result_type => "recent", :since_id=>since_id, :max_id=>max_id).take(100)
        end
        
        number = tweets.count
        
        if number > 0
            newmax = tweets.last.id
            newsince = tweets.first.id
            else
            newmax = 0
            newsince = 0
        end
        
        return number, newmax, newsince
    end

end
