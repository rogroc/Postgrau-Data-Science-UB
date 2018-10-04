IMPORTANT: Doc-01.pdf was too large to upload here. You can download it from (valid till Dec15, 2017):
http://www.ub.edu/rfa/docs/DATA/Doc-01.pdf

NOTE on Prog02.R for the wordcloud (we noticed that there is some problem when running this in a Mac). If you are Mac users, then remove
the following lines:
plain.text<-gsub("á", "a", plain.text)
plain.text<-gsub("é", "e", plain.text)
plain.text<-gsub("í", "i", plain.text)
plain.text<-gsub("ó", "o", plain.text)
plain.text<-gsub("ú", "u", plain.text)
We tried it and then it worked fine.

IMPORTANT package installation: I will provide you with a list of packages. It is uch better to have the, installed before trying the example programmes. The list is in INSTALL.R

This module is divided in two sessions. 

Day-1 (learning R) and Day-2 (case studies on Data Analysis & Package buiding). See slides:

  Statistics with R-Day1.pdf
  
  Statistics with R-Day2.pdf

Documents and programmes mentioned in the text are also available here.
More info: mguillen@ub.edu
