#!/bin/bash
# Piji Li
# lipiji.sdu@gmail.com
# http://www.zhizhihu.com

 
awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
	count = 0;
	error = 0;
}
{	
	vi = $1;
	pr_i = $2;
	
	if(NR == 1)
	{
		last_vi = vi;
		last_pr = pr_i;
	}
	else if(last_vi == vi)
	{
		e = last_pr - pr_i;
		e = (e > 0) ? e :(-1) * e;  ## abs()
		error += e;
	}
	else
	{
		count++;
		last_vi = vi;
		last_pr = pr_i;
	}
}END{
	count+=2; ## the first and the last
	if(count==0) count=1;
	printf "%.6f", error/count;
}'
