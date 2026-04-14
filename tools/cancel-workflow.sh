#!/bin/bash -x
# 设置变量
REPO_OWNER="webtocn"
REPO_NAME="cs-github"
# 替换为你的 Personal Access Token
# export GH_TOKEN="ghp_hT*********v70Q8XLQ"
# 获取所有进行中的工作流运行ID 
for i in {1..100}
do
    RUN_IDS=$(curl -s -H "Authorization: token $GH_TOKEN" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs?status=queued&per_page=5000" \
    | jq '.workflow_runs[].id')
    # 循环取消每一个运行
    for RUN_ID in $RUN_IDS; do
    echo "Canceling run ID: $RUN_ID"
    curl -s -X POST -H "Authorization: token $GH_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$RUN_ID/cancel"
    done
    echo $i
done
echo "Done."
