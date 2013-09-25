#!/bin/bash
# Piji Li
# lipiji.sdu@gmail.com
# http://www.zhizhihu.com

## Input: vi \t pr_i \t vj-wij,vj-wij,vj-wij....
## Output: vj, vi, pr_i/n
##		   vj, vi, pr_i/n
##         ......
## 		  vi \t -1 \t  vj,vj,vj....    for rebuild the input       

awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
}
{

	vi = $1;
	pr_i = $2;

	v_out = 0;
	n = split($3, nbs, ",");
	for(i in nbs)
	{
		split(nbs[i], v_w, "-");
		v_out+=v_w[2];
	}
 	for(i in nbs)
	{
		split(nbs[i], v_w, "-");
		print v_w[1], vi, pr_i*v_w[2]/v_out;
	}
	print vi, -1, 0, $3;

}END{
}'
