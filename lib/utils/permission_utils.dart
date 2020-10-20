import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  //获取存储权限（只有安卓需要）
  static checkPermiss(List<PermissionGroup> lists) async {

      bool isGranted = await checkPermissionsByGroup(lists);
      if (!isGranted) {
        Map<PermissionGroup,PermissionStatus>permissions=await PermissionHandler().requestPermissions(lists);
         isGranted = checkPermissionsByStatus(permissions.values.toList());
         if(isGranted){
           return true;
         }
      }else{
        return true;
      }

    return false;
  }
  /// 检测相关权限是否已经打开(根据已有状态值)
  static bool checkPermissionsByStatus(List<PermissionStatus> lists) {
    bool result = true;

    for (PermissionStatus permissionStatus in lists) {
      if (permissionStatus != PermissionStatus.granted) {
        result = false;
        break;
      }
    }

    return result;
  }
  /// 检测相关权限是否已经打开（根据已有权限名称）
  static Future<bool> checkPermissionsByGroup(
      List<PermissionGroup> lists) async {
    bool result = true;

    for (PermissionGroup permissionGroup in lists) {
      PermissionStatus checkPermissionStatus =
          await PermissionHandler().checkPermissionStatus(permissionGroup);

      if (checkPermissionStatus != PermissionStatus.granted) {
        result = false;
        break;
      }
    }

    return result;
  }

  /// 权限提示对话款
  static showDialog(
      BuildContext cxt, String title, String content, ok(), cancel()) {
    showCupertinoDialog<int>(
        context: cxt,
        builder: (cxt) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("开启权限"),
                onPressed: () {
                  ok();
                },
              ),
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  cancel();
                },
              )
            ],
          );
        });
  }
}
