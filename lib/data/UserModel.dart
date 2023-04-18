import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  final mongo.Db _db;

  UserModel(this._db);

  Future<void> addUser(String email, String pwd, String id) async {
    final collection = _db.collection('users');
    await collection.insertOne({'email': email, 'pwd': pwd, 'id': id});
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final collection = _db.collection('users');
    final results = await collection.find().toList();
    return results.map((doc) => doc as Map<String, dynamic>).toList();
  }
}
