# Emby Direct

> 项目依赖 

    apt install screen python3 python3-pip -y

## Cache

> 安装 Varnish 

    apt install varnish -y

> 复制 Varnish 配置 

    cp emby.vcl /etc/varnish/ 
    rm -rf /lib/systemd/system/varnish.service 
    cp varnish.service /lib/systemd/system/

> 编辑 Varnish 

    nano /etc/varnish/emby.vcl

> 重启 Varnish 

    systemctl daemon-reload
    systemctl restart varnish

## Direct

> 安装直连依赖 

    pip3 install -r requirements.txt

> 开启直连服务 

    screen -S emby-direct python3 main.py