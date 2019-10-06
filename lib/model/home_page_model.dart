import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bill/component/dialog/edit_dialog.dart';
import 'package:flutter_bill/resource/shared_preferences_keys.dart';
import 'package:flutter_bill/util/file_util.dart';
import 'package:flutter_bill/util/navigator_util.dart';
import 'package:flutter_bill/util/permission_request_util.dart';
import 'package:flutter_bill/util/shared_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class HomePageModel with ChangeNotifier{

  final _cropKey = GlobalKey<CropState>();

  get cropKey => _cropKey;

  String _currentAvatarUrl = "assets/images/avatar.jpg";

  String get currentAvatarUrl => this._currentAvatarUrl;

  set currentAvatarUrl(String value) => this._currentAvatarUrl = value;

  int _currentAvatarType = CurrentAvatarType.defaultAvatar;

  int get currentAvatarType => this._currentAvatarType;

  set currentAvatarType(int value) => this._currentAvatarType = value;

  String _currentUserName = "fatfatfat";

  String get currentUserName => this._currentUserName;

  set currentUserName(String value) => this._currentUserName = value;

  // 将assetImage转换成本地文件存储
  Future assetsLocalize() async {
    // 首先从sfp中获取头像类型
    _currentAvatarType = await SharedUtil().getInt(SharedPreferencesKeys.CURRENT_AVATAR_TYPE);
    // 如果为默认则转换为本地的
    if (_currentAvatarType == CurrentAvatarType.defaultAvatar) {
      final path = await FileUtil.getInstance()
          .copyAssetToFile("assets/images/", "avatar.jpg", "/avatar/", "avatar.jpg");
      _currentAvatarUrl = path;
      _currentAvatarType = CurrentAvatarType.local;
      SharedUtil().saveString(SharedPreferencesKeys.LOCAL_AVATAR_PATH, path);
      SharedUtil().saveInt(SharedPreferencesKeys.CURRENT_AVATAR_TYPE, CurrentAvatarType.local);
    } else {
      // 如果为本地 则先从持久层获取 如果为空 则从assets中再本地化
      final path = await SharedUtil().getString(SharedPreferencesKeys.LOCAL_AVATAR_PATH) ?? "";
      File file = File(path);
      if (file.existsSync()) {
        _currentAvatarUrl = file.path;
      } else {
        final avatarPath = await FileUtil.getInstance()
            .copyAssetToFile("assets/images/", "avatar.jpg", "/avatar/", "avatar.jpg");
        SharedUtil().saveString(SharedPreferencesKeys.LOCAL_AVATAR_PATH, avatarPath);
        _currentAvatarUrl = avatarPath;
      }
    }
  }

  Future<String> getCurrentUserName() async {
    String localCurrentUserName = await SharedUtil.instance.getString(SharedPreferencesKeys.CURRENT_USER_NAME);
    if (localCurrentUserName != null) {
      currentUserName = localCurrentUserName;
    }
    return _currentUserName;
  }

  void onUserNameTap({BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return EditDialog(
            title: 'username',
            hintText: 'username',
            onValueChanged: (text) {
              currentUserName = text;
            },
            initialValue: _currentUserName,
            onPositive: ({String text}){
              if (text.isEmpty) {
                return;
              }
              _currentUserName = text;
              SharedUtil.instance.saveString(SharedPreferencesKeys.CURRENT_USER_NAME, _currentUserName);
              refresh();
              Fluttertoast.showToast(
                msg: "success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.black54,
              );
            },
          );
        });
  }

  ImageProvider getAvatarProvider() {
    final avatarType = _currentAvatarType;
    final url = _currentAvatarUrl;
    switch (avatarType) {
      case CurrentAvatarType.defaultAvatar:
        return AssetImage("assets/images/avatar.jpg");
        break;
      case CurrentAvatarType.local:
        File file = File(url);
        if (file.existsSync()) {
          return FileImage(file);
        } else {
          return AssetImage("assets/images/avatar.jpg");
        }
        break;
      default: return AssetImage("assets/images/avatar.jpg");
    }
  }

  void onSaveTap() async {
    debugPrint("====================>" + _currentAvatarUrl);
    final croppedFile = await ImageCrop.cropImage(
      file: File(_currentAvatarUrl),
      area: _cropKey.currentState.area,
    );
    await _saveImage(croppedFile);
  }

  Future _saveImage(File file) async {
    String newPath = await FileUtil.getInstance().getSavePath('/avatar/');
    String name = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    File newFile = file.copySync(newPath + name);
    if (newFile.existsSync()) {
      await SharedUtil.instance.saveString(SharedPreferencesKeys.LOCAL_AVATAR_PATH, newFile.path);
      await SharedUtil.instance.saveInt(SharedPreferencesKeys.CURRENT_AVATAR_TYPE, CurrentAvatarType.local);
      _currentAvatarType = CurrentAvatarType.local;
      _currentAvatarUrl = newFile.path;
      notifyListeners();
    }
  }

  void onAvatarSelect(BuildContext context) {
    PermissionReqUtil.getInstance().requestPermission(
        PermissionGroup.photos,
        granted: getImage,
        deniedDes: 'denie',
    context: context,
    openSetting: 'open',);
  }

  Future getImage(context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (Platform.isAndroid) {
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: (context) {
            _saveAndGetAvatarFile(image, context);
          },
          deniedDes: 'Deny',
          context: context,
          openSetting: 'Allow',
        );
        return;
      }
      _saveAndGetAvatarFile(image, context);
    }
  }

  void _saveAndGetAvatarFile(File file, context) async {
    _currentAvatarType = CurrentAvatarType.local;
    _currentAvatarUrl = file.path;
    refresh();
    NavigatorUtil.toAvatarPage(context);
  }

  ImageProvider getAvatarWidget() {
    switch(currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        return AssetImage(
            'assets/images/avatar.jpg'
        );
        break;
      case CurrentAvatarType.local:
        File file = File(_currentAvatarUrl);
        return FileImage(
          file,
        );
        break;
      default:
        return AssetImage(
          'assets/images/avatar.jpg',
        );
    }
  }

  refresh() {
    notifyListeners();
  }

}

class CurrentAvatarType {
  static const int defaultAvatar = 0;
  static const int local = 1;
}