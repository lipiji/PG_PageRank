#!/bin/bash

# Step02: compute PR
# lipiji@baidu.com

i=$1;
u=$2;
result=$3;
step="step02";

data_path=$PWD/;

Input=$data_path"$step/input/";
Output=$data_path"$step/output/"; 

rm -rf $Output*;

cat $Input* | ./mapper_02.sh | sort -k1 | ./reducer_02.sh > $Output"tmp"

## save the tmp result
if [ -f $result ];then
	cat $result > $result".old"
fi
cat $Output* | sort -n -r -k2 | awk '{print $1, $2}' > $result

## rebuild input for an new iteration
cat $Output* > $Input"tmp"

echo $step" "$i"th iteration done."
