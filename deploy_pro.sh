
# # 执行打包
# ./deploy.sh

# # 把打包后的代码目录 build 打成 .tar.gz 压缩包
tar -czvf DEV_DOCS.tar.gz build

# # 把压缩包传上目标服务器
scp DEV_DOCS.tar.gz root@120.77.150.102:~

# 连上目标服务器上，进行相应的 shell 操作
ssh root@120.77.150.102 << 'ENDSSH'
    # 回到用户目录
    cd

    # 新建目录 
    mkdir -p DEV_DOCS

    # 把传上来的压缩包解压到刚刚新建的目录
    tar -xzvf DEV_DOCS.tar.gz -C DEV_DOCS

    # 删掉压缩包
    rm DEV_DOCS.tar.gz

    # 删除上一版代码
    sudo rm -rf /vue_apps/dev_docs

    # 剪切新一版代码到目标目录
    sudo mv ~/DEV_DOCS/build /vue_apps/dev_docs

    # 删除最初建的目录
    sudo rm -rf ~/DEV_DOCS

    # 给新一版代码所在的目录赋予 nginx 读取权限
    # 注意：这里的权限 nginx:nginx 还是 755 看项目现有的
    sudo chown -R 755 /vue_apps/dev_docs

# 结束 ssh 连接
ENDSSH

rm -rf DEV_DOCS.tar.gz




