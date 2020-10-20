//
// easy_alert.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/8/5.
// Copyright © 2020 KYDW. All rights reserved.
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const double kCommonMargin = 10;
const double kCornerRadius = 10;
class EasyAlert {

  static const double kTitleFontSize = 18;
  static const double kContentFontSize = 15;
  static const double kButtonFontSize = 16;

  // MARK: Public Method

  /// 显示一个 Alert 提示框
  ///
  /// [BuildContext] 弹框上下文
  /// [title] 标题
  /// [content] * 弹框内容
  /// [showCancel] 是否显示取消按钮
  /// [cancelText] 取消按钮标题
  /// [confirmText] 确定按钮标题
  /// [cancelClicked] 取消按钮点击回调
  /// [confirmClicked] 确定按钮点击回调
  static void show(BuildContext context, {
    String title = "",
    @required String content,
    bool showCancel = false,
    String cancelText = "cancel",
    String confirmText = "OK",
    VoidCallback cancelClicked,
    VoidCallback confirmClicked,
  }) {
    final titleText = title.isEmpty ? "注意" : title;
    var titleView = Text(titleText, textAlign: TextAlign.center, style: _titleSytle);
    var contentTextView = Text(content, textAlign: TextAlign.center, style: _contentSytle);

    var actions = List<Widget>();
    if (showCancel) {
      var cancelAction = Expanded(
        child: FlatButton(
          child: Text(cancelText, style: TextStyle(fontSize: kButtonFontSize)),
          textColor: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
            cancelClicked?.call();
          },
        ),
      );
      actions.add(cancelAction);
    }
    var confirmAction = Expanded(
      child: FlatButton(
        child: Text(confirmText, style: TextStyle(fontSize: kButtonFontSize)),
        textColor: Color(0xFF057CFF),
        onPressed: () {
          Navigator.of(context).pop();
          confirmClicked?.call();
        },
      ),
    );
    actions.add(confirmAction);

    var contentView = [
      contentTextView,
      SizedBox(height: kCommonMargin * 1.5),
      Divider(height: 2, color: Color(0xFFDDDDDD)),
      Container(
        height: 40,
        child: Row(
          mainAxisAlignment: actions.length > 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: actions,
        ),
      )
    ];

    var simpleDialog = SimpleDialog(
      title: titleView,
      titlePadding: EdgeInsets.fromLTRB(kCommonMargin, kCommonMargin * 1.5, kCommonMargin, 0.0),
      children: contentView,
      contentPadding: EdgeInsets.fromLTRB(kCommonMargin * 2, kCommonMargin, kCommonMargin * 2, kCommonMargin),
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(kCornerRadius))
      ),
    );
    showDialog(context: context, barrierDismissible: false, builder: (context) => simpleDialog);
  }

  // MARK: Private Method

  static TextStyle get _titleSytle =>
      TextStyle(color: Color(0xFF616161), fontSize: kTitleFontSize);

  static TextStyle get _contentSytle =>
      TextStyle(color: Color(0xFFBABABA), fontSize: kContentFontSize);


}
