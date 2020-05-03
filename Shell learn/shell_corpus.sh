#print

echo 'hello!'

ls

ls pictures

cd pictures

cd .. 

mkdir 'SQL LEARN'/new fold
#make new directory

; allows to write two commands on same line

pwd

ls -l # print large form of list


ls -l 'SQL LEARN'/*.pdf # access all pdfs


mv 'SQL LEARN/new/' 'SQL LEARN/new fold/' #### move from initial to final folder


mv 'SQL LEARN'/*.pdf 'SQL LEARN/new fold/' ## moves all pdfto new folder


### See a webpage

 curl 'http://google.com'


curl -L 'http://google.com'

# Redirects to the page

cat 'Codes for data.txt' #opens the file concatenate cat


less 'Codes for data.txt' #opens in a window. PRess Q quits


rm sillyfile.txt

rmdir sillyfile.txt


grep SELECT 'Codes for data.txt'


#gives the search results of the word in the file

curl -L https://tinyurl.com/zeyq9vc | grep fish | wc -l

#gives the line count of word fish in url 


alias ll ='ls-la'


--------------


install programsinto subdirectory of home directory bin 