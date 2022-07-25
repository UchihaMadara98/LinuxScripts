#!/usr/bin/python
import re
import requests
import bs4
import webbrowser

keywords=input("1: Searching by Name || Enter Keywords: ")
search_format=re.sub(r'[\s]+','_',keywords)
srchUrl="https://mangakakalot.com/search/story/"+search_format
#print(srchUrl)

res=requests.get(srchUrl)
#print("Getting contents from:",res.url)

try:
    res.raise_for_status()
except Exception as exc:
    print('There was a problem: %s' % (exc))
    exit(10)

statusCode=res.status_code
#print("Status is ",statusCode)

searchSoup=bs4.BeautifulSoup(res.text,"html.parser")

print(type(searchSoup))

mangas=searchSoup.findAll('div',class_="story_item")

n=min(5,len(mangas))

if n == 0:
    print("This is not written yet !!!")
    exit(11)
print("="*60)
print("These are the Top",n,"Search results.")
searchedMangaUrl={}

for counter in range(n):
    print()
    mangaDetails=bs4.BeautifulSoup(str(mangas[counter]),"html.parser")
    print(mangaDetails.select('h3.story_name')[0].text.strip())
    searchedMangaUrl[counter+1]=mangaDetails.select('h3.story_name a')[0].get('href')
    mangaDetail=mangaDetails.select('span')
    for i in range(3):
        print(mangaDetail[i].text.strip())
    print("<<<<<Enter",counter+1,"to choose this>>>>>")
    print()
print("="*60)
#print(searchedMangaUrl)


choice=int(input("Enter Choice >>>>>  "))

if choice not in searchedMangaUrl.keys():
    print("Wrong Choice!!!")
    exit(12)

mangaHomeUrl=searchedMangaUrl[choice]

res2=requests.get(mangaHomeUrl)
#print("Getting contents from:",res.url)

try:
    res2.raise_for_status()
except Exception as exc:
    print('There was a problem: %s' % (exc))
    exit(10)

statusCode=res2.status_code
print(statusCode)

searchChapters=bs4.BeautifulSoup(res2.text,"html.parser")

revChapters=searchChapters.findAll('a',class_="chapter-name text-nowrap")
Chapters=revChapters[::-1]

chapterDict={}
chapter=[]
for ch in Chapters:
    chapter.append(ch.text.strip())
    chapterDict[ch.text.strip()]=ch.get('href')

print("Total Chapters:",len(chapter))
print("First Chapter:",chapter[0],":",chapterDict[chapter[0]])
print("Last Chapter:",chapter[-1],":",chapterDict[chapter[-1]])
