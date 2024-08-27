import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CFaaL',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
          ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class AddActivity {
  String name;
  String activity;
  int minutes;
  AddActivity(
      {required this.name, required this.activity, required this.minutes});
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedDropdownValue;

  final TextEditingController _firstTextController = TextEditingController();
  final TextEditingController _secondTextController = TextEditingController();
  final List<AddActivity> _activities = []; // <-- List to manage activities

  final List<String> _dropdownItems = ['Run', 'Walk', 'Weight Lifting', 'Swim'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addActivity() {
    final name = _firstTextController.text;
    final activity = _selectedDropdownValue;
    final minutes = int.tryParse(_secondTextController.text) ?? 0;

    if (name.isNotEmpty && activity != null && minutes > 0) {
      setState(() {
        _activities
            .add(AddActivity(name: name, activity: activity, minutes: minutes));
      });

      // Clear input fields
      _firstTextController.clear();
      _secondTextController.clear();
      setState(() {
        _selectedDropdownValue = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        centerTitle: true,
        title: Image.asset(
          '../images/logo2.jpg',
          height: 200,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Activities'),
            Tab(text: 'Add Activity'),
          ],
          indicatorColor: Color.fromARGB(252, 37, 101, 240),
          labelColor: Color.fromARGB(252, 37, 101, 240),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Activities Tab
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Activity')),
                  DataColumn(label: Text('Minutes')),
                ],
                rows: _activities.map((activity) {
                  return DataRow(
                    cells: [
                      DataCell(Text(activity.name)),
                      DataCell(Text(activity.activity)),
                      DataCell(Text(activity.minutes.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Add Activity Tab
          Padding(
            padding: const EdgeInsets.all(
                20.0), // Adjusted padding for better layout
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _firstTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedDropdownValue,
                  hint: const Text('Activity'),
                  items: _dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDropdownValue = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _secondTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Minutes',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _addActivity,
                    child: const Text('Add Activity'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
