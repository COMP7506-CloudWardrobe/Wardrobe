import 'package:flutter/material.dart';
import 'account/login_page.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'data/UserModel.dart';


void main() async{
  final db = mongo.Db('mongodb://localhost:27017/mydb');
  await db.open();

  runApp(MultiProvider(
    providers: [
      Provider<mongo.Db>.value(value: db),
      ChangeNotifierProvider(create: (_) => UserModel(db)),
    ],
    child: MyApp(),
  ),);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      home: LoginPage(),
    );
  }
}
