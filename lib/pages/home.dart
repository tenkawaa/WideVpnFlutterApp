import 'package:flutter/cupertino.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:wide_vpn/pages/saved_servers.dart';
import 'package:wide_vpn/pages/servers.dart';
import 'package:wide_vpn/pages/vpn_connection.dart';
import 'package:wide_vpn/theme/nav_bar.dart';

class WideVpnHomePage extends StatelessWidget {
  const WideVpnHomePage({
    super.key,
    this.parser,
    this.connectIp
  });

  final V2RayURL? parser;
  final String? connectIp;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 1,
        items: itemsAppBar,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const WideVpnSavedServers();
          case 1:
            return WideVpnConnectPage(connectIp: connectIp, parser: parser);
          case 2:
            return const WideVpnServersPage();
          default:
            return WideVpnConnectPage(connectIp: connectIp, parser: parser);
        }
      },
    );
  }
}