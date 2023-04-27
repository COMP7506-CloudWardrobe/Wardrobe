import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/collect_dao.dart';
import 'package:wardrobe/dao/share_dao.dart';

import '../../model/Share.dart';
import '../../model/Suit.dart';
import '../../store.dart';
import '../../utils/color.dart';
import '../../utils/url.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  late List<Share> _collections;

  late int _userId;

  void _delete(Share share) {
    CollectDao.deleteCollect(share.shareId, _userId);
    Provider.of<StoreProvider>(context, listen: false)
        .deleteCollect(share.shareId);
  }

  @override
  Widget build(BuildContext context) {
    _collections =
        Provider.of<StoreProvider>(context, listen: true).getCollections();

    _userId = Provider.of<StoreProvider>(context, listen: true).user.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collections'),
      ),
      body: _collections.isNotEmpty
          ? ListView.builder(
              itemCount: _collections.length, // 替换为您的数据列表的长度
              itemBuilder: (BuildContext context, int index) {
                Share share = _collections[index]; // 替换为您的实际数据获取方式
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
          : const Align(alignment: Alignment.center, child: Text('Go for your first collection!')),
    );
  }
}
