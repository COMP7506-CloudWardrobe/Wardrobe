import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe/dao/share_dao.dart';

import '../../model/Share.dart';
import '../../model/Suit.dart';
import '../../store.dart';
import '../../utils/color.dart';
import '../../utils/url.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  late List<Share> _shareList;

  late List<Suit> _suitList;

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
                  Expanded(
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
                                    width: selectedIndex == index ? 2.0 : 0.0,
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
                  ),
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

  @override
  Widget build(BuildContext context) {
    _shareList =
        Provider.of<StoreProvider>(context, listen: true).getShareList();

    _suitList = Provider.of<StoreProvider>(context, listen: true).getSuitList();

    _userId = Provider.of<StoreProvider>(context, listen: true).user.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: _shareList.length, // 替换为您的数据列表的长度
          itemBuilder: (BuildContext context, int index) {
            Share share = _shareList[index]; // 替换为您的实际数据获取方式
            String url = getSuitImageURL(share.suitId, share.userId);

            return Card(
              child: Column(children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/login.png'),
                  ),
                  title: Text(share.userName),
                  subtitle: Text(share.shareTime),
                ),
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
        ),
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
