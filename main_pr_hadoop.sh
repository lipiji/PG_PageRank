#!/bin/bash

# main file to compute PR via Hadoop
# Piji Li
# lipiji.pz@gmail.com
# http://www.zhizhihu.com
#
# PR_i = (1-Alpha)/N + Alpha * SUM( PR_j / C_j )
# where j->i, C_j=Out(j)
#
# Both for directed and undirected graph
# 
echo -e "Start..."; #> run.log;


u="Piji";

data_set="toy.dat";
result=$data_set".pr";

## number of ieration: init is 100
iter=$(awk '{if($1=="Iter") {print $2;exit;}}' config.xml);
if [ "$iter" == "" ];then
	iter=100;
fi

Epsilon=$(awk '{if($1=="Epsilon") {print $2;exit;}}' config.xml);
if [ "$Epsilon" == "" ];then
	Epsilon=0.0001;
fi

Thresh_CT=$(awk '{if($1=="Thresh_CT") {print $2;exit;}}' config.xml);
if [ "$Thresh_CT" == "" ];then
	Thresh_CT=5;
fi


stime_out=`date +%s`

##############################
## Step 01: prepare data
data_path=$PWD/;
Input=$data_path"step01/input/";
rm -rf $Input*
cp $data_set $Input; 

./step_01_hadoop.sh $Input $u

##############################
## Step 02: compute PR iteratively
Convergence_times=0; ## times that error_i<=Epsilon
for((i=1;i<="$iter";i++))
{
	stime_in=`date +%s`
	echo -e "Iteration "$i" begin:" 
	./step_02_hadoop.sh $i $u $result
	
	etime_in=`date +%s`
	differ_in=$(($etime_in-$stime_in))
	
	error_i=$(cat $result* | sort -k1 | ./reducer_02_local.sh)
	if [ $(echo "$i >= 2"|bc) -eq 1 ];then
		
		echo -e "Iteration "$i"th, error="$error_i", time="$differ_in"s";
        #echo -e "Iteration "$i"th, error="$error_i", time="$differ_in"s" >> run.log;
		if [ $(echo "$error_i <= $Epsilon"|bc) -eq 1 ];then
			Convergence_times=$(($Convergence_times+1));
		fi
		if [ "$Convergence_times" -eq "$Thresh_CT" ];then
			echo -e "Iteration exit, i="$i", error="$error_i;
            #echo -e "Iteration exit, i="$i", error="$error_i >> run.log;
			break;
		fi
	fi
}

#############################
## Step 03: crawl data from HDFS to local
./step_03_hadoop.sh $result $u

## done!
etime_out=`date +%s`
differ_out=$(($etime_out-$stime_out))
echo -e "Time cost: "$differ_out"s in total."
#echo -e "Time cost: "$differ_out"s in total." >> run.log
rm $result".old"

