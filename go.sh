#!/bin/bash

ARGS=$1

if [ -z $ARGS ];then
   echo "请输入Commit参数"
   echo "$0 file     执行全部file待处理任务"
   echo "$0 file-10  执行任务ID为10的待处理任务"
   exit 0
fi

generate_diff(){
    DATE=$(date)
    echo "Date=>$DATE" > .date
}

run_task(){
    NUM=$1
    DATE=$(date)

    for ((n=0; n<$NUM; n++))
    do
        echo "Date=>$DATE , Task=> $NUM" > .date
        git add . --all && git commit -m "Date=>$DATE , Task=> $NUM" && git push
        sleep 5
    done
}

generate_diff

git add . --all && git commit -m "TASK_INFO=$ARGS" && git push
