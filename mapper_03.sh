#!/bin/bash
## lipiji@baidu.com

awk 'BEGIN{
	OFS = "\t"; ORS = "\n";
}
{

	vi = $1;
	pr_i = $2;

	print pr_i, vi;

}END{
}'
