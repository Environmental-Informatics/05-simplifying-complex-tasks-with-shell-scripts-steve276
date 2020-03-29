#!/bin/bash
# demonstrate variable scope1

var1=blah
var2=foo

echo $0:: var1 : $var1, var2 : $var2

export var1
./script2.sh

# Let's see what they are now

echo $0:: var1 : $var1, var2 : $var2



