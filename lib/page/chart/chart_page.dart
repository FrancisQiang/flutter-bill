import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:flutter_bill/config/my_const.dart';
import 'package:flutter_bill/model/bill_model.dart';
import 'package:flutter_bill/util/color_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  // 收入颜色
  final Color _incomeBarColor = Color(0xff53fdd7);

  // 支出颜色
  final Color _expenseBarColor = Color(0xffff5182);

  // 柱状图直线宽度
  final double _barWidth = 5;

  Map<String, int> _iconDataMap = {
    "food": 0xe556,
    "game": 0xe338,
    "study": 0xe865,
    "gift": 0xe8f6,
    "travel": 0xe613,
    "hairdressing": 0xe87c,
    "red packet": 0xe269,
    "bonus": 0xe263,
    "work": 0xe8f9,
    "business": 0xeb3f,
    "appericate": 0xe8dc,
    "borrow": 0xe7fc
  };

  // 图表Widget的列表
  List<Widget> _widgetChartList;

  // 生成柱状图的组数据
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 2, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: _incomeBarColor,
        width: _barWidth,
        isRound: true,
      ),
      BarChartRodData(
        y: y2,
        color: _expenseBarColor,
        width: _barWidth,
        isRound: true,
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
  }

  List<BillBean> _generateWidgetChartList(
      context,
      BillModel billModel,
      List<BarChartGroupData> barGroups,
      List<LineChartBarData> lineList,
      Map<String, double> pieMap) {
    List<BillBean> sortedBillBeanList = [];

    // 柱状图数据
    // 每月的数据组
    BarChartGroupData jan;
    BarChartGroupData feb;
    BarChartGroupData mar;
    BarChartGroupData apr;
    BarChartGroupData may;
    BarChartGroupData jun;
    BarChartGroupData jul;
    BarChartGroupData aug;
    BarChartGroupData step;
    BarChartGroupData oct;
    BarChartGroupData nov;
    BarChartGroupData dec;
    // 生成数据组需要的原始信息
    double janIncome = 0;
    double janExpense = 0;
    double febIncome = 0;
    double febExpense = 0;
    double marIncome = 0;
    double marExpense = 0;
    double aprIncome = 0;
    double aprExpense = 0;
    double mayIncome = 0;
    double mayExpense = 0;
    double junIncome = 0;
    double junExpense = 0;
    double julIncome = 0;
    double julExpense = 0;
    double augIncome = 0;
    double augExpense = 0;
    double stepIncome = 0;
    double stepExpense = 0;
    double octIncome = 0;
    double octExpense = 0;
    double novIncome = 0;
    double novExpense = 0;
    double decIncome = 0;
    double decExpense = 0;

    // 折线图所需要的数据
    double income1 = 0;
    double expense1 = 0;
    double income2 = 0;
    double expense2 = 0;
    double income3 = 0;
    double expense3 = 0;
    double income4 = 0;
    double expense4 = 0;
    double income5 = 0;
    double expense5 = 0;
    double income6 = 0;
    double expense6 = 0;
    double income7 = 0;
    double expense7 = 0;
    double income8 = 0;
    double expense8 = 0;
    double income9 = 0;
    double expense9 = 0;
    double income10 = 0;
    double expense10 = 0;
    double income11 = 0;
    double expense11 = 0;
    double income12 = 0;
    double expense12 = 0;
    double income13 = 0;
    double expense13 = 0;
    double income14 = 0;
    double expense14 = 0;
    double income15 = 0;
    double expense15 = 0;
    double income16 = 0;
    double expense16 = 0;
    double income17 = 0;
    double expense17 = 0;
    double income18 = 0;
    double expense18 = 0;
    double income19 = 0;
    double expense19 = 0;
    double income20 = 0;
    double expense20 = 0;
    double income21 = 0;
    double expense21 = 0;
    double income22 = 0;
    double expense22 = 0;
    double income23 = 0;
    double expense23 = 0;
    double income24 = 0;
    double expense24 = 0;
    double income25 = 0;
    double expense25 = 0;
    double income26 = 0;
    double expense26 = 0;
    double income27 = 0;
    double expense27 = 0;
    double income28 = 0;
    double expense28 = 0;
    double income29 = 0;
    double expense29 = 0;
    double income30 = 0;
    double expense30 = 0;
    double income31 = 0;
    double expense31 = 0;

    // 遍历billList
    billModel.billBeanList.forEach((element) {
      DateTime now = DateTime.now();
      DateTime elementDate = DateTime.fromMillisecondsSinceEpoch(element.time);
      if (elementDate.year == now.year) {
        if (element.type == MyConst.INCOME) {
          if (elementDate.month == now.month) {
            switch (elementDate.day) {
              case 1:
                income1 += element.money;
                break;
              case 2:
                income2 += element.money;
                break;
              case 3:
                income3 += element.money;
                break;
              case 4:
                income4 += element.money;
                break;
              case 5:
                income5 += element.money;
                break;
              case 6:
                income6 += element.money;
                break;
              case 7:
                income7 += element.money;
                break;
              case 8:
                income8 += element.money;
                break;
              case 9:
                income9 += element.money;
                break;
              case 10:
                income10 += element.money;
                break;
              case 11:
                income11 += element.money;
                break;
              case 12:
                income12 += element.money;
                break;
              case 13:
                income13 += element.money;
                break;
              case 14:
                income14 += element.money;
                break;
              case 15:
                income15 += element.money;
                break;
              case 16:
                income16 += element.money;
                break;
              case 17:
                income17 += element.money;
                break;
              case 18:
                income18 += element.money;
                break;
              case 19:
                income19 += element.money;
                break;
              case 20:
                income20 += element.money;
                break;
              case 21:
                income21 += element.money;
                break;
              case 22:
                income22 += element.money;
                break;
              case 23:
                income23 += element.money;
                break;
              case 24:
                income24 += element.money;
                break;
              case 25:
                income25 += element.money;
                break;
              case 26:
                income26 += element.money;
                break;
              case 27:
                income27 += element.money;
                break;
              case 28:
                income28 += element.money;
                break;
              case 29:
                income29 += element.money;
                break;
              case 30:
                income30 += element.money;
                break;
              case 31:
                income31 += element.money;
                break;
            }
          }
          switch (elementDate.month) {
            case 1:
              janIncome += element.money;
              break;
            case 2:
              febIncome += element.money;
              break;
            case 3:
              marIncome += element.money;
              break;
            case 4:
              aprIncome += element.money;
              break;
            case 5:
              mayIncome += element.money;
              break;
            case 6:
              junIncome += element.money;
              break;
            case 7:
              julIncome += element.money;
              break;
            case 8:
              augIncome += element.money;
              break;
            case 9:
              stepIncome += element.money;
              break;
            case 10:
              octIncome += element.money;
              break;
            case 11:
              novIncome += element.money;
              break;
            case 12:
              decIncome += element.money;
              break;
          }
        } else {
          if (elementDate.month == now.month) {
            if (pieMap.containsKey(element.name)) {
              pieMap.update(element.name, (value) {
                return value + element.money;
              });
            } else {
              pieMap.putIfAbsent(element.name, () => element.money);
            }
            switch (elementDate.day) {
              case 1:
                expense1 += element.money;
                break;
              case 2:
                expense2 += element.money;
                break;
              case 3:
                expense3 += element.money;
                break;
              case 4:
                expense4 += element.money;
                break;
              case 5:
                expense5 += element.money;
                break;
              case 6:
                expense6 += element.money;
                break;
              case 7:
                expense7 += element.money;
                break;
              case 8:
                expense8 += element.money;
                break;
              case 9:
                expense9 += element.money;
                break;
              case 10:
                expense10 += element.money;
                break;
              case 11:
                expense11 += element.money;
                break;
              case 12:
                expense12 += element.money;
                break;
              case 13:
                expense13 += element.money;
                break;
              case 14:
                expense14 += element.money;
                break;
              case 15:
                expense15 += element.money;
                break;
              case 16:
                expense16 += element.money;
                break;
              case 17:
                expense17 += element.money;
                break;
              case 18:
                expense18 += element.money;
                break;
              case 19:
                expense19 += element.money;
                break;
              case 20:
                expense20 += element.money;
                break;
              case 21:
                expense21 += element.money;
                break;
              case 22:
                expense22 += element.money;
                break;
              case 23:
                expense23 += element.money;
                break;
              case 24:
                expense24 += element.money;
                break;
              case 25:
                expense25 += element.money;
                break;
              case 26:
                expense26 += element.money;
                break;
              case 27:
                expense27 += element.money;
                break;
              case 28:
                expense28 += element.money;
                break;
              case 29:
                expense29 += element.money;
                break;
              case 30:
                expense30 += element.money;
                break;
              case 31:
                expense31 += element.money;
                break;
            }
          }
          switch (elementDate.month) {
            case 1:
              janExpense += element.money;
              break;
            case 2:
              febExpense += element.money;
              break;
            case 3:
              marExpense += element.money;
              break;
            case 4:
              aprExpense += element.money;
              break;
            case 5:
              mayExpense += element.money;
              break;
            case 6:
              junExpense += element.money;
              break;
            case 7:
              julExpense += element.money;
              break;
            case 8:
              augExpense += element.money;
              break;
            case 9:
              stepExpense += element.money;
              break;
            case 10:
              octExpense += element.money;
              break;
            case 11:
              novExpense += element.money;
              break;
            case 12:
              decExpense += element.money;
              break;
          }
        }
      }
    });

    pieMap.forEach((key, value) {
      BillBean billBean = BillBean();
      billBean.name = key;
      billBean.money = value;
      sortedBillBeanList.add(billBean);
    });

    // 生成柱状图数据
    jan = makeGroupData(0, janIncome, janExpense);
    feb = makeGroupData(1, febIncome, febExpense);
    mar = makeGroupData(2, marIncome, marExpense);
    apr = makeGroupData(3, aprIncome, aprExpense);
    may = makeGroupData(4, mayIncome, mayExpense);
    jun = makeGroupData(5, junIncome, junExpense);
    jul = makeGroupData(6, julIncome, julExpense);
    aug = makeGroupData(7, augIncome, augExpense);
    step = makeGroupData(8, stepIncome, stepExpense);
    oct = makeGroupData(9, octIncome, octExpense);
    nov = makeGroupData(10, novIncome, novExpense);
    dec = makeGroupData(11, decIncome, decExpense);
    barGroups = [jan, feb, mar, apr, may, jun, jul, aug, step, oct, nov, dec];

    // 生成折线图数据
    lineList = [
      LineChartBarData(
        spots: [
          FlSpot(1, income1),
          FlSpot(2, income2),
          FlSpot(3, income3),
          FlSpot(4, income4),
          FlSpot(5, income5),
          FlSpot(6, income6),
          FlSpot(7, income7),
          FlSpot(8, income8),
          FlSpot(9, income9),
          FlSpot(10, income10),
          FlSpot(11, income11),
          FlSpot(12, income12),
          FlSpot(13, income13),
          FlSpot(14, income14),
          FlSpot(15, income15),
          FlSpot(16, income16),
          FlSpot(17, income17),
          FlSpot(18, income18),
          FlSpot(19, income19),
          FlSpot(20, income20),
          FlSpot(21, income21),
          FlSpot(22, income22),
          FlSpot(23, income23),
          FlSpot(24, income24),
          FlSpot(25, income25),
          FlSpot(26, income26),
          FlSpot(27, income27),
          FlSpot(28, income28),
          FlSpot(29, income29),
          FlSpot(30, income30),
          FlSpot(31, income31),
        ],
        isCurved: true,
        colors: [
          Color(0xff4af699),
        ],
        barWidth: 2,
        curveSmoothness: 0,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BelowBarData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(1, expense1),
          FlSpot(2, expense2),
          FlSpot(3, expense3),
          FlSpot(4, expense4),
          FlSpot(5, expense5),
          FlSpot(6, expense6),
          FlSpot(7, expense7),
          FlSpot(8, expense8),
          FlSpot(9, expense9),
          FlSpot(10, expense10),
          FlSpot(11, expense11),
          FlSpot(12, expense12),
          FlSpot(13, expense13),
          FlSpot(14, expense14),
          FlSpot(15, expense15),
          FlSpot(16, expense16),
          FlSpot(17, expense17),
          FlSpot(18, expense18),
          FlSpot(19, expense19),
          FlSpot(20, expense20),
          FlSpot(21, expense21),
          FlSpot(22, expense22),
          FlSpot(23, expense23),
          FlSpot(24, expense24),
          FlSpot(25, expense25),
          FlSpot(26, expense26),
          FlSpot(27, expense27),
          FlSpot(28, expense28),
          FlSpot(29, expense29),
          FlSpot(30, expense30),
          FlSpot(31, expense31),
        ],
        isCurved: true,
        colors: [
          Color(0xffaa4cfc),
        ],
        barWidth: 2,
        curveSmoothness: 0,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BelowBarData(show: false, colors: [
          Color(0x00aa4cfc),
        ]),
      ),
    ];

    sortedBillBeanList.sort((left, right) => right.money.compareTo(left.money));

    _widgetChartList = [
      Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ColorUtil.getLight(Theme.of(context).primaryColor, level: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Text(
                  "${DateTime.now().year} Annual Chart",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      letterSpacing: 2.0,
                      fontFamily: 'lobster'),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlChart(
                    chart: BarChart(BarChartData(
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 10,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return '1';
                              case 1:
                                return '2';
                              case 2:
                                return '3';
                              case 3:
                                return '4';
                              case 4:
                                return '5';
                              case 5:
                                return '6';
                              case 6:
                                return '7';
                              case 7:
                                return '8';
                              case 8:
                                return '9';
                              case 9:
                                return '10';
                              case 10:
                                return '11';
                              case 11:
                                return '12';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 25,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '0';
                            } else if (value == 999) {
                              return '1K';
                            } else if (value == 2499) {
                              return '2.5k';
                            } else if (value == 4999) {
                              return '5k';
                            } else if (value == 9999) {
                              return '1w';
                            } else if (value == 49999) {
                              return '5w';
                            } else if (value == 99999) {
                              return '10w';
                            } else if (value == 499999) {
                              return '50w';
                            } else if (value == 999999) {
                              return '100w';
                            }else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: barGroups,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ColorUtil.getLight(Theme.of(context).primaryColor, level: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Text(
                  "Month${DateTime.now().month} Chart",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      letterSpacing: 2.0,
                      fontFamily: 'lobster'),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: FlChart(
                    chart: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                            touchTooltipData: TouchTooltipData(
                          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                        )),
                        gridData: const FlGridData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            textStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            margin: 8,
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 1:
                                  return '1';
                                case 7:
                                  return '7';
                                case 14:
                                  return '14';
                                case 21:
                                  return '21';
                                case 28:
                                  return '28';
                              }
                              return '';
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 0:
                                  return '0';
                                case 100:
                                  return '100';
                                case 500:
                                  return '500';
                                case 1000:
                                  return '1k';
                                case 2000:
                                  return '2k';
                                case 5000:
                                  return '5k';
                                case 10000:
                                  return '1w';
                              }
                              return '';
                            },
                            margin: 20,
                            reservedSize: 30,
                          ),
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: Colors.transparent,
                              ),
                              top: BorderSide(
                                color: Colors.transparent,
                              ),
                            )),
                        minX: 0,
                        maxX: 31,
                        minY: 0,
                        lineBarsData: lineList,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ColorUtil.getLight(Theme.of(context).primaryColor, level: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Text(
                  "Month${DateTime.now().month} Chart",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      letterSpacing: 2.0,
                      fontFamily: 'lobster'),
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Expanded(child: Builder(builder: (context) {
                if (pieMap.isNotEmpty) {
                  return pie.PieChart(
                    dataMap: pieMap,
                    //Required parameter
                    legendFontColor: Colors.blueGrey[900],
                    legendFontSize: 12.0,
                    legendFontWeight: FontWeight.w500,
                    chartRadius: ScreenUtil.getInstance().setWidth(520),
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    chartValuesColor: Colors.black54,
                    showLegends: true,
                  );
                } else {
                  return SizedBox();
                }
              })),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10),
              ),
            ],
          ),
        ),
      ),
    ];

    return sortedBillBeanList;
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups;
    List<LineChartBarData> lineList;
    Map<String, double> pieMap = Map();
    double totalExpense = 0;
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<BillModel>(builder: (context, billModel, child) {
          List<BillBean> sortBillBeanList = _generateWidgetChartList(
              context, billModel, barGroups, lineList, pieMap);
          sortBillBeanList.forEach((element) {
            totalExpense += element.money;
          });
          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: ScreenUtil.getInstance().setHeight(1200),
                width: ScreenUtil.getInstance().setWidth(1080),
                child: Swiper(
                  itemCount: _widgetChartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _widgetChartList[index];
                  },
                  viewportFraction: 0.9,
                  scale: 1.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, top: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Monthly expense ranking',
                  style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontFamily: 'lobster',
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(top: 10),
                  color: Colors.transparent,
                  child: Builder(
                    builder: (context) {
                      if (sortBillBeanList.isEmpty ||
                          sortBillBeanList == null) {
                        return Container(
                          alignment: Alignment.center,
                          height: ScreenUtil.getInstance().setHeight(500),
                          width: ScreenUtil.getInstance().setWidth(1080),
                          child: Text(
                            'Let' 's go and keep an account',
                            style: TextStyle(
                                fontFamily: 'lobster',
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                                color: Colors.black54),
                          ),
                        );
                      } else {
                        return Column(
                          children:
                              List.generate(sortBillBeanList.length, (index) {
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil.getInstance().setWidth(20),
                                vertical: ScreenUtil.getInstance().setHeight(20)
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              color: Colors.white,
                              elevation: 8.0,
                              child: Container(
                                height: ScreenUtil.getInstance().setHeight(250),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(200),
                                      width: ScreenUtil.getInstance()
                                          .setHeight(200),
                                      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(40)),
                                      decoration: BoxDecoration(
                                          color: MyConst.iconColorList[index],
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        IconData(
                                            _iconDataMap[
                                                sortBillBeanList[index].name],
                                            fontFamily: MyConst.ICON_FAMILY),
                                        color: Colors.white70,
                                        size: 25,
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil.getInstance()
                                          .setWidth(600),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(30),
                                                  top: ScreenUtil.getInstance()
                                                      .setHeight(60)),
                                              child:
                                                  Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        '${sortBillBeanList[index].name}  ',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        letterSpacing: 0.5,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                TextSpan(
                                                    text:
                                                        '${(sortBillBeanList[index].money / totalExpense * 100).toStringAsFixed(1)}%',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14))
                                              ]))),
                                          Container(
                                            width: ScreenUtil.getInstance()
                                                .setWidth(
                                                    sortBillBeanList[index]
                                                            .money /
                                                        totalExpense *
                                                        500),
                                            height: 10,
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil.getInstance().setWidth(30), top: 5),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.getDark(
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  level: 10),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: ScreenUtil.getInstance().setHeight(180),
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil.getInstance()
                                              .setHeight(100)),
                                      child: Text(
                                        '${sortBillBeanList[index].money}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w100,
                                            fontSize: 14,
                                            fontFamily: 'lobster',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    },
                  ))
            ],
          );
        }),
      ),
    );
  }
}
