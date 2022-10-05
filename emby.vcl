vcl 4.1;

backend default {
    .host = "127.0.0.1";
    .port = "8096";
}

sub vcl_recv {
    # 流媒体播放
    if (req.url ~ "stream") {
            return(synth(750, "Stream"));
    }
    # API业务 且 不是图片 则 不缓存
    if (req.url ~ "/emby/" && !req.url ~ "Primary") {
            return(pass);
    }
    # 全量缓存
    return(hash);
}

sub vcl_synth {
    # 重定向到 流媒体反代
    if (resp.status == 750) {
        set resp.http.Location = "http://127.0.0.1:10000/" + req.url;
        set resp.status = 302;
        return(deliver);
    }
}