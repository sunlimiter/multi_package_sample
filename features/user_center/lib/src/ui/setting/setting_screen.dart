import 'package:flutter/material.dart';
import 'package:user_center/src/widget/item_card.dart';

///author: lty
////Time: 2022/10/25
////Description:
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget _arrow() {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     if (context.canPop()) {
        //       context.pop();
        //     }
        //   },
        // ),
      ),
      body: Container(
        color: (brightness == Brightness.light) ? const Color(0xFFF7F7F7) : const Color(0xFF000000),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: (brightness == Brightness.light) ? const Color(0xFFF7F7F7) : const Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'App Settings',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Settings Item 01',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {},
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Others',
                        style: TextStyle(fontFamily: 'NotoSansJP', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Settings Item 02',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 03',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 04',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 05',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 06',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 07',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {},
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ItemCard(
                      title: 'Settings Item 08',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {},
                    ),
                    ItemCard(
                      title: 'Settings Item 09',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      callback: () {},
                      textColor: Colors.red,
                    ),
                    ItemCard(
                      title: 'version',
                      color: (brightness == Brightness.light) ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: const Center(
                        child: Text('1.0.0',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      callback: () {},
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
