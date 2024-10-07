import 'package:flutter/cupertino.dart';
import 'package:wide_vpn/pages/home.dart';
import 'package:wide_vpn/pages/servers.dart';
import 'package:wide_vpn/theme/theme.dart';

void main() => runApp(const WideVpn());

class WideVpn extends StatelessWidget {
  const WideVpn({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: lightTheme,
      title: "Wide Vpn",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const WideVpnHomePage(),
        "/servers": (context) => const WideVpnServersPage(),
      },
    );
  }

}