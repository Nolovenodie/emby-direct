vcl 4.1;

backend default {
    .host = "127.0.0.1";
    .port = "8096";
}

sub vcl_recv {
    # 流媒体播放
    if (req.http.Range ~ "bytes=") {
        set req.http.x-range = req.http.Range;
    }
    if (req.url ~ "stream" || req.url ~ "(?i)\.(mp4|mp3|mkv|avi)(\?[a-z0-9]+)?$") {
            return(pipe);
    }
    # API业务 且 不是图片 则 不缓存
    if (req.url ~ "/emby/" && !req.url ~ "Primary") {
            return(pass);
    }
    # 全量缓存
    return(hash);
}

sub vcl_backend_fetch {
    if (bereq.http.x-range) {
        set bereq.http.Range = bereq.http.x-range;
    }
}

sub vcl_backend_response {
    if (bereq.http.x-range ~ "bytes=" && beresp.status == 206) {
        set beresp.ttl = 10m;
        set beresp.http.CR = beresp.http.content-range;
    }
}
