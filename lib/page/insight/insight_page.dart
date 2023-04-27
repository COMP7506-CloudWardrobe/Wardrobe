import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/collect_dao.dart';
import 'package:wardrobe/dao/share_dao.dart';

import '../../model/Share.dart';
import '../../model/Suit.dart';
import '../../store.dart';
import '../../utils/color.dart';
import '../../utils/url.dart';
import 'my_insight_page.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  late List<Share> _shareList;

  late List<Suit> _suitList;

  late List<Share> _collections;

  late int _userId;

  late int? selectedIndex;

  Future<void> fetchData() async {
    ShareDao.getAllShares().then((shareList) =>
        Provider.of<StoreProvider>(context, listen: false)
            .setAllShares(shareList));
  }

  void addNewShare(Share share) {
    Provider.of<StoreProvider>(context, listen: false).addShare(share);
  }

  void showFormDialog(BuildContext context) {
    final selectedNotifier = ValueNotifier<int?>(null);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Column(
                children: [
                  _suitList.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: _suitList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedNotifier.value = index;
                                },
                                child: ValueListenableBuilder<int?>(
                                  valueListenable: selectedNotifier,
                                  builder: (context, selectedIndex, _) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: selectedIndex == index
                                              ? gold
                                              : Colors.transparent,
                                          width: selectedIndex == index
                                              ? 2.0
                                              : 0.0,
                                        ),
                                      ),
                                      child: Image.network(
                                        getSuitImageURL(
                                            _suitList[index].suitId, _userId),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Container(
                              color: Colors.white,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: Text('Nothing to share :)')))),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            if (selectedNotifier.value != null) {
                              ShareDao.shareSuit(_userId,
                                      _suitList[selectedNotifier.value!].suitId)
                                  .then((share) => addNewShare(share));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _my_shares() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyInsightPage(),
      ),
    );
  }

  void _collect(Share share) {
    CollectDao.collect(share.shareId, _userId);
    Provider.of<StoreProvider>(context, listen: false).collect(share);
  }

  void _delete(Share share) {
    CollectDao.deleteCollect(share.shareId, _userId);
    Provider.of<StoreProvider>(context, listen: false)
        .deleteCollect(share.shareId);
  }

  @override
  Widget build(BuildContext context) {
    _shareList =
        Provider.of<StoreProvider>(context, listen: true).getShareList();

    _collections =
        Provider.of<StoreProvider>(context, listen: true).getCollections();

    _suitList = Provider.of<StoreProvider>(context, listen: true).getSuitList();

    _userId = Provider.of<StoreProvider>(context, listen: true).user.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: _my_shares,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: _shareList.isNotEmpty
            ? ListView.builder(
                itemCount: _shareList.length, // 替换为您的数据列表的长度
                itemBuilder: (BuildContext context, int index) {
                  Share share = _shareList[index]; // 替换为您的实际数据获取方式
                  String url = getSuitImageURL(share.suitId, share.userId);

                  bool collected = _collections
                      .any((element) => element.shareId == share.shareId);

                  final collectedNotifier = ValueNotifier<bool>(collected);

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
                                icon: collectedNotifier.value
                                    ? const Icon(Icons.star)
                                    : const Icon(Icons.star_outline_rounded),
                                onPressed: () {
                                  if (collectedNotifier.value) {
                                    _delete(share);
                                  } else {
                                    _collect(share);
                                  }
                                  collectedNotifier.value =
                                      !collectedNotifier.value;
                                }))
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
                    child: Text('Go and share your insight!'))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormDialog(context);
        },
        backgroundColor: green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
