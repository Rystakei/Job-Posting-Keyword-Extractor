
# require 'stopwords'
# require 'stopwords/filter'
# require 'stopwords/snowball'
# #Nathaniel suggested forking the readme file and adding instructions for how to install it. 


# # d = document('posting.txt')

# # //use stopwords gem

# stopwords = ["stopwords", "stopwords", "stopwords"]

# filter = Stopwords::Filter.new stopwords

# filter.filter 'guide by douglas adams'.split
# #['guide', 'douglas', 'adams']

# filter.stopword? 'by'

# #Can use the Snowball filter like this

# filter = Stopwords::Snowball::Filter.new "en"
# f.filter

# #Save the file's text into a string
# posting = File.open('job1.txt', 'rb') {|file| file.read}

# #Filter the stopwords from the txt
# filtered_posting = f.filter posting.split

# #Sort array
# filtered_posting.sort

#Will eventually find 30 job postings and sort through them
#For now, let's look through the most common words in 5 postings

#for job postings in a folder
# open each postings
# put the job posting into a string
# filter the words, which produces an array
# add the words into an array of the words that have been found
# if a word has been found, don't add it to the array, but add it to a repeated words hash
# and increment the value accordingly

require 'stopwords'
require 'stopwords/filter'
require 'stopwords/snowball'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'sanitize'

@total_terms = []
@more_than_one_appearance_hash = {}
@high_frequency_terms_hash = {}

@term_filter = Stopwords::Snowball::Filter.new "en"

#Original method - used to open local files
# def open_local_posting(filename)
# puts "-----"
# puts ""
# puts "Start here"
# puts "-------"
# puts ""
# puts "open_posting is running"
# #Use Snowball filter to remove stop words and remove punctuation from words
# posting = File.open("#{filename}.txt", "rb") {|file| file.read}
# filtered_posting = @term_filter.filter posting.downcase.gsub(/[^a-z\s]/, "").split
# analyze_posting(filtered_posting)
# end

def open_online_posting(link)
puts "-----"
puts ""
puts "Start here"
puts "-------"
puts ""
puts "open_posting is running"
#Use Snowball filter to remove stop words and remove punctuation from words
#access link and save in variable
posting = open(link, :allow_redirections => :safe).read
#clean posting 
sanitized_posting = Sanitize.clean(posting, :remove_contents => ['script', 'style'])

# puts "***********************************************"
# puts "The sanitized posting looks like this \n \n \n "
# puts sanitized_posting
# puts "************************************************"



#filter posting
filtered_posting = @term_filter.filter sanitized_posting.to_s.downcase.gsub(/[^a-z\s]/, "").split

#remove_spaces, split into an array


# puts "***********************************************"
# puts "The posting without spaces looks like this \n \n \n "
# # puts posting_without_spaces
# puts "************************************************"


# posting = open(link, :allow_redirections => :safe)
# sanitized_posting = Sanitize.clean(posting, :remove_contents => ['script', 'style'])

# sanitized_posting = Sanitize.clean(posting_html, :remove_contents => ['script', 'style'])
# puts "***********************************************"
# puts "The sanitized posting looks like this \n \n \n "
# puts "************************************************"
# filtered_posting = @term_filter.filter sanitized_posting.to_s.downcase.gsub(/[^a-z\s]/, "").split
analyze_posting(filtered_posting)


# posting_text = posting_html.at('body').inner_text

# puts "***********************************************"
# puts "The posting text looks like this \n \n \n "
# puts posting_text

# puts "Posting text to string.."
# puts posting_text
# puts "************************************************"

end


def analyze_posting(posting)
puts "analyze_posting_is_running"
# term_filter = Stopwords::Snowball::Filter.new "en"
#for job_postings.each do |posting|
#filtered_posting = term_filter.filter contents.split
posting.each do |term|
 if @total_terms.include?(term)
  # puts "We've seen this term before: #{term} \n"
  if !@more_than_one_appearance_hash.include?(term)
  # puts "This term has not been encountered more than once: #{term} \n"
  @more_than_one_appearance_hash[term] = 2
  # puts "The value it has in the hash is: #{@more_than_one_appearance_hash[term]} \n \n \n"
   else
   # puts "This term has been included more than once: #{term} \n"
   @more_than_one_appearance_hash[term] = @more_than_one_appearance_hash[term].to_i + 1
    # puts "The value it has in the hash is: #{@more_than_one_appearance_hash[term]} \n \n \n"
   end
 else
 @total_terms << term
 end
end
end

def get_results
  puts "get_results is running"
  #sort frequent terms by order, place in a new hash
 @most_frequent_terms_hash = Hash[@more_than_one_appearance_hash.sort { |l, r| r[1] <=> l[1]}]
  #print the most frequent terms to the console
  puts "These are the 15 most common terms:"
  counter = 0
  while counter < 15
      puts "#{counter+1}. #{@most_frequent_terms_hash.keys[counter]} was mentioned #{@most_frequent_terms_hash.values[counter]} times." 
       counter += 1
  end
end

def parse_file
links_array = []
#retrieve list of jobs from SimplyHired.com; contains 10 postings
url = "http://api.simplyhired.com/a/jobs-api/xml-v2/q-NLP+jobs?pshid=51682&ssty=2&cflg=r&jbd=nlpjobcentral.jobamatic.com&clip=99.127.50.141"
doc = Nokogiri::XML(open(url))
#get the links from the list and put them into an array
doc.xpath("//src/@url").each do |key| 
  links_array << key
end
total_postings = links_array.length
counter = 0 

puts "Let's test one link here and see if it works."

puts "Opening open_online_posting(links_array[0])"
puts "#{links_array[0]}"
open_online_posting(links_array[0])
get_results
while counter < total_postings
  links_array.each do |link|
    counter += 1
    stringified_link = link.to_s
    puts  "Link #{counter}:  #{link}  \n" 
    puts "--------------------------------"
     open_online_posting(stringified_link)
  end
end
get_results

end


   

 