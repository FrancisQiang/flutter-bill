class IncomeExpenseBean {
  double income;
  double expense;

  IncomeExpenseBean({this.income, this.expense});

  IncomeExpenseBean.fromJson(Map<String, dynamic> json) {
    income = json['income'];
    expense = json['expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income'] = this.income;
    data['expense'] = this.expense;
    return data;
  }
}