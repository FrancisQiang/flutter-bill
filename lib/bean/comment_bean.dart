class CommentListBean {
  int code;
  Null message;
  List<CommentBean> data;

  CommentListBean({this.code, this.message, this.data});

  CommentListBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CommentBean>();
      json['data'].forEach((v) {
        data.add(new CommentBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentBean {
  int id;
  String name;
  String avatar;
  int createTime;
  String comment;
  String contact;
  double rating;

  CommentBean(
      {this.id,
        this.name,
        this.avatar,
        this.createTime,
        this.comment,
        this.contact,
        this.rating});

  CommentBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    createTime = json['createTime'];
    comment = json['comment'];
    contact = json['contact'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['createTime'] = this.createTime;
    data['comment'] = this.comment;
    data['contact'] = this.contact;
    data['rating'] = this.rating;
    return data;
  }
}