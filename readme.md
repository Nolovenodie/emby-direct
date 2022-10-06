# Emby Direct

*高速缓存+轻量多负载式高可用解决方案*

*基于 [Fclone-Http](https://rclone.org/commands/rclone_serve_http/) 轻量型部署，落地机一键部署*

*Python 的多负载模式还没写，有兴趣的欢迎完善*

---

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
    
---

## 参考资料

- [emby-python](https://github.com/666wcy/emby-python)
- [varnish-cache](https://varnish-cache.org/docs/index.html)
