#!/bin/bash

if [ -z $1 ];then
    echo "需要指定任务: 如 image-123"
    exit 1
fi

sudo apt-get update && sudo apt-get install -y ca-certificates openssh-client rsync  skopeo curl ffmpeg

echo "${RSYNC_SSH_KEY}" > github_id_rsa && chmod 400 github_id_rsa

echo ""
echo "安装 helm"
which helm
if [ $? -ne 0 ];then
  curl https://raw.githubusercontent.com/helm/helm/refs/heads/main/scripts/get-helm-3 | bash
fi
helm version

echo ""
echo "下载cs-executor文件, 基于wget"
wget -q -O cs-executor-linux-amd64 https://raw.githubusercontent.com/cncfstack/file/refs/heads/main/cs-executor-linux-amd64
chmod +x cs-executor-linux-amd64

echo ""
echo "安装阿里云OSS 工具"
if [ ! -f /usr/bin/ossutil ];then
  wget -q -O /tmp/ossutil-2.0.6-beta.01091200-linux-amd64.zip  https://gosspublic.alicdn.com/ossutil/v2-beta/2.0.6-beta.01091200/ossutil-2.0.6-beta.01091200-linux-amd64.zip
  unzip /tmp/ossutil-2.0.6-beta.01091200-linux-amd64.zip -d  /tmp
  cp /tmp/ossutil-2.0.6-beta.01091200-linux-amd64/ossutil ./ossutil
  chmod +x ./ossutil
  sudo cp ./ossutil /usr/bin/
fi

echo "执行程序"
TASK_INFO=$1 ./cs-executor-linux-amd64
