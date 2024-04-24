import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/res/media_res.dart';
import 'package:fca_education_app/src/home/presentation/widgets/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TinderCards extends StatefulWidget {
  const TinderCards({super.key});

  @override
  State<TinderCards> createState() => _TinderCardsState();
}

class _TinderCardsState extends State<TinderCards>
    with TickerProviderStateMixin {
  final CardController cardController = CardController();

  int totalCards = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width,
      width: context.width,
      child: TinderSwapCard(
        cardController: cardController,
        totalNum: totalCards,
        swipeEdge: 4,
        maxWidth: context.width,
        maxHeight: context.width * .9,
        minWidth: context.width * .71,
        minHeight: context.width * .85,
        allowSwipe: false,
        swipeUpdateCallback: (details, align) {
          if (align.x < 0) {
            // card is LEFT swipping
          } else if (align.x > 0) {
            // card is RIGHT swipping
          }
        },
        swipeCompleteCallback: (cardSwipeOrientation, index) {
          if (index == totalCards - 1) {
            setState(() {
              totalCards += 1;
            });
          }
        },
        cardBuilder: (context, index) {
          final isFirst = index == 0;
          // ignore: lines_longer_than_80_chars
          final colorByIndex =
              index == 1 ? const Color(0xFFDA92FC) : const Color(0xFFDC95FB);
          return Stack(
            children: [
              Positioned(
                bottom: 110,
                right: 0,
                left: 0,
                child: TinderCard(
                  isFirst: isFirst,
                  color: isFirst ? null : colorByIndex,
                ),
              ),
            if (isFirst)
            Positioned(
              bottom: 130,
              right: 20,
              child: Image.asset(
                MediaResources.microScope,
                height: 180,
                width: 149,
      
              ),
            ),
            ],
          );
        },
      ),
    );
  }
}
