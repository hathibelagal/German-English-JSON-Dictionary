# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'json'

mode=ARGV[0]    # Should be "ge" for German to English

dictionaryHTML = Nokogiri::HTML(
	open("http://www.gutenberg.org/files/3212/3212-h/3212-h.htm")
)

dictionaryObject={}

dictionaryHTML.xpath('//tr').each do |row|
    if row.children.size() == 2 then
        german = row.children[0].content
        english = row.children[1].content
        if mode=="ge" then
            dictionaryObject[german]=english
        elsif mode=="eg" then
            dictionaryObject[english]=german
        end
    end
end

dictionaryJSON = JSON.generate(dictionaryObject)
puts dictionaryJSON
