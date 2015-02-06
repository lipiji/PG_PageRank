#!/bin/bash
# Piji Li
# lipiji.pz@gmail.com
# http://www.zhizhihu.com

 
awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
}
{
	print $2, $1;
}END{
}'
