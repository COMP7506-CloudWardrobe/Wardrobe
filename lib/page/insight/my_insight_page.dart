import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/share_dao.dart';

import '../../model/Share.dart';
import '../../model/Suit.dart';
import '../../store.dart';
import '../../utils/color.dart';
import '../../utils/url.dart';

class MyInsightPage extends StatefulWidget {
  const MyInsightPage({super.key});

  @override
  State<MyInsightPage> createState() => _MyInsightPageState();
}

class _MyInsightPageState extends State<MyInsightPage> {
  late List<Share> _shareList;

  void _delete(Share share) {
    ShareDao.deleteShare(share.shareId);
    Provider.of<StoreProvider>(context, listen: false).deleteShare(share);
  }

  @override
  Widget build(BuildContext context) {
    _shareList =
        Provider.of<StoreProvider>(context, listen: true).getMyShareList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Insights'),
      ),
      body: _shareList.isNotEmpty
          ? ListView.builder(
              itemCount: _shareList.length, // 替换为您的数据列表的长度
              itemBuilder: (BuildContext context, int index) {
                Share share = _shareList[index]; // 替换为您的实际数据获取方式
                String url = getSuitImageURL(share.suitId, share.userId);

                return Card(
                  child: Column(children: [
                    Stack(children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/login.png'),
                        ),
                        title: Text(share.userName),
                        subtitle: Text(share.shareTime),
                      ),
                      Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: IconButton(
                            color: green,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _delete(share),
                          ))
                    ]),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(url), // 图片的网络图片
                          fit: BoxFit.scaleDown, // 图片适应方式
                        ),
                      ),
                    )
                  ]),
                );
              },
            )
          : Container(
                  color: Colors.white,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text('Go and share your first insight!'))),
    );
  }
}
