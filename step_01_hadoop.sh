#!/bin/bash

# Step01: prepare data
# lipiji@baidu.com

u=$2;

step01="step01";
step02="step02";

data_path=$PWD/;

Input=$1;
Output=$data_path"$step02/input/"; 

cat $Input* | ./mapper_01.sh | sort -k1 | ./reducer_01.sh > $Output"tmp"
echo "$step01 done."
