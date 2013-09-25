#!/bin/bash
# Piji Li
# lipiji.sdu@gmail.com
# http://www.zhizhihu.com

## Input: vi, vj, pr_j/C_j
## Outpot: vi, new_pr, vj,vj,vj...., where vi -> vj
 
awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
	Alpha = 0.85;
	while(getline < "config.xml")
	{
		if($1=="Alpha")
		{
			Alpha = $2;
			break;
		}
	}
	if(Alpha == "")
		Alpha = 0.85;
}
{
	vi = $1;
	vj = $2;
	pr_j = $3;

	nbs = "";	
	if(vj=="-1")
		nbs = $4;

	if(NR == 1)
	{
		last_vi = vi;
		new_pr = pr_j;
		degree_in = 0;
		if(nbs != "")
			last_nbs = nbs;
	}
	else if(last_vi == vi)
	{
		new_pr += pr_j;
		degree_in++;
		if(nbs != "")
			last_nbs = nbs;
	}
	else
	{
		if(degree_in<2) degree_in=2;
		printf "%s\t%.6f\t%s\n",  last_vi, Alpha*new_pr+(1-Alpha)/(degree_in-1), last_nbs;
		last_vi = vi;
		new_pr = pr_j;
		degree_in = 0;
		if(nbs != "")
			last_nbs = nbs;
	}
}END{
	if(degree_in<2) degree_in=2;
	printf "%s\t%.6f\t%s\n",  last_vi, Alpha*new_pr+(1-Alpha)/degree_in, last_nbs;
}'
