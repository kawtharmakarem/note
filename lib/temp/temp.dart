// PageView.builder(
//   itemCount: pages.length,
//   controller: PageController(),
//   itemBuilder: (context, index) {
//     return AnimatedBuilder(
//       animation: PageController(),
//       builder: (context, child) {
//         return Transform(
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.001)
//             ..rotateY(0.0),
//           alignment: Alignment.center,
//           child: child,
//         );
//       },
//       child: PageWidget(content: pages[index]),
//     );
//   },
// );
//  =======================================================================
//  dependencies:
//   page_turn: ^2.0.0
// ==========================================================
// PageTurn(
//   backgroundColor: Colors.white,
//   lastPage: Container(
//     color: Colors.white,
//     child: Center(child: Text("The End")),
//   ),
//   children: [
//     BookPage(text: "Page 1"),
//     BookPage(text: "Page 2"),
//     BookPage(text: "Page 3"),
//   ],
// );
// ===================================================================
// class BookPage extends StatelessWidget {
//   final String text;
//   const BookPage({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       color: Colors.white,
//       child: Text(text, style: TextStyle(fontSize: 22)),
//     );
//   }
// }
// ==================================================
// GestureDetector(
//   onPanUpdate: (details) {
//     setState(() {
//       dragX = details.localPosition.dx;
//     });
//   },
//   child: Transform(
//     alignment: Alignment.centerLeft,
//     transform: Matrix4.identity()
//       ..setEntry(3, 2, 0.001)
//       ..rotateY(-dragX / 300),
//     child: pageWidget,
//   ),
// );
// ==========================================
import 'package:flutter/material.dart';

class StackedCards extends StatefulWidget {
  const StackedCards({super.key});

  @override
  State<StackedCards> createState() => _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> {
  List<Color> cards = [Colors.red, Colors.green, Colors.blue, Colors.orange];
  void bringToTop(int index) {
    setState(() {
      final selectedCard = cards.removeAt(index);
      cards.add(selectedCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(cards.length, (index) {
            return Positioned(
              top: index * 20, // stacked effect
              child: GestureDetector(
                onTap: () => bringToTop(index),
                child: Card(
                  elevation: 8,
                  child: Container(
                    width: 200,
                    height: 300,
                    color: cards[index],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


// 💎 If You Have Custom Card Objects
// If your cards are objects:

// List<MyCardModel> cards = [];
// Same logic:

// void bringToTop(MyCardModel card) {
//   setState(() {
//     cards.remove(card);
//     cards.add(card);
//   });
// }

