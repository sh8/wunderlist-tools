require 'wunderlist'
require 'yaml'
require_relative 'rss_getter.rb'

module Wunderlist
  class RSS
    def run
      list_name = "Articles"

      wl = Wunderlist::API.new({
        :access_token => ENV["ACCESS_TOKEN"],
        :client_id => ENV["CLIENT_ID"]
      })
      rss_getter = RssGetter.new
      articles = rss_getter.get_feed
      articles.each do |a|
        task = wl.new_task(list_name, {
          :title => a["title"],
          :due_date => (a["pub_date"]+24*60*60).to_s
        })
        if a["pub_date"].day == Date.today.day - 1 and a["pub_date"].month == Date.today.month
          task.save
          note = task.note
          note.content = a["body"]
          note.save
          reminder = task.reminder
          reminder.date = (a["pub_date"]+24*60*60).to_s
          reminder.save
        end
      end
    end
  end
end
