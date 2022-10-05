import requests
from flask import Flask, request, redirect
from flask_cors import CORS
from urllib import parse
from config import *

app = Flask(__name__)
CORS(app, resources=r"/*")


@app.route("/emby/videos/<item_id>/<file_name>", methods=["GET", "POST"])
def stream(item_id, file_name):
    MediaSourceId = request.args.get("MediaSourceId")
    info_url = f"{CONFIG_EMBY_URL}emby/Items?Fields=Path&Ids={MediaSourceId}&api_key={CONFIG_EMBY_KEY}"

    print("请求地址 >> ", info_url)
   
    info_json = requests.get(url=info_url).json()
    index_url = str(info_json["Items"][0]["Path"])

    for i in CONFIG_DIRECT_LIST:
        # print(info_json["Items"][0]["Path"], i["from"], i["to"])
        index_url = index_url.replace(parse.quote(i["from"]), CONFIG_DIRECT_HOST + i["to"])

    index_url = index_url.replace("%2F", "/")
    print("直链 >> ", index_url)
    
    return redirect(index_url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)