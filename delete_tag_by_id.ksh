#!/bin/ksh
tagID="123456"
file1="test.xml"
tagFind=`grep -oPn "<[^<>]*?${tagID}.*?>" ${file1}`
tagStart=`echo $tagFind | cut -d ":" -f2`
tagName=`echo $tagStart | egrep -o '<[ ]*[^ ]*'| sed 's/^<[ ]*//g'`

posStart=`grep -oPb "<[^<>]*?${tagID}.*?>" $file1 | cut -d ":" -f1`

dd if=$file1 ibs=1 skip=$posStart > tmpfile.xml

posEnd=`grep -ob "<\/${tagName}>" tmpfile.xml | head -1 | cut -d ":" -f1`
tagEnd=`grep -ob "<\/${tagName}>" tmpfile.xml | head -1 | cut -d ":" -f2`
lengthEnd=`echo $tagEnd | wc -c`
posEnd=`expr $posStart + $posEnd + $lengthEnd`

rm tmpfile.xml

echo $tagFind
echo $tagStart
echo $tagName
echo $posStart
echo $posEnd

newconFile="testConf.xml"
dd if=$file1 ibs=1 skip=0 count=$posStart > $newconFile
echo '' >> $newconFile
dd if=$file1 ibs=1 skip=$posEnd >> $newconFile
