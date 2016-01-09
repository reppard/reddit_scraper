#!/usr/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

SENTENCE_FILE = "www/sentences.txt"
LOGFILE = "www/scraper.log"
REDDIT_URL = "https://www.reddit.com/r/"
SUBREDDITS = [
  "Showerthoughts/",
]

while true do
  data = IO.readlines(SENTENCE_FILE)
  file = File.open(SENTENCE_FILE, 'a')
  log  = File.open(LOGFILE, 'a')

  log.write("#{Time.now} Getting page...\n")
  page = Nokogiri::HTML(open("#{REDDIT_URL}#{SUBREDDITS[0]}"))

  log.write("#{Time.now} Getting posts...\n")
  posts = page.css('a').select{ |a| a["class"] =~ /title/ }

  log.write("#{Time.now} Pushing to file...\n")
  posts = page.css('a').select{ |a| a["class"] =~ /title/ }

  posts.each do |post|
    unless data.include? "#{post.text}\n"
      file.write( "#{post.text}\n" )
    end
  end

  log.write("#{Time.now} Done.\n")

  file.close
  log.close
  sleep(900)
end
