import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:url_launcher/url_launcher.dart";

class _ListViewItem {
  AssetImage headIcon;
  String title;
  String subtitle;

  bool canGoWeb;
  String link;

  _ListViewItem(this.headIcon, this.title, this.subtitle,
      [this.canGoWeb = false, this.link = ""]);
}

class InfoPage extends StatelessWidget {
  InfoPage({super.key});

  List<_ListViewItem> repoInfo = [
    _ListViewItem(AssetImage("assets/head_icon/flipwind_head_icon.png"), "Developer || @FlipWind",
        "https://github.com/FlipWind", true, "https://github.com/FlipWind"),
    _ListViewItem(
        AssetImage("assets/head_icon/github_head_icon.png"),
        "Github Repo",
        "https://github.com/VentiFans/guruguru-Klee",
        true,
        "https://github.com/VentiFans/guruguru-Klee"),
  ];

  List<_ListViewItem> forwardCreation = [
    _ListViewItem(
        AssetImage("assets/head_icon/duiqt_head_icon.png"),
        "创意来源 Source || @duiqt",
        "https://github.com/duiqt/herta_kuru",
        true,
        "https://github.com/duiqt/herta_kuru"),
    _ListViewItem(
        AssetImage("assets/head_icon/seseren_head_icon.png"),
        "插图作者 Artist || @Seseren",
        "https://twitter.com/Seseren_kr",
        true,
        "https://twitter.com/Seseren_kr"),
    _ListViewItem(
        AssetImage("assets/head_icon/genshin_klee_head_icon.png"),
        "创意前身/素材整理 ReBuild || @Klee",
        "https://github.com/genshinKlee/genshinKlee.github.io",
        true,
        "https://github.com/genshinKlee/genshinKlee.github.io"),
  ];

  List<String> disclaimer = [
    "Developer: FlipWind",
    "Based on flutter.dev",
    "Independent of ©miHoyo"
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
            child: Text(
              "  基本信息",
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            )),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image(image: repoInfo[index].headIcon, height: 40,),
              title: Text(repoInfo[index].title),
              subtitle: Text(repoInfo[index].subtitle),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                launchUrl(Uri.parse(repoInfo[index].link));
              },
            );
          },
          itemCount: repoInfo.length,
        ),
        Divider(),
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
            child: Text(
              "  前身",
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            )),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image(image: forwardCreation[index].headIcon,height: 40,),
              title: Text(forwardCreation[index].title),
              subtitle: Text(forwardCreation[index].subtitle),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                launchUrl(Uri.parse(forwardCreation[index].link));
              },
            );
          },
          itemCount: forwardCreation.length,
        ),
        Divider(),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 2),
            child: Text(
              "Developer: FlipWind",
              style: textTheme.titleSmall,
              textAlign: TextAlign.start,
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 2),
            child: Text(
              "Based on flutter.dev",
              style: textTheme.titleSmall,
              textAlign: TextAlign.start,
            )),
        
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 2),
            child: Text(
              "Independent of ©miHoyo",
              style: textTheme.titleSmall,
              textAlign: TextAlign.start,
            )),
      ]),
    );
  }
}
