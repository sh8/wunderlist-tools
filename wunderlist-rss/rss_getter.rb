require 'rss'
require 'open-uri'
require 'date'
require 'time'
require 'cgi'
require 'yaml'

class RssGetter
  def get_feed
    urls = YAML.load('rss_urls.yaml')
    feeds = []
    urls.each do |u|
      open(u) do |rss|
        feed = RSS::Parser.parse(rss)
        if feed.feed_type == "rss"
          feed.items.each do |item|
            feeds << {
              "title" => "[#{feed.channel.title}] #{item.title}",
              "body" => "Link: #{item.link}",
              "pub_date" => item.pubDate
            }
          end
        elsif feed.feed_type == "atom"
          feed.entries.each do |entry|
            feed_title = get_xml_cont("#{feed.title}")
            entry_title = get_xml_cont("#{entry.title}")
            link = get_xml_link("#{entry.link}")
            pub_date = get_xml_cont("#{entry.published}")
            feeds << {
              "title" => "[#{feed_title}] #{entry_title}",
              "body" => "Link: #{link}",
              "pub_date" => Time.parse(pub_date)
            }
          end
        end
      end
    end
    return feeds
  end

  private

  def get_xml_cont(text)
    %r|<.+>(.*)</.+>| =~ text
    return CGI.unescapeHTML($1)
  end

  def get_xml_link(url)
    %r|href="(.*)"\/| =~ url
    return $1
  end
end
