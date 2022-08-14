#!/bin/bash
# Description:
#   修改自 https://www.i4k.xyz/article/guguant/78204912
#   修改自 https://github.com/estrm/onemove/tree/master/github_repository_backup


if [[ $# -eq 0 ]] || [[ $1 = "-h" ]];then
	echo -e "\033[31m--------------------------------------------------------\033[0m"
	echo "Usage1: $0 URL"
	echo "   e.g: $0 https://github.com/BlueSkyXN?tab=repositories"
	echo ""
	echo "Usage2: $0 Username PageNumber"
	echo "   e.g: $0 BlueSkyXN 1"
	echo -e "\033[31m--------------------------------------------------------\033[0m"
	exit 1;
fi

url=""
username=""
if [ $# == 1 ];then
	url="https://github.com/BlueSkyXN-Backup?tab=repositories"
#手动修改上面一行的用户名（如果有识别错误的话）
	username=${url%\?*}
	username=${username##*/}
else
	username=$1
	url="https://github.com/${username}?page=${2}&tab=repositories"
fi

patten1="a href=\"/"${username}"/"
#r_path=`curl "${url}" | grep "${patten1}"`
r_path=`curl "https://github.com/orgs/BlueSkyXN-Backup/repositories" | grep "BlueSkyXN-Backup"`
#请根据自己的组织名修改的上面一行/orgs/后面的名字和grep后面的名字
#同时命令仍然是比如 ./github_backup.sh https://github.com/Skyimg?tab=repositories 不需要修改（注意文件名）
# get repositories url path
path_head="https://github.com/"
for p in ${r_path}
do
	if [[ $p =~ "href" ]];then
		p=${p#*/}
		p=${p%\"*}

		p=${path_head}${p}
		echo -e "\033[33m ====== Download ====================\033[0m"
		echo -e "\033[32m $p \033[0m"
		git clone ${p}
		echo -e "\033[33m ====== $p has been Finished =================\033[0m"
	fi
done
