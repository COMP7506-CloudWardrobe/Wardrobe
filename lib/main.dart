import 'package:flutter/material.dart';
import 'package:wardrobe/store.dart';
import 'package:wardrobe/utils/color.dart';
import 'page/account/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => StoreProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: green, // 指定主色为 Color(0xFF233A42)
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: MaterialColor(green.value, {
            50: green.withOpacity(0.1),
            100: green.withOpacity(0.2),
            200:green.withOpacity(0.3),
            300: green.withOpacity(0.4),
            400: green.withOpacity(0.5),
            500: green.withOpacity(0.6),
            600: green.withOpacity(0.7),
            700: green.withOpacity(0.8),
            800: green.withOpacity(0.9),
            900: green.withOpacity(1.0),
          }))),
      home: LoginPage(),
    );
  }
}
