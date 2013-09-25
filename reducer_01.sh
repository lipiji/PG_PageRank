#!/bin/bash
# Piji Li
# lipiji.sdu@gmail.com
# http://www.zhizhihu.com

## Input: vi, vj
## Outpot: vi \t pr0 \t vj,vj,vj....., where vi->vj.
 
awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
	Init_PR = 0.5;
	while(getline < "config.xml")
	{
		if($1=="Init_PR")
		{
			Init_PR = $2;
			break;
		}
	}
	if(Init_PR == "")
		Init_PR = 0.5;
}
{
	vi = $1;
	vj = $2;
	wij = $3;
	
	if(NR == 1)
	{
		last_vi = vi;
		nb_seq = vj"-"wij;
	}
	else if(last_vi == vi)
	{
		nb_seq = nb_seq","vj"-"wij;
	}
	else
	{
		print last_vi, Init_PR, nb_seq;
		last_vi = vi;
		nb_seq = vj"-"wij;
			
	}
}END{
	print last_vi, Init_PR, nb_seq;
}'
