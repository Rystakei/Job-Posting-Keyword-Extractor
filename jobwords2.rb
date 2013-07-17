# require 'treat'
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

require 'treat'
require 'stopwords'
require 'stopwords/filter'
require 'stopwords/snowball'

@total_terms = []
@more_than_one_appearance_hash = {}
@high_frequency_terms_hash = {}

@term_filter = Stopwords::Snowball::Filter.new "en"

def open_posting(filename)
puts "-----"
puts ""
puts "Start here"
puts "-------"
puts ""
puts "open_posting is running"
# @term_filter = Stopwords::Snowball::Filter.new "en"
posting = File.open("#{filename}.txt", "rb") {|file| file.read}
filtered_posting = @term_filter.filter posting.split
analyze_posting(filtered_posting)
end



def analyze_posting(posting)
puts "analyze_posting_is_running"
# term_filter = Stopwords::Snowball::Filter.new "en"
#for job_postings.each do |posting|
#filtered_posting = term_filter.filter contents.split
posting.each do |term|
 if @total_terms.include?(term)
  puts "We've seen this term before: #{term} \n"
  if !@more_than_one_appearance_hash.include?(term)
  puts "This term has not been encountered more than once: #{term} \n"
  @more_than_one_appearance_hash[term] = 2
  puts "The value it has in the hash is: #{@more_than_one_appearance_hash[term]} \n \n \n"
   else
   puts "This term has been included more than once: #{term} \n"
   @more_than_one_appearance_hash[term] = @more_than_one_appearance_hash[term].to_i + 1
    puts "The value it has in the hash is: #{@more_than_one_appearance_hash[term]} \n \n \n"
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
  puts "These are the 10 most common pairs!"
  @most_frequent_terms_hash.each_pair do |key, value|
  puts "#{key} was mentioned #{value} times" 
  end

end




   

 