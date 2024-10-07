import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import '../widgets/available_servers.dart';
import '../widgets/storage.dart';


class AvailableServers {
  static var randomInt = Random().nextInt;
  List<String> flags = ["🇷🇺", "🇺🇸", "🇨🇦", "🇳🇱", "🇯🇵", "🇰🇿"];
  List<String> countries = [
    "Russia",
    "USA",
    "Canada",
    "Netherlands",
    "Japan",
    "Kazakhstan"
  ];

  Future<List<AvailableServer>> getServers() async {
    var servers = <AvailableServer>[];

    for (var i = 0; i < 10; i++) {
      var ping = randomInt(150) + 50;
      var ipList = List<int>.generate(4, (int index) => randomInt(255));
      var ip = ipList.map((e) => e.toString()).join(".");
      var countryIndex = randomInt(countries.length);
      var country = countries[countryIndex];
      var flag = flags[countryIndex];
      IconData wifiQuality = (ping < 120) ? CupertinoIcons.wifi : CupertinoIcons
          .wifi_exclamationmark;

      servers.add(
          AvailableServer(
            flag: flag,
            country: country,
            ping: ping,
            wifiQuality: wifiQuality,
            ip: ip,
          )
      );
    }

    return servers;
  }
}

class SavedServers {
  Future<List<SavedServer>> getSavedServers() async {
    var servers = <SavedServer>[];
    var links = await Storage.getSavedLinks();
    
    for (var link in links) {
      var parser = FlutterV2ray.parseFromURL(link);
      servers.add(
        SavedServer(
          remark: parser.remark,
          ip: parser.address,
          port: parser.inbound["port"].toString(),
          parser: parser,
        )
      );
    }

    return servers;
  }

  static Future<void> getLinkFromUser(context) async {
    final TextEditingController tokenController = TextEditingController();
    String? link;

    showCupertinoDialog(context: context, builder: (BuildContext context)
    {
      return CupertinoAlertDialog(
        title: const Text('Добавление ссылки'),
        content: CupertinoTextField(controller: tokenController),
        actions: [
          CupertinoDialogAction(
            child: const Text('Назад'),
            onPressed: () {
              tokenController.clear();
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('Добавить'),
            onPressed: () async {
              link = tokenController.text;
              tokenController.clear();
              Navigator.of(context).pop();
              await addNewServer(context, link);
            },
          ),
        ],
      );
    }
    );
  }

  static Future<void> addNewServer(context, String? link) async {
    link ??= (await Clipboard.getData('text/plain'))?.text?.trim() ?? '';
    V2RayURL parser;

    try {
      parser = FlutterV2ray.parseFromURL(link);
    } catch (error) {
      await getLinkFromUser(context);
      return;
    }

    await Storage.addLink(link);
  }
}
