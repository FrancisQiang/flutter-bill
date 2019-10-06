class BillBean {
  int id;
  String name;
  int type;
  double money;
  int time;
  String remark;

  BillBean({this.id, this.name, this.type, this.money, this.time, this.remark});

  BillBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    money = json['money'];
    time = json['time'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['money'] = this.money;
    data['time'] = this.time;
    data['remark'] = this.remark;
    return data;
  }
}