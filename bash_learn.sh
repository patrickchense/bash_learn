#!/bin/bash

function show_menu() {
echo "Bash Learning Guide:
1.  Main Menu
2.  basic_info
3.  globbing
4.  quote_escape
5.  var
6.  string_basic
7.  arithmetic_ln
8.  line_op
9.  dir_stack
10. script_ln
11. read_ln
12. if_ln
13. loop_ln
14. func_ln
15. set_ln
16. mktemp_trap
17. bash_env_ln
18. sys_var
0. quit

reference documents:
https://wangdoc.com/bash/intro.html
"
read -p "Enter your choice > " 

if [ -n "$REPLY" ] && [ "$REPLY" -eq "$REPLY" ] 2>/dev/null; then
	return $REPLY
else
	echo "wrong input" >&2
	exit 1
fi

}


function basic_info() {
echo "basic info------------------------------------------------------------------------------------------
echo cmd, print text
-n, cancel the default enter in echo
-e, explain the special char inside the ' or \", e.g echo -e \"Hello\nWorld\"
; used to finish cmd, can connect by other cmds, e.g clear;ls
type, judge cmd source, e.g type echo
-t, return cmd type, e.g  alias, keyword, function, builtin, file

end basic------------------------------------------------------------------------------------------ "
}

function globbing() {
echo "globbing is pattern expansion------------------------------------------------------------------------------------------
eight types:
1. ~, means home dir 
2. ?, any char, not empty
3. *, any char, including empty
4. [], only enable when file exists, ls [ab].txt, if a.txt or b.txt exists,if not, [ab].txt output is [ab].txt, then ls cmd err
   [^...] or [!...], not match char inside, e.g ls ?[!a]?
   [start-end], [a-z],[0-9] ... 
   [!start-end], [!0-9]
5. {}, all the val inside, e.g {1,2,3} => 1,2,3, echo d{a,e,i,u,o}g => dag deg dig dug dog
   Notice, no space before and after the comma(,),  echo {1 , 2} => {1 , 2} not 1 2
   could nest, echo {j{p,pe}g,png} => jpg jpeg png
   {start..end}, continous seq, e.g {a..z} => 26 char, echo d{a..d}g => dag dbg dcg ddg
	 support reverse, echo {c..a} => c b a
	e.g mkdir {2007..2009}-{01..12} => create 36 dirs
       used in for loop:  for i in {1..4}
   {start..end..step}: echo {0..8..2} => 0 2 4 6 8       
6. var, $, or \${}, 
   \${!string*} or \${!string@}: e.g : echo \${!S*} => SECONDS SHELL SHELLOPTS ...all S var starts with S
7. sub cmd, \$(), echo \$(date), could nest  
8. arithmetic, \$(( )) e.g \$(( 2 + 2 )) 
9. char, [[:class:]], chars 
	[[:alnum:]], any en char or number
	[[:alpha:]], any en char
	[[:blank:]], space and tab
	[[:digit:]], 0-9
	[[:graph:]], A-Z, a-z, 0-9 and punctuation
	[[:lower:]], any lower a-z
	[[:punct:]], punctuation, (any char outside A-Z, a-z, 0-9)
	[[:space:]], space, Tab, LF(10), VT(11), FF(12), CR(13)
	[[:upper:]]
	[[:xdigit:]], 16digit char(A-F,a-f,0-9)
   e.g echo [[:upper:]]* => echo all upper case start filename
Notice:
1. wildcard, first explain then execute
2. no match, original output, e.g echo r* => r* if there is not filename starts with r

quantifier:
?(pattern-list): 0 or 1
+(pattern-list): 1 or more
*(pattern-list): 0 or more
@(pattern-list): 1
!(pattern-list): 0 or 1+, not match 1 "


}

function quote_escape() {

echo "quote and escape learn------------------------------------------------------------------------------------------
escape use \ 
\\a, \\b, \\n, \\r, \\t

echo uses '', could ignore escape, $ \ *, uses \"\" will explain $ \` \\ not *
other effect of \"\", keep origin output format, e.g  echo \$(cal) is different from echo \"\$(cal)\"

here doc: multiple lines input
cat << _EOF_
<html>
<head>
    <title>
    The title of your page
    </title>
</head>

<body>
    Your page content goes here.
</body>
</html>
_EOF_

here string, <<< string
"
}

