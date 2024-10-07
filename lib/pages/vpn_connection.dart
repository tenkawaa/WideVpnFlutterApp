import 'package:flutter/cupertino.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:wide_vpn/theme/nav_bar.dart';


class WideVpnConnectPage extends StatefulWidget {
  final String? connectIp;
  final V2RayURL? parser;

  const WideVpnConnectPage({
    super.key,
    this.parser,
    this.connectIp,
  });

  @override
  State<WideVpnConnectPage> createState() => _WideVpnConnectPageState();
}

class _WideVpnConnectPageState extends State<WideVpnConnectPage> {
  bool _isConnected = false;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );

  V2RayURL? parser;
  String? connectedIp;

  void disconnectVpn() {
    setState(() {
      _isConnected = false;
      connectedIp = null;
    });
    flutterV2ray.stopV2Ray();
  }

  Future<void> connectVpn() async {
    if (parser != null) {
      var remark = parser!.remark;
      var config = parser!.getFullConfiguration();
      bool proxyOnly = false;

      if (await flutterV2ray.requestPermission()) {
        flutterV2ray.startV2Ray(
            remark: remark,
            config: config,
            proxyOnly: proxyOnly
        );
      }
    }
  }

  @override
  void initState() {
    connectedIp = widget.connectIp;
    parser = widget.parser;

    if (parser != null) {
      connectVpn();
      setState(() {
        _isConnected = true;
        connectedIp = parser!.address;
      });
    } else if (connectedIp != null) {
        setState(() {
          _isConnected = true;
        }
      );
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: CupertinoButton(
                onPressed: () => {
                  if (_isConnected) {
                    disconnectVpn()
                  } else {
                    connectVpn()
                  }
                },
                child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        color: _isConnected ? CupertinoColors.activeGreen : CupertinoColors.systemRed,
                        shape: BoxShape.circle
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isConnected ? "connected" : "connect",
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          (connectedIp != null) ? connectedIp! : "",
                          style: const TextStyle(
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    )
                )
              ),
            ),
          ],
        )
      )
    );
  }

}