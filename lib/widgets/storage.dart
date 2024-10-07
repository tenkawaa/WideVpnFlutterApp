import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>> getSavedLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList("links") ?? []);
  }

  static Future<void> addLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> links = (prefs.getStringList('links') ?? []);
    if (!links.contains(link)) {
      links.add(link);
      await prefs.setStringList('links', links);
    }
  }
}