import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 255, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate = DateTime.now();
  final DateTime _today = DateTime.now();

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month - 1,
        _selectedDate.day,
      );
    });
  }

  void _goToNextMonth() {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        _selectedDate.day,
      );
    });
  }

  void _goToCurrentMonth() {
    setState(() {
      _selectedDate = DateTime.now();
    });
  }

  void _goToPreviousYear() {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year - 1,
        _selectedDate.month,
        _selectedDate.day,
      );
    });
  }

  void _goToNextYear() {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year + 1,
        _selectedDate.month,
        _selectedDate.day,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _goToPreviousYear,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goToPreviousMonth,
              ),
              Text(
                '${_selectedDate.year} - ${_selectedDate.month}',
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _goToNextMonth,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _goToNextYear,
              ),
            ],
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            shrinkWrap: true,
            itemCount: DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day,
            itemBuilder: (context, index) {
              DateTime day = DateTime(_selectedDate.year, _selectedDate.month, index + 1);
              bool isToday = day.year == _today.year &&
                  day.month == _today.month &&
                  day.day == _today.day;
              bool isSelected = day.year == _selectedDate.year &&
                  day.month == _selectedDate.month &&
                  day.day == _selectedDate.day;

              return InkWell(
                onTap: () => _selectDate(day),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent.shade700),
                    borderRadius: BorderRadius.circular(8.0),
                    color: isSelected ? Colors.red : (isToday ? Colors.redAccent.shade700 : Colors.transparent),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isSelected || isToday ? Colors.white : Colors.redAccent.shade700,
                    ),
                  ),
                ),
              );
            },
          ),
          if (_selectedDate.month != DateTime.now().month ||
              _selectedDate.year != DateTime.now().year)
            ElevatedButton(
              onPressed: _goToCurrentMonth,
              child: const Text('Back to current month'),
            ),
        ],
      ),
    );
  }
}
