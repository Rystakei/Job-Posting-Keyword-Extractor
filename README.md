Job-Posting-Keyword-Extractor
=============================

I know, I know, creative name. But it's descriptive! 

This is an  application that crawls the web for job postings matching a user's input, and returns the most commonly
found terms. It uses SimplyHired's javascript API to pull results for job postings matching the search query "NLP Jobs".
It then iterates through the first 100 job postings returns, counts the most frequent terms, and returns a list of
which terms are most common. I began work on this because I often personally peruse job postings in order to gain
an idea of what skills are most in demand for employers seeking NLP engineers. I figured that it would be a good idea
to make an application to do the work for me, and allow me to get some experience with web scraping and NLP.

Currently, the application is pulling the first 100 postings' Simply Hired page. I am using the Nokogiri gem to do this.
In the future, I need to tweak the code to search for the actual posting's url, open the web page, and
then extract and analyze the words on the page. This will allow me to improve the results, as right now I am the
program is only analyzing the first paragraph or so of a posting. 

Another future update will be to use a NLP processing tool to better weigh the importance of terms. Right now,
the program is presenting results based on which terms appear most frequently, and results would be improved
by presenting the words that appear unusually frequently among these results. 




