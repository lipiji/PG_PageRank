#!/bin/bash
## lipiji@baidu.com

 
awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
}
{
	print $2, $1;
}END{
}'
