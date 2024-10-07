import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:wide_vpn/pages/home.dart';

class AvailableServer extends StatelessWidget {
  const AvailableServer({
    super.key,
    required this.flag,
    required this.country,
    required this.ping,
    required this.wifiQuality,
    required this.ip,
  });

  final String flag;
  final String country;
  final int ping;
  final IconData wifiQuality;
  final String ip;


  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Row(
        children: [
          Text(flag),
          const SizedBox(width: 5,),
          Text(country)
        ],
      ),
      subtitle: Text(ip),
      trailing: Row(
        children: [
          Text(ping.toString()),
          const SizedBox(width: 10,),
          Icon(wifiQuality, color: CupertinoColors.black, size: 20,),
        ],
      ),
      backgroundColorActivated: CupertinoColors.inactiveGray,
      onTap: () => Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => WideVpnHomePage(connectIp: ip))),
    );
  }
}

class SavedServer extends StatelessWidget {
  const SavedServer({
    super.key,
    required this.remark,
    required this.ip,
    required this.port,
    required this.parser,
  });

  final String? remark;
  final String ip;
  final String port;
  final V2RayURL parser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoContextMenu(
        actions: [
          CupertinoContextMenuAction(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: parser.url));
              Navigator.pop(context);
            },
            trailingIcon: CupertinoIcons.doc_on_clipboard,
            child: const Text("copy link"),
          )
        ],
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
              color: const CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.darkBackgroundGray,
                  darkColor: CupertinoColors.white
              ),
              shape: BoxShape.rectangle
          ),
          child: CupertinoButton(
              onPressed: null,
              child: CupertinoListTile(
                title: Text(
                    "$remark",
                    style: const TextStyle(
                      color: CupertinoDynamicColor.withBrightness(
                        color: CupertinoColors.white,
                        darkColor: CupertinoColors.black
                      ),
                    ),
                ),
                subtitle: Text(
                    "$ip:$port",
                    style: const TextStyle(
                      color: CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white,
                      darkColor: CupertinoColors.black
                      ),
                    )
                ),
                additionalInfo: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => WideVpnHomePage(parser: parser, connectIp: null,)));
                  },
                  child: const Icon(
                    CupertinoIcons.arrowtriangle_right,
                    size: 37,
                    color: CupertinoColors.activeGreen,
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}