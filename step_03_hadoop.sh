#!/bin/bash

# Step02: compute PR
# Piji Li
# lipiji.sdu@gmail.com
# http://www.zhizhihu.com

result=$1;
u=$2;
step="step03";

data_path=$PWD/;

Input=$data_path"step02/input/";
Output=$data_path"$step/output/"; 

rm -rf $Output*;
cat $Input* | ./mapper_03.sh | sort -k1 | ./reducer_03.sh > $Output"tmp"

cat $Output* | sort -n -r -k2 > $result

echo $step" done."
