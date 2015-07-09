require 'rubygems'
require 'nokogiri'
require 'open-uri'

SENTENCE_FILE = "sentences.txt"
REDDIT_URL = "https://www.reddit.com/r/"
SUBREDDITS = [
  "Showerthoughts/",
]

data = IO.readlines(SENTENCE_FILE)
file = File.open(SENTENCE_FILE, 'a')

page = Nokogiri::HTML(open("#{REDDIT_URL}#{SUBREDDITS[0]}"))
posts = page.css('a').select{ |a| a["class"] =~ /title/ }

posts.each do |post|
  unless data.include? "#{post.text}\n"
    file.write( "#{post.text}\n" )
  end
end
