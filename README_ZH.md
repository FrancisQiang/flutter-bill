![title](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/title.jpg?raw=true)

Language:[简体中文](https://github.com/FrancisQiang/flutter-bill/blob/master/README_ZH.md)|[English](https://github.com/FrancisQiang/flutter-bill/blob/master/README.md)

[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/asjqkkkk/todo-list-app)
[![GitHub license](https://img.shields.io/github/license/FrancisQiang/flutter-bill)](https://github.com/FrancisQiang/flutter-bill/blob/master/LICENSE)
[![apkdownload](https://img.shields.io/badge/download-apk-brightgreen)](https://github.com/FrancisQiang/flutter-bill/releases/download/v1.0.0/apk-release.apk)

# Flutter Bill (使用FLutter开发的账单APP)

> Flutter SDK (Channel stable, v1.7.8+hotfix.4, on Microsoft Windows [Version 10.0.17763.720], locale zh-CN)

## 介绍

  :heart_eyes::heart_eyes::heart_eyes:此项目为Flutter开发的一个简易记账app，可以供日常使用和开发者学习Flutter。

  因为此项目逻辑结构比较简单，但同时涵盖了很多Flutter开发的知识点，比如持久层Sp，SQLite的使用，主题配置，简单的动画效果，Dio的封装，一些插件的使用等待，所以此项目比较适合新手入门学习。

  在留言墙内容是作者搭建了后端服务器的(因为我其实是学后端的),大家有什么意见反馈可以直接在这里留言。如果想联系作者可以添加下面的联系方式。

  :blush:因为作者本身并不是移动，前端的开发者，所以有很多细节可能没有注意到，望各位谅解。学习 Flutter 只是作为爱好，因为下阶段需要准备明年的秋招面试，所以后面更新会比较慢。

  :thumbsup::thumbsup::thumbsup:特别感谢[一日清单](https://github.com/asjqkkkk/flutter-todos)(一款很精美的Flutter todo应用)作者，提供灵感和学习项目。

## 展示

![title](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/%E6%80%BB%E4%BD%93.gif?raw=true)  ![title](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/%E8%B4%A6%E5%8D%95%E5%B1%95%E7%A4%BA.gif?raw=true)

![title](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/%E8%AE%BE%E7%BD%AE%E5%B1%95%E7%A4%BA.gif?raw=true)  ![title](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/%E7%95%99%E8%A8%80%E5%B1%95%E7%A4%BA.gif?raw=true)

## 使用到的插件

```yaml
  # 路由
  fluro: ^1.5.1
  # 本地存储
  shared_preferences: ^0.5.2
  # 状态管理
  provider: ^3.0.0+1
  # 图片缓存
  cached_network_image: ^1.1.0
  # 看图片
  photo_view: ^0.4.2
  # svg
  flutter_svg: ^0.13.1
  # 取色框
  flutter_colorpicker: ^0.2.5
  # 图标库
  font_awesome_flutter: ^8.2.0
  # 环形列表
  circle_list: ^0.1.3
  # 列表上拉下拉
  flutter_easyrefresh: ^2.0.3
  # 日期选择型
  flutter_datetime_picker: ^1.2.6
  # 网络请求
  dio: ^2.1.2
  # listView吸附布局
  adsorptionview_flutter: ^0.1.3
  # chart
  fl_chart: ^0.2.2
  # 屏幕适配
  flutter_screenutil: ^0.5.3
  # 数据库
  sqflite: ^1.1.6
  # 提供路径
  path_provider: ^0.5.0+1
  # 轻量级提示
  fluttertoast: ^3.1.3
  # 轮播效果
  carousel_slider: ^1.3.0
  # 饼状图
  pie_chart: ^1.2.0
  # 轮播效果
  flutter_swiper: ^1.1.6
  # 图片选择
  image_picker: ^0.6.0+16
  # 自定义形状
  flutter_custom_clippers: ^1.0.4
  # 图片裁剪
  image_crop: ^0.3.1
  # 权限申请
  permission_handler: ^3.2.0
  # loading加载
  flutter_spinkit: ^4.0.0
  # 动态底部导航
  curved_navigation_bar: ^0.3.1
  # 舞台效果
  flutter_staggered_animations: ^0.1.2
```

## 项目整体结构

```text

├── api            用于存放api接口地址
├── bean           封装的实体类
├── component      一些通用的组件
├── config         配置
├── model          状态管理
├── page           页面
├── resource       资源
├── router         路由的配置
├── sql            sqlite的封装
├── util           工具类
└── main.dart      主入口

```

## ToDo

* 账单列表的日期吸附效果

* 自定义icon的搜索功能

* 自定义字体

* :facepunch:整体项目重构(因为是赶出来的，所以结构有点乱)

* 。。。你们来想吧:dash::dash::dash:

## release下载

![release下载](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/flutter_bill.jpg?raw=true)

## 联系方式

  其实我是学习后端开发的 啊哈哈，但是欢迎大家和我讨论交流Flutter

  如果喜欢的话，那就给我一个star :star::star::star: 吧！！！ 谢谢！！

![release下载](https://github.com/FrancisQiang/flutter-bill/blob/master/assets/md/wechat.png?raw=true)
