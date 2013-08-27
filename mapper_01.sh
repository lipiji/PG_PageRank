#!/bin/bash
## lipiji@baidu.com

## output: vi, vj where vi->vj.

awk 'BEGIN{
	OFS = "\t"; ORS = "\n";	
	Weighted = 0;
	while(getline < "config.xml")
	{
		if($1=="Weighted")
		{
			Weighted = $2;
			break;
		}
	}
	if(Weighted == "")
		Weighted = 0;

}
{
	if(Weighted == 0)
		print $1, $2, 1;
	else
		print $1, $2, $3;
}END{
}'
