#!/bin/bash
# demonstrate variables

var1=Hello
var2=Miriam

echo $var1 $var2
echo

myvar=$(ls /etc | wc -l)
echo There are $myvar variables in the directory /etc




