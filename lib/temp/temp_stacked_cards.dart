// import 'package:flutter/material.dart';

// class StackedCardsScreen extends StatefulWidget {
//   const StackedCardsScreen({super.key});

//   @override
//   State<StackedCardsScreen> createState() => _StackedCardsScreenState();
// }

// class _StackedCardsScreenState extends State<StackedCardsScreen> {
//   int selectedIndex = 0;

//   final List<Color> colors = [
//     const Color(0xFFE8D79B), // Work
//     const Color(0xFF8EB6D6), // Personal
//     const Color(0xFF8EE0A1), // Inbox
//   ];

//   final List<String> titles = [
//     "WORK",
//     "PERSONAL",
//     "INBOX",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: List.generate(colors.length, (index) {
//           return AnimatedPositioned(
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeInOut,
//             top: _getTopPosition(index),
//             left: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: _buildCard(index),
//             ),
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   double _getTopPosition(int index) {
//     if (index == selectedIndex) {
//       return 80;
//     } else if (index < selectedIndex) {
//       return 80 + (index * 60);
//     } else {
//       return 80 + (index * 80);
//     }
//   }

//   Widget _buildCard(int index) {
//     return Container(
//       height: MediaQuery.of(context).size.height - 100,
//       decoration: BoxDecoration(
//         color: colors[index],
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(30),
//         ),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             titles[index],
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 20),
//           if (index == 0) _buildWorkContent(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkContent() {
//     return Column(
//       children: const [
//         ListTile(
//           leading: Icon(Icons.check_box_outline_blank),
//           title: Text("Design review with Dan"),
//         ),
//         ListTile(
//           leading: Icon(Icons.check_box),
//           title: Text(
//             "Add shot on Dribbble",
//             style: TextStyle(decoration: TextDecoration.lineThrough),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.check_box_outline_blank),
//           title: Text("Meet with April Janson"),
//         ),
//       ],
//     );
//   }
// }
