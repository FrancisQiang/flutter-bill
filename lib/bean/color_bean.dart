class ColorBean {
  int red;
  int green;
  int blue;
  double opacity;

  ColorBean({this.red, this.green, this.blue, this.opacity});

  ColorBean.fromJson(Map<String, dynamic> json) {
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
    opacity = json['opacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['red'] = this.red;
    data['green'] = this.green;
    data['blue'] = this.blue;
    data['opacity'] = this.opacity;
    return data;
  }
}