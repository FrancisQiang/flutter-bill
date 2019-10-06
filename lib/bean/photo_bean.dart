class PhotoBean {
  Urls urls;
  String id;

  PhotoBean({this.urls, this.id});

  PhotoBean.fromJson(Map<String, dynamic> json) {
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    data['id'] = this.id;
    return data;
  }

  static PhotoBean fromMap(Map<String, dynamic> map) {
    PhotoBean photoBean = new PhotoBean();
    photoBean.id = map['id'];
    photoBean.urls = Urls.fromJson(map['urls']);
    return photoBean;
  }

  static List<PhotoBean> fromMapList(dynamic mapList) {
    List<PhotoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    return data;
  }
}