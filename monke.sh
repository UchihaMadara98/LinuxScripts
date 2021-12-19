
repeat(){
	for (( c=1; c<=$1; c++ )); do echo -n "="; done
}


max=`grep Top texts.xml | tail -1 | cut -d "<" -f2 | cut -d ">" -f1 | cut -d "p" -f2`
#echo "$max"

random=`date +%s`

val=$((random % max))
val=$((val + 1))

top_quote=`grep -A100 "<Top${val}>" texts.xml | grep -B100 "</Top${val}>" |grep -v "Top${val}" | sed 's/^[[:space:]]*//g'`
bottom_quote=`grep -A100 "<Bottom${val}>" texts.xml | grep -B100 "</Bottom${val}>" |grep -v "Bottom${val}" | sed 's/^[[:space:]]*//g'`

len=${#top_quote}
len=$((len + 6))
echo -en "\t\t" ; repeat $len ; echo
echo -e "\t\t|| $top_quote ||"
echo -en "\t\t" ; repeat $len ; echo

echo '                  __'
echo '                        / _,\'
echo '                        \_\'
echo '             ,,,,    _,_)  #      /)'
echo '            (= =)D__/    __/     //'
echo '           C/^__)/     _(    ___//'
echo '             \_,/  -.   '-._/,--''
echo '       _\\_,  /           -//.'
echo '        \_ \_/  -,._ _     ) )'
echo '          \/    /    )    / /'
echo '          \-__,/    (    ( ('
echo '                     \.__,-)\_'
echo '                      )\_ / -('
echo '           bger      / -(////'
echo '                    ////'

len=${#bottom_quote}
len=$((len + 6))
repeat $len ; echo
echo "|| $bottom_quote ||"
repeat $len ; echo
