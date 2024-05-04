import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:guruguru_klee_flutter/elements/flashing_animation_image.dart';
import 'package:guruguru_klee_flutter/elements/bottom_app_bar.dart';

import 'package:guruguru_klee_flutter/models/character_model.dart';
import 'package:guruguru_klee_flutter/pages/info_page.dart';
import 'package:provider/provider.dart';
import 'dart:math';

// bool isShowBottomSheet = false;
bool isNowPlaying = false;
int nowCharacteridIndex = 0;
String audioLang = "CN";

class ChData with ChangeNotifier {
  int nowCharacterIndex = 0;
  Character nowCharacter = ChModel.characters[0];
  List<int> clicktime = [0, 0, 0, 0, 0];

  void addClickNum() {
    clicktime[nowCharacterIndex]++;
    notifyListeners();
  }

  void changeCharacter(int index) {
    nowCharacterIndex = index;
    nowCharacteridIndex = index;
    nowCharacter = ChModel.characters[index];
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    // debugPaintSizeEnabled = true;

    return ChangeNotifierProvider(
        create: (context) => ChData(),
        child: MaterialApp(
          title: 'guruguru Klee',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ));
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("嘿！"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          },
          icon: const Icon(Icons.info_outline_rounded),
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
      body: Center(child: _BodyContainer()),
      floatingActionButton:  _FloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}

class _BodyContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyContainerState();
  }
}

class _BodyContainerState extends State<_BodyContainer> {
  List<Widget> animationList = [];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Consumer<ChData>(
          builder: (__, chData, child) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            // image: AssetImage(5
                            //     "assets/${chData.nowCharacter.engName}/img/background.gif")),
                            image: AssetImage(
                                "assets/${chData.nowCharacter.engName}/img/background.gif"),
                            opacity: 0.3,
                            fit: BoxFit.contain),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ...animationList,
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: Text(
                                    "${chData.nowCharacter.name}已经${chData.nowCharacter.action}了",
                                    style: textTheme.displaySmall),
                              ),
                              // Text(context.selete),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 200, 0, 0),
                                    child: Text(
                                        chData
                                            .clicktime[chData.nowCharacterIndex]
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 50))),
                              ),
                              Text("次", style: textTheme.displaySmall),
                            ],
                          ),
                          // RunnerWidget(idIndex: chData.nowCharacterIndex),
                        ],
                      )),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    chData.addClickNum();
                    // TransAnimationTestState().imageAnimation(context);
                    setState(() {
                      animationList.add(
                          FlashingAnimationImage(idIndex: nowCharacteridIndex));
                      List<int> chAudioNum = [11, 9, 6, 8, 4];
                      int chAudioRandom = Random()
                              .nextInt(chAudioNum[nowCharacteridIndex] - 1) +
                          1;
                      AudioPlayer player = AudioPlayer();
                      Future playMusic() async {
                        player.play(AssetSource(
                            "${ChModel.characters[nowCharacteridIndex].engName}/audio/${audioLang}/${chAudioRandom.toString()}.mp3"));
                      }

                      ;

                      Future pauseMusic() async {
                        player.stop();
                      }

                      playMusic();
                    });
                  },
                  label: Text(chData.nowCharacter.actionLong),
                  icon: const Icon(Icons.alternate_email),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}

class _FloatingActionButton extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
          tooltip: 'Choose Person',
          child: const Icon(Icons.person),
          heroTag: "Choose Person",
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              showDragHandle: true,
              context: context,
              builder: (context) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Consumer<ChData>(
                    builder: (_, chData, child) {
                      return ListTile(
                        onTap: () {
                          chData.changeCharacter(index);
                          // print(chData.nowCharacterIndex + 1);
                          Navigator.pop(context);
                        },
                        leading: CircleAvatar(
                            child: Image(image: ChModel.characters[index].icon, height: 40,)),
                        title: Text(ChModel.characters[index].name),
                        subtitle:
                            Text(ChModel.characters[index].displayDescribeB),
                      );
                    },
                  ),
                  itemCount: 5,
                );
              },
            );
          }
      );
  }
}