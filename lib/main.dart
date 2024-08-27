import 'package:flutter/material.dart';

/// Flutter code sample for [AppBar].

List<String> titles = <String>[
  'Activity',
  'Add Activity',
];

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 0, 89, 255),
          useMaterial3: true),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 2;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CFaaL'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: titles[0],
              ),
              Tab(
                text: titles[1],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("Tab 1"),
            ),

            // Second tab
            Center(
              child: Text("Tab 2"),
            ),
          ],
        ),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment:
        //         MainAxisAlignment.center, // Center the column vertically
        //     crossAxisAlignment:
        //         CrossAxisAlignment.center, // Center the children horizontally
        //     children: <Widget>[
        //       ElevatedButton(
        //         onPressed: () {
        //           // Define the action for the first button here
        //           print('Button 1 pressed');
        //         },
        //         child: const Text('Add activity'),
        //       ),
        //       const SizedBox(
        //           height: 100,
        //           child: TextField(
        //             decoration: InputDecoration(
        //               labelText: 'Name',
        //             ),
        //           )), // Add spacing between buttons
        //       const SizedBox(
        //         height: 100,
        //         child: TextField(
        //           decoration: InputDecoration(
        //             labelText: 'Activity',
        //           ),
        //         ),
        //       ), // Add spacing between buttons
        //       SizedBox(
        //           height: 100,
        //           child: TextField(
        //             decoration: const InputDecoration(
        //                 labelText: "Minutes",
        //                 contentPadding: EdgeInsets.symmetric(
        //                   horizontal: 100.0,
        //                 ),
        //                 border: OutlineInputBorder()),
        //             keyboardType: TextInputType.number,
        //             inputFormatters: <TextInputFormatter>[
        //               FilteringTextInputFormatter.digitsOnly
        //             ], // Only numbers can be entered
        //           )), // Add spacing between buttons
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
