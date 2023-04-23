import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/home_page.dart';
import 'package:wardrobe/store.dart';
import '../../dao/clothes_dao.dart';
import '../../dao/suit_dao.dart';
import '../../dao/user_dao.dart';
import '../../model/User.dart';
import '../../utils/color.dart';
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
      // ignore: use_build_context_synchronously
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
    late User user;
    if (_formKey.currentState!.validate()) {
      // 1. log in
      UserDao.login(_email, _password).then((res) {
        user = res;
        Provider.of<StoreProvider>(context, listen: false).setUser(user);

        // 2. get clothes wardrobe
        ClothesDao.getAllClothes(user.id).then((clothesWardrobe) {
          Provider.of<StoreProvider>(context, listen: false)
              .setClothesWardrobe(clothesWardrobe);

          // 3. get all suits
          SuitDao.getAllSuits(user.id).then((suitList) {
            Provider.of<StoreProvider>(context, listen: false)
                .setSuitList(suitList);
            print(suitList);

            Fluttertoast.showToast(
                msg: '登录成功！',
                gravity: ToastGravity.CENTER,
                textColor: Colors.grey);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(user: user),
              ),
            );
          });
        });
      });
    }
  }

  // task1: log in

  // task 2: get clothe wardrobe

  // task 3: get suit list

  void _signup() {
    Navigator.push(
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
        body: Stack(
      children: [
        Container(
          height: 310,
          decoration: const BoxDecoration(
            // color: green,
            image: DecorationImage(
              image: AssetImage('assets/images/login.png'), // 设置背景图片
              fit: BoxFit.fitWidth, // 设置背景图片的填充方式
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(50, 260, 50, 50),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                      text: 'Hello \nCloud Wardrobe :)',
                      style: TextStyle(
                          color: darkGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                ))),
        Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 330, 50, 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Email Address'),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // decoration: const InputDecoration(
                  //   hintText: 'Input your email address:',
                  // ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please input your email address.';
                    } else if (!isEmail(value)) {
                      return 'Email address incorrect!';
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
                const SizedBox(height: 16.0),
                const Text('Password'),
                TextFormField(
                  obscureText: true,
                  // decoration: const InputDecoration(
                  //   hintText: 'Input your password:',
                  // ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please input your password.';
                    } else if (value.length < 6) {
                      return 'The length of your password should be greater than 6.';
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
                const SizedBox(height: 16.0),
                // ...
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Log in'),
                      ),
                    ),
                  ]),
                ),
                // const SizedBox(height: 16.0),
                // ...
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: green,
                        ),
                        child: const Text('Sign up'),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
