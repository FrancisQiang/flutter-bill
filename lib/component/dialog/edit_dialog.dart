import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final Function onPositive;
  final bool positiveWithPop;
  final String title;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final TextStyle cancelTextStyle;
  final TextStyle sureTextStyle;

  const EditDialog({
    Key key,
    this.onPositive,
    this.title,
    this.hintText,
    this.initialValue,
    this.onValueChanged,
    this.cancelTextStyle,
    this.sureTextStyle,
    this.positiveWithPop = true,
  }) : super(key: key);


  static GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController(text: initialValue);
    _textEditingController.selection = TextSelection(baseOffset: initialValue.length, extentOffset: initialValue.length);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(title ?? ""),
      content: Form(
        key: _formKey,
        child: Theme(
          // Theme 组件是将 data 的主题赋值给child
          data: ThemeData(platform: TargetPlatform.iOS),
          child: TextFormField(
            controller: _textEditingController,
            cursorColor: Theme.of(context).primaryColorDark,
            validator: (result) => result.trim().length > 0 ? null : "The username cannot be none",
            decoration: InputDecoration(
              hintText: hintText ?? "",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColorLight,)
              )
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: cancelTextStyle ?? TextStyle(color: Colors.redAccent),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (onPositive != null && (_formKey.currentState as FormState).validate()) {
              onPositive(text: _textEditingController.text);
            }
            if(positiveWithPop && (_formKey.currentState as FormState).validate()) {
              Navigator.of(context).pop();
            }
          },
          child: Text('Ok',
              style: sureTextStyle ?? TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
