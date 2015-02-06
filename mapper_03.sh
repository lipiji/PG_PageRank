#!/bin/bash
# Piji Li
# lipiji.pz@gmail.com
# http://www.zhizhihu.com

awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
}
{

	vi = $1;
	pr_i = $2;

	print pr_i, vi;

}END{
}'
