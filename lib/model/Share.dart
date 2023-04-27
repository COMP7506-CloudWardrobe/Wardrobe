import 'package:intl/intl.dart';

class Share {
  int userId;
  String userName;
  int shareId;
  int suitId;
  String shareTime;

  Share(
      {required this.userId,
      required this.shareId,
      required this.suitId,
      required this.shareTime,
      required this.userName});

  factory Share.fromJson(Map<String, dynamic> json) {
    return Share(
      suitId: json['suitId'],
      shareId: json['shareId'],
      userId: json['userId'],
      userName: json['userName'],
      shareTime: DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse(json['shareTime'])),
    );
  }

  String formatTime(DateTime time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
  }
}
