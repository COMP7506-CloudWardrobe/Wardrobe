import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/home_page.dart';
import 'package:wardrobe/store.dart';
import '../../dao/user_dao.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '123';
  String _password = '';

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('存储权限被拒绝'),
            content: Text('需要存储权限以使用此应用程序的所有功能'),
            actions: <Widget>[
              TextButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('授权'),
                onPressed: () async {
                  openAppSettings();
                  Navigator.of(context).pop();
                  _requestPermissions();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool isEmail(String input) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(input);
  }

  void _submit() {
    if(_formKey.currentState!.validate()) {
      UserDao.login(_email, _password).then((result) {
        // 如果登录成功，则跳转到主页并传递用户凭据
        // print("-------test--------");
        // print(_email);
        Provider.of<StoreProvider>(context, listen: false).setUser(result);

        Fluttertoast.showToast(
            msg: '登录成功！',
            gravity: ToastGravity.CENTER,
            textColor: Colors.grey);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: result),
          ),
        );
      });
    }
  }

  void _signup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // ...
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('邮箱地址'),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: '请输入邮箱地址',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '请输入邮箱地址';
                  } else if (!isEmail(value)) {
                    return '请输入正确的邮箱地址';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16.0),
              Text('密码'),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '请输入密码',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '请输入密码';
                  } else if (value.length < 6) {
                    return '密码长度应为6位或以上';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              // ...
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text('登录'),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 16.0),
              // ...
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _signup,
                      child: Text('注册'),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
