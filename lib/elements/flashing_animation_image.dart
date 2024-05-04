import 'package:flutter/material.dart';

import 'package:guruguru_klee_flutter/models/character_model.dart';
import 'dart:math';

class FlashingAnimationImage extends StatefulWidget {
  final int idIndex;
  FlashingAnimationImage({required this.idIndex});

  @override
  State<StatefulWidget> createState() => FlashingAnimationImageState();
}

class FlashingAnimationImageState extends State<FlashingAnimationImage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final int chAniRandom = Random().nextInt(5) + 1;

  @override
  Widget build(BuildContext context) {
    _animation = Tween(
            begin: Offset((MediaQuery.of(context).size.width) / 200, 0),
            end: Offset(-(MediaQuery.of(context).size.width) / 200, 0))
        .animate(_controller);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    // player.play();
    //   await player.resume();
    // });

    _animation.addStatusListener((status) {
      // if(status == AnimationStatus.completed) {
      //
      // }
      // if (status == AnimationStatus.completed) {
      //   // context.dispose();
      //   print("Object completed");
      //   dispose();
      // }
    });
    return SlideTransition(
        position: _animation,
        child: SizedBox(
          height: 200,
          child: Image(
              image: AssetImage(
                  "assets/${ChModel.characters[widget.idIndex].engName}/img/animation/${chAniRandom.toString()}.gif")),
        ));
  }
}
