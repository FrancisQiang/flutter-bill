import 'dart:io';
import 'package:flutter_bill/bean/bill_bean.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableBillBean = 't_bill_bean';
final String columnId = 'id';
final String columnName = 'name';
final String columnType = 'type';
final String columnMoney = 'money';
final String columnTime = 'time';
final String columnRemark = 'remark';


class BillBeanProvider {
  // 创建DBProvider的单例
  BillBeanProvider._internal();

  factory BillBeanProvider() =>_getInstance();
  static BillBeanProvider get instance => _getInstance();
  static BillBeanProvider _instance;

  static BillBeanProvider _getInstance() {
    if (_instance == null) {
      _instance = BillBeanProvider._internal();
    }
    return _instance;
  }

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "BillBeanDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $tableBillBean (
              $columnId INTEGER primary key autoincrement,
              $columnName VARCHAR(16) not null,
              $columnType TINYINT not null,
              $columnMoney DOUBLE not null,
              $columnTime INTEGER not null,
              $columnRemark VARCHAR(128)
              );
            ''');
        });
  }

  // 插入数据
  Future<int> insert(BillBean billBean) async {
    final db = await database;
    return db.insert(tableBillBean, billBean.toJson());
  }

  // 删除数据
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableBillBean, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(BillBean billBean) async {
    final db = await database;
    return await db.update(tableBillBean, billBean.toJson(),
        where: '$columnId = ?', whereArgs: [billBean.id]);
  }

  // 获取所有
  Future<List<BillBean>> getAll() async {
    final db = await database;
    List<Map> maps = await db.query(tableBillBean,
        columns: [columnId, columnName, columnType, columnMoney, columnTime, columnRemark]
    );
    List<BillBean> billBeanList = [];
    maps.forEach((element) {
      billBeanList.add(BillBean.fromJson(element));
    });
    return billBeanList;
  }

  removeAll() async {
    final db = await database;
    db.delete(tableBillBean);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}