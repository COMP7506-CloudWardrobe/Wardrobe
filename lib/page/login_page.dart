import 'package:flutter/material.dart';
import 'package:wardrobe/home_page.dart';
import '../model/User.dart';
import '../dao/user_dao.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '123';
  String _password = '';

  bool isEmail(String input) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(input);
  }

  void _submit() {
    if(_formKey.currentState!.validate()) {
      UserDao.login(_email, _password).then((result) {
        // 如果登录成功，则跳转到主页并传递用户凭据
        print("-------test--------");
        // print(_email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: result),
          ),
        );
      });
    }
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
            ],
          ),
        ),
      ),
    );
  }
}