function var() {

echo "var learn------------------------------------------------------------------------------------------
env shows all env vars
var init:
varname=val
will cover, 
foo=1
foo=2
echo foo #2

read var
\$foo
myvar=USER; echo \${!myvar} => zoday #print the net var value

del var
unset var

special var
\$?, last cmd result
\$\$, shell process id
\$_, last cmd last parameter
\$!, last demaon cmd process id
\$0, current shell name 
\$-, shell start parameter
\$@, \$#, parameter count

var default val
\${varname:-word}, if var not exist, return word
\${varname:=word}, if var not exist, set var to word, return word
\${varname:+word}, test if var exist, if var exist return word, other return null
\${varname:?mesg}, var exist not null return it's val, else print: varname:mesg
  e.g filename=\${1:?\"filename missing.\"} # 1..9 script parameters

declare var, 
declare OPTION VAR=val
-a, array
-f, output all func define
-F, output all funcname
-i, int
-l, lower case 
-p, check var info
-r, readonly var
-u, upper case
-x, env var
if declare used in func, = local

readonly cmd,
equals declare -r

let cmd,
use let can execute arithmetic, e.g let foo=1+2 => foo=3
"
}

function string_basic(){
##string
##len
str="123"
echo "str len $str, '\${#str}':" ${#str}

##sub string
##${var:offset:len}
##offset starts from 0
substr=ksasdfkkdfjksafk
echo "substr, $substr, '\${substr:4:4}':" ${substr:4:4}
echo "substr, $substr, '\${substr:4}':" ${substr:4}
##starts from tail, using minus, space before idx, because ${var:-word} may conflict
echo "substr, starts from tail, '\${substr: -2:2}':" ${substr: -2:2}
}

function string_search_replace() {
##search || replace
###string head match
#### ${var#pattern} del short match, return rest
patternstr=" abc edf, fdkf"
echo "short pattern del, $patternstr, '\${patternstr# * }':" ${patternstr# * }
#### ${var##pattern} del longest match, return rest
echo "longest pattern del, $patternstr, '\${patternstr## * }':" ${patternstr## * }
path=/home/abc/log.file.name
echo "filename reserve $path, '\${path##*/}':" ${path##*/}
#### no match return original
phone="123-456"
echo "no match return original, $phone, '\${phone#33}':" ${phone#33}

###replace
###${var/#pattern/string}
foo=jpg.jpg
echo "replace $foo, '\${foo/#jpg/JPG}':" ${foo/#jpg/JPG}

###tail match
###${var%pattern}, ${var%%pattern}
path=/home/abc/log.file.name
echo "short tail match, $path, '\${path%.*}':" ${path%.*}
echo "long tail match, $path, '\${path%%.*}':" ${path%%.*}
echo "get path, $path, '\${path%/*}':" ${path%/*}
file=foo.png
echo "replace suffix, $file, '\${file%.png}.jpg':" ${file%.png}.jpg

###tail replace
###${var/%pattern/string}
foo=JPG.JPG
echo "tail replace, $foo, '\${foo/%JPG/jpg}':" ${foo/%JPG/jpg}

###any place match
###${var/pattern/string}, ${var//pattern/string}
path=/home/abc/abc.file.name
echo "any replace first, $path, '\${path/abc/edf}':" ${path/abc/edf}
echo "any replace all, $path, '\${path//abc/edf}':" ${path//abc/edf}
echo -e "replace : to  \\\n, \\\${PATH//:/\\\n}:" ${PATH//:/'\n'}

###change UPPER | lower case
### ${var^^} ${var,,}
foo=heLLo
echo "to upper $foo, :" ${foo^^}
echo "to lower $foo, :" ${foo,,}
}

function arithmetic_ln() {

##arithmetic
### op:  (( .. )), ignore all the spaces in the (())
((foo = 5 + 5))
echo "((foo = 5 + 5)): $foo"
(( 3 + 3))
echo "result not zero,((3+3)), cmd success: $?" 
(( 3 -3))
echo "result == zero,((3-3)), cmd fail: $?"

echo "more complex: (((2+3)*4)):" $(((2+3)*4))

###only int support
echo "err, (( 1.5 + 1))"
###any str consider a var, using $ or not, doesn't matter
echo "var in (()), $((hel+2)), res=2, hel is nil, consider 0"
foo=hello
hello=3
echo "var in (()), $((foo+2)), res=5, foo to hello, hello is 3"

###other digit
echo "16, ((0xff))= $((0xff))"
echo "base ((2#11111))= $((2#11111))"

###bit op
echo "bit op, >>,((16>>2)= $(( 16>>2))"
echo "bit op, support: >>, <<, &, |, ~, !, ^"

###logic op
echo "logic op support: <, >, <=, >=, ==, !=, &&, ||, expr1?expr2:expr3"
echo "true, ((3>2))=$((3>2))"
echo "((0<1?1:0))=$((0<1?1:0))"

###assign op
echo "assign, ((a=1))=$((a=1)), \$a=$a"
echo "assign op, support: +=, -=, *=, >>=, &=, |= etc"

###calculate 
echo "using , execute two cmd before and after, return after"
echo "((foo=1+2, 3*4)), return $((foo=1+2,3*4))"

###expr
echo "expr skip the (())"
echo "expr 3 + 2 : "
expr 3 + 2
}

function line_op() {
##line op --based on vim
echo "line operation shortcust: ----------------------------"
echo "move to line head, ^"
echo "move to line tail, $ or 0"
echo "move cursor to current screen last line tail, g$"
echo "move to n line, nG, n is line number"
echo "move to file head, gg"
echo "move to file end, G"

echo "line opeation could repeat by n ------"
echo "move one word right, cursor stay at word beginning, w"
echo "move one word right, cursor stay at word end, e"
echo "move one word left, cursor stay at word beginning, b"
echo "move one word left, cursor stay at word end, ge"
echo "move one word left, cursor stay at word end,ignore punctuation, gE"
echo "move to next line first null empty char, +"
echo "move one line ahead, ("
echo "move one line after, )"
echo "move one paragrahph ahead, {"
echo "move one paragrahph after, }"
echo "move cursor to same line next char(c), fc"
echo "move cursor to same line last char(c), Fc"
echo "move cursor to same line next char(c) before, tc"
echo "move cursor to same line last char(c) after, Tc"
echo "repeat f & t op, ;"
echo "repeat f & t op reverse, ,"
echo "move one line up, k"
echo "move one line down, j"
echo "move one char left, h"
echo "move one char right, space or l" 
echo "all the ops mentioned, could work with n,  3h -> means move left 3 chars"

echo "line op edit -------------"
echo "ticks: print line breaker, 8=, how? 1. print 8, then print i, then print = then ESC skip ediotr mod, result: ========"
echo "edit at current line first non empty char, I"
echo "edit at current line first col, gI"
echo "edit at current line tail, A"
echo "create a new line above current line, O"
echo ":r filename, current pos insert other file content"
echo ":[n]r filename, insert at n line other file content"
echo "re-write 1(n) word after cursor, c[n]w"
echo "re-write 1(n) char after cursor, c[n]l"
echo "re-write 1(n) char before cursor, c[n]h"
echo "re-write [n] lines, [n]cc"
echo "[n]s, input char replace 1(n) char after, equals c[n]l"
echo "[n]S, del [n] lines, and using input content replace"
echo "[n]x, cut n char right to cursor, equals d[n]l"
echo "[n]X, cur n char left to cursor, equals d[n]h"
echo "yy or Y, copy whole line"
echo "y[n]w, copy n words"
echo "y[n]l, copy n chars right to the cursor"
echo "y[n]h, copy n chars left to the cursor"
echo "y$, copy from current pos to end of the line"
echo "y0, copy from current pos to head of the line"
echo ":m,ny<cr> copy line m to n"
echo "y1G or ygg, copy all lines above cursor"
echo "yG, copy all lines below cursor"
echo "yaw or yas, copy one word or one sentence, even though cursor is not at word head or line head"

echo "line op cut--------" 
echo "d, cut selected content"
echo "d$ or D, cut current pos to end of line"
echo "d[n]w, cut [n] words"
echo "d[n]l, cut [n] chars right"
echo "d[n]h, cut [n] chars left"
echo "d0, cut to the head of line"
echo "[n]dd, cut n lines"
echo ":m,nd<cr>, cut m to n line"
echo "d1G or dgg, cut all lines above cursor"
echo "dG, cut all lines below cursor"
echo "daw or das, cut one word or one sentence"
echo "d/f<cr>, cut current pos to next f"

echo "line op paste--------"
echo "p, paste after cursor"
echo "P, paste before cursor"

echo "change case--------"
echo "~, reverse cursor pos char"
echo "U or u, change selected to UPPER or lower case"
echo "gu(U) + range($,G), switch current pos to designate pos chars' case, e.g ggguG, all chars between head to last line to lower case"

echo "replace--------"
echo "r, replace current pos"
echo "R, go into replace mode, ESC back"

echo "undo--------"
echo "[n]u, undo [n] changes"
echo ":undo 5, undo 5 changes"
echo ":undolist, undo his"
echo "ctrl+r, re-do last change"
echo "U, cancel all actions in current line"
echo ":earlier 4m, back to 4 min ago"
echo ":later 55s, go ahead 55 senconds"

echo "so many shortcuts, can't write down all of them, https://blog.csdn.net/u011365893/article/details/17139361"
echo "end of line op-------------------------------------------------------------------------------- "
}

function dir_stack(){
echo  "\n directory stack----------------------------------------------------------------------------------------------------"
echo "pushd/popd, can work as directory stach, pushd works like cd, go into a directory then put it in the stack head"
echo "popd, remove from the stack pop and go into the dir"
path=~/Downloads
cur=`pwd`
echo "current: `pwd`"
echo "pushd $path"
pushd $path
echo "current after pushd `pwd`" 
echo "go back, `cd $cur` current `pwd`"
echo "popd to path"
popd
echo "current after popd`pwd`"

echo "pushd, popd, support diff options, like -n(change stack, don't change dir), +3/-3(int,del from head or tail)"
echo "dirs, show dir stack, options: -c clear, -l print whole path instead of ~, -v show idx(from 0) etc"
echo "end of dir stack--------------------------------------------------------------------------------"

echo "\n\n"
}

function script_ln() {
echo "script start------------------------------------------------------------------------------------------"
echo "first line script intepreter, normally: #!/bin/sh or #!/bin/bash, depends where is the executor"
echo "using #!/usr/bin/env bash, could help if no bash under the /bin"
echo "grant rights to sh, chmod +x +rx 755 u+rx file"
echo "script parameters, \$0 script name, \$1..\$9, first to nine parameters, \$# parameters count, \$@ all parameters space separate \n
\$*, all parameters, using \$IFS first char separate, default is space, user can set"
echo "script parameter count: $#"
echo "for loop code exp:"
cat for_loop.sh
for_loop.sh 10


echo "shift cmd, change script paramenters, rm the current first parameter every time"
echo "while rm each one: "
echo "code example while/shift while_loop.sh"
cat while_loop.sh
while_loop.sh 10 9 8 1 2 3 4 5


echo "getopts cmd, parse complex parameters, e.g -X options, usually combine with while loop, getopts optstring name"
echo "code example, script has -a, -l, -h three options, only -a supports parameter, then can do check like:" 
cat while_getopts.sh
echo
#try 
getopts_try.sh -la 123

echo "config parameter terminator --"
echo "myPath=\"~/docs\" ls -- \$myPath, here myPath can only be treated as path parameter "

echo "exit cmd, exit 0 (success), exit 1 (fail)"
echo "source cmd, 
  1. reload config file,
  2. load ext lib in the script 
source can be simpilfy to ., e.g . .bashrc "

echo "alias cmd, could renmae complext cmd to simple one, or avoid dangerous cmd, alias rm='rm -i'"
echo "unalias cmd, could remove alias set"
echo "script learning basic finish--------------------------------------------------------------------------------"
}

function read_ln() {
##read cmd
echo "read cmd------------------------------------------------------------------------------------------" 
echo "format: read [-option] [var ...]"
echo -n "read some text >"
read text
echo "your input: $text"

echo "if read not follow by varname, cmd REPLY can include all inputs"
echo -n "try REPLY, first input some > "
read 
echo "your input: REPLY=$REPLY"

echo "read could also be used to read file"
cat read_file_try.sh
echo 
read_file_try.sh

echo "options: \n
1. -t, timeout, could put in if/else, handle timeout, this can be use env TMOUT to set default \n
2. -p, prompt user to info, read -p \"Enter one or more vals > \" \n
3. -a, assign user input to an array, starts from idx 0,  read -a people, echo \${people[2]} \n
4. -n, read n chars, read -n 3 letter \n 
5. -e, support user to use readline lib function, liek tab autocomplete \n
6. -d delimiter, first delimiter as finish not enter\n
7. -r, raw mode, no \ translate \n
8. -s, don't show input on screen, like password \n 
9. -u fd, use file decriptor fd as input "

echo "read use IFS as default spliter, IFS default is 'space, tab, enter'"
echo "end read------------------------------------------------------------------------------------------"

echo "\n\n"
}

function if_ln(){
echo "if structure------------------------------------------------------------------------------------------"
echo "if cmds; then \n
	cmds \n
     [elif cmds; then \n
     	cmds ...] \n
     [else \n
	cmds] \n
     fi \n"

echo "\n"
echo "if/then need ; to speparate, ; used as cmd separator in bash, if/then write in two lines, then ; could be ignore"
echo "if could follow by one cmd, successful cmd returns 0, e.g if echo 'hi'; then echo 'hello'; fi"
echo "if could follow by multiple cmds, last cmd defines it's true | false, if false; true; then echo 'hi'; fi"
echo "elif could also have multiple"
echo "if condition usually uses test cmd, three types: \n
	1. test expr \n
	2. [ expr ] \n
	3. [[ expr ]] \n
	these three types are equal but type 3 support regular expr"
echo "example: test -f /etc/hosts ; echo \$?"
test -f /etc/hosts; echo $?
echo "example: [ -f /etc/hosts ] echo \$?"
[ -f /etc/hosts ]; echo $?
echo "common expr format:==================================================:"
echo "file: 
	1. [ -a file ]: exits true
	2. [ -b file ]: exits, and is block true
	3. [ -c file ]: exists, and is char file, true
	4. [ -d file ]: exists, and is dir true
	5. [ -e file ]: exists true
	6. [ -f file ]: exists and normal true
	7. [ -g file ]: exists and set group id, true
	8. [ -G file ]: exists and set effictive group id, true
	9. [ -h file ]: exits and is link file, true
	10 [ -k file ]: exits and set 'sticky bit' true
	11 [ -N file ]: exists and modified since last read, true
	12 [ -p file ]: exists and is pipe true
	13 [ -s file ]: exists and len > 0, true
	14 [ -t fd ]: fd is decriptor and redirect to terminal, true, used to judge if redirected the standard input/output err
	15 [ -w file ]: exits and writable, true
	16 [ -x file ]: exits and executable true
	17 [ file1 -nt file2 ]: file1 last update is > file2 lastupdate or file1 exists and file2 not, true
	18 [ file1 -ot file2 ]: opsite above
 didn't list all the file expr ......"

 echo "file expr example: 
 if [ -e \"\$FILE\" ]; then 
	 if [ -f \"\$FILE\" ]; then
		 echo '\$FILE is a regular file'
	 fi
	 if [ -d \"\$FILE\" ]; then
		 echo '\$FILE is a dir'
	 fi
	 if [ -r \"\$FILE\" ]; then
		 echo '\$FILE is readable'
         fi
else 
	echo '\$FILE does not exist'
	exit 1
fi\n
Why put \$FILE in \"\" is because if \$FILE is null, not in \"\" makes if -e true, in the otherhand, is \"\" considers false \n"

echo "string expr:
	1. [ str ]: not null len > 0, true
	2. [ -n str ]: len > 0, true
	3. [ -z str ]: len == 0, true
	4. [ str1 = str2 ]: equals true
	5. [ str1 == str2 ]: equals =
	6. [ str1 != str2 ]: not equals true
	7. [ str1 '>' str2 ]: compare by alphabet str1 after str2 true
	8. [ str1 '<' str2 ]:
here '>' '<' quoted, because otherwise they will be treated as redirector"
echo "string expr example: 
ANSWER=maybe

if [ -z \"\$ANSWER\" ]; then 
	echo 'There is no answer.' >\&2
	exit 1
fi
if [ \"\$ANSWER\" = \"yes\" ]; then
	echo 'yes'
elif [ \"\$ANSWER\" = \"no\" ]; then
	echo 'no'
else
	echo 'answer is \$ANSWER'
fi
"
echo "int expr: 
	1. [ int1 -eq int2 ]: ==
	2. [ int1 -ne int2 ]: !=
	other: -lt, -le, -ge, -gt"
echo "int expr example:
INT=-5
if [ -z \"\$INT\" ]; then
	echo 'INT is empty.' >\&2
	exit 1
fi
if [ \$INT -eq 0 ]; then
	echo 'INT is zero'
else 
   if [ \$INT -lt 0 ]; then
	   echo 'INT is negative'
   else
	   echo 'INT is positive'
   fi
fi
"

echo "regular expr: [[ str1 =~ regex ]]"
echo "example:
INT=-5

if [[ \"\$INT\" =~ ^-?[0-9]+$ ]]; then
	echo 'INT is an integer'
	exit 0
else
	echo 'INT is not an integer' >\&2
	exit 1
fi"

echo "test logic calculation: AND(&& or -a), OR(|| or -o), NOT(!)"
cat if_test_logic.sh
echo "run if_test_logic.sh:" 
if_test_logic.sh

echo "test arithmetic condition: (( ... ))"
echo "Important!! result of arithmetic non zero is true, it's reverse of cmd result"
echo "(()) also works for assignment, (( foo = 5 )) is true"
cat if_arithmetic.sh
echo "run if_arithmetic.sh:"
if_arithmetic.sh

echo "test normal cmd logic,  
1. cmd1 && cmd2, need cmd1 success then execute cmd2
2. cmd1 || cmd2, need cmd1 fail then execute cmd2
test result is last execute cmd result
"

echo "case structure: used in multiple vals, similiar to multiple elif
case expr in
	pattern )
		cmd ;;
	pattern )
		cmd ;;
	...
esac
"
echo "other case support pattern:
1. a), match a
2. a|b), match a or b
3. [[:alpha:]], match single char
4. ???), match 3 chars
5. *.txt), match .txt suffix
6. *), match any, used as default end for case
"
echo "code example case_structure:"
cat case_structure.sh
echo "code result case_structure:"
case_structure.sh

echo "end if structure------------------------------------------------------------------------------------------"

echo \n\n
}

function loop_ln() {
echo "loop structure------------------------------------------------------------------------------------------:
while cond; do
	cmds
done"

echo "until: cond false then do
until cond; do
	cmds
done"

echo "for...in 
for var in list; do
	cmds
done"
echo "in list could ignore, means all input parameters"

echo "for loop:
for (( expr1; expr2; expr3 )); do
	cmds
done
this is equals to while loop
(( expr1 ))
while (( expr2 )); do
	cmds
	(( expr3 ))
done
"
echo "break | continue, used to jump outside the loop"

echo "select structure ...
select name
	[in list]
do
	cmds
done

1. select generate a menu, content is item in list, every item has a NO
2. Bash prompt user select one, input it's NO
3. After user input, Bash will store into var name, NO store into REPLY, if user not input, just enter, Bash re-generate menu
4. execute cmds
5. return to 1. repeat
"

cat loop.sh
echo "execute loop.sh:"
loop.sh

echo "end loop learn------------------------------------------------------------------------------------------"


echo \n\n
}

function func_ln() {
echo "function learn------------------------------------------------------------------------------------------
funcation is a group of cmds, in the otherhand alias only one cmd
there is a priority alias > func > script if they are all the same name, alias execute first
fn() {
	codes
}
or
function fn() {
	codes
}

del func, unset -f fn
browse all the func in the shell, declare -f, declare -f fn 
declare -F, print all fn

parameter var, similiar to script parameter
\$1 ~ \$9: func first parameter to ninth
\$0: the script name of the func
\$#: func parameter count
\$@: func all paramter, space seperate
\$*: func all parameter, \$IFS first char separate
"
echo "return , could return val, use \$? get it"

echo "local var, global var, local cmd
var defined inside the func is global, can r or change globaly 
use local cmd to define local var, 

"
echo "code example: "
cat func.sh
func.sh
echo "end func learn------------------------------------------------------------------------------------------"

echo \n\n

}

function array_ln() {
echo "array learn------------------------------------------------------------------------------------------
ARRAY[INDEX]=value
ARRAY is name, INDEX >=0, 
assign method:
array[0]=val
array[1]=val
array[2]=val

ARRAY=(value1 value2 ... value3)

ARRAY=(
	value1
	value2
	value3
)

array=(a b c)
array=([2]=c [0]=a [1]=b)

names=(hatter [5]=duchess alice) #hatter is 0, alice is 6
use wildcard:
mp3s=(*.mp3 )

declare -a ARRAYNAME # works
read -a dice # read to a array"

echo 
echo

echo "read array:
 \${array[i]}
 \${foo[@]} # return all
 for loop array
 for i in \"\${names[@]}\"; do
	 echo \$i
 done
 Notice, here \${names[@]} put in \"\" and not is different, always go with \"\", not quote means \$i is each string separate by space

 for act in \"\${activities[*]}\"; do 
	 echo \"Activity: \$act\";
 done
 Notice, here \"\" makes return all val as string, if not, just like @ not quot

 copy array
 hobbies=( \"\${activities[@]}\" )
 add some new with copy: hobbies=( \"\${activities[@]}\" diving)

 default position
 declare -a foo
 foo=A  # foo[0]=A
 echo foo # echo foo[0]

 array len
 \${#array[*]}
 \${#array[@]} 

 extract array NO, which idx is non-null
 arr=([5]=a [9]=b [23]=c)
 echo \${!arr[@]} #5 9 23
 echo \${!arr[*]}
 or for
 for i in \${!arr[@]}; do
	 echo \$i
 done

 extract array item,  \@{array[@]:pos:len}
 food=( apples bananas cucumbers dates eggs grapes )
 echo \${food[@]:1:1} #bananas
 echo \${food[@]:1:3} #bananas cucumbers dates
 ignore len, return all from pos

 append array item, use +=
 foo=(a b c )
 foo+=(d e )

 del array,uses unset
 foo=(a b c d )
 unset foo[2] # a b d
 set to null also del
 foo[1]='' # a d
 unset foo  #del all

 map, use string as idx
 declare -A colors
 colors[\"red\"]=\"#ff0000\"
 colors[\"green\"]=\"#00ff00\"

end of array learn------------------------------------------------------------------------------------------"

echo \n\n
}

function set_ln() {
echo "set cmd learn------------------------------------------------------------------------------------------
set cmd uses to help write secure script
used to change runnable parameter, doc: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html

directly set, shows all env and shell func.

bash ignore null bar by default, uses set -u to change it
set -x, output cmd before execute, set +x close
set -e, terminate if run err, set +e close, not work for cmd1 || cmd2 or cmd1 | cmd2, cmd2 always run
set -o pipefail, cmd1 | cmd2, if cmd1 fails, cmd2 do not run
set -n, check cmd correctness, do not run
set -f, do not extract wildcard filename
set -v, print shell each line input
always put four option together,  set -euxo pipefull

shopt change shell parameter

set cmd finish------------------------------------------------------------------------------------------"

echo \n\n
}

function sys_var() {
echo "sys var ------------------------------------------------------------------------------------------
let's see: cd \$dir && rm *,  want to cd dir and del all, but if dir not exist, rm will not execute. How to fix?
[[ -d \$dir ]] && cd \$dir && rm *
If you not show what will be deleted? How?
[[ -d \$dir ]] && cd \$dir && echo rm *  #this will print the file will be delete and not actually trigger rm

bash -x script.sh,  can aslo print each cmd before execute them, == set -x

var LINENO returns the line number in the file, 
echo \"This is line \$LINENO\"

var FUNCNAME returns array call stack of the current func. FUNCNAME[0] current func, FUNCNAME[1] the func call current func ...

var BASH_SOURCE returns array script stack, 0 is current script

var BASH_LINENO returns array each LINENO of the call, \${BASH_LINENO[\$i]} matches \${FUNCNAME[\$i]} 

sys var finish------------------------------------------------------------------------------------------"

echo \n\n
}

function mktemp_trap(){
echo "mktemp & trap cmd------------------------------------------------------------------------------------------
mktemp, uses when you need create temp file or dic in the script

create dir or file directly ,will be in /tmp dir which makes it un-secure, because /tmp can be read or change by anyuser and sometime people forget to clean after use.

follow these rules:
1. check if file exist before create
2. make sure file create successfully
3. chmod on the tmp file
4. tmp file uses un-predictable name
5. del file when quit script

mktemp takes care of 4,5, makes it easier
TEMPFILE=\$(mktemp)
-d, create dir, 
-p, choose dir, uses \$TMPDIR by default, mktemp -p /home/tmpcz
-t, choose temp filename template, mktemp -t mytemp.XXXXXX

trap uses in bash to response system signal
trap -l shows all
trap [action] [signal1] [signal2] ...

common signal:
HUP: script discontacted with the current terminal
INT: Ctrl+C
QUIT: Ctrl+/, tries to quit the script
KILL: kill the process
TERM: kill cmd default signal
EXIT: bash signal

trap rm -f \"\$TEMPFILE\" EXIT #when script runs to EXIT, run rm -f cmd
trap cmd needs to put in the beginning of the file
could wrap multiple cmds in trap, use func

function egress {
	cmd1
	cmd2
	cmd3
}

trap egress EXIT

end of mktemp & trap ------------------------------------------------------------------------------------------"

echo \n\n
}

function bash_env_ln(){
echo "bash env------------------------------------------------------------------------------------------
everytime run shell, will open a session, two types: login session / non-login session,
login session, needs username/passwd, usually uses in system init, orders:
1. /etc/profile: all users global config script
2. /etc/profile.d: all .sh in the dir
3. ~/.bash_profile: user personal, if exists stop after this
4. ~/.bash_login: if exists, stop after this
5. ~/.profile: 

if you want to change all user configuration, change the profile.d, not profile(Linux change it when updates)

in .bash_profile, can run .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

non-login session, for example, when run bash, creates a non-login session
init:
/etc/bash.bashrc: for all users
~/.bashrc: only current user
everytime a sh run, ~/.bashrc will be execute

~/.bash_logout runs everytime script exit, to clean and record

bash option:
-n: do not run, only check grammer
-v: echo every cmd, before execute
-x: echo every cmd, after execute and before next cmd

Bash allows user defined shortcut
global keyboard cut is in /etc/inputrc, personal could be ~/.inputrc
how to use？
\$include /etc/inputrc

end of bash env------------------------------------------------------------------------------------------ "

echo \n\n
}

show_menu
choice=$?
while [ "$choice" -ge 1 ] && [ "$choice" -le 18  ]; do
case $choice in 
	1 ) show_menu ;;
	2 ) basic_info ;;
	3 ) globbing ;;
	4 ) quote_escape ;;
	5 ) var ;;
	6 ) string_basic ;;
	7 ) arithmetic_ln ;;
	8 ) line_op ;;
	9 ) dir_stack ;;
	10 ) script_ln ;;
	11 ) read_ln ;;
	12 ) if_ln ;;
	13 ) loop_ln ;;
	14 ) func_ln ;;
	15 ) set_ln ;;
	16 ) mktemp_trap ;;
	17 ) bash_env_ln ;;
	18 ) sys_var ;;
	* ) echo "quit guide";break ;;
esac

if [ $choice != 1 ]; then
	read -p "do you want to continue(y/n)? >" 
	if [ "$REPLY" == "y" ]; then
		show_menu
		choice=$?
	else
		echo "quit"; exit 0
	fi
fi
done 

exit 0

