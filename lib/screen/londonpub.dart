// Enhanced London Pub Booking UI with Top-Notch Design
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Londonpub extends StatefulWidget {
  const Londonpub({super.key});

  @override
  State<Londonpub> createState() => _LondonpubState();
}

class _LondonpubState extends State<Londonpub> {
  late final List<String> dates;
  late String selectedDate;
  String? selectedTimeSlot;
  final List<String> selectedTables = [];

  final Map<String, List<String>> timeSlotsByDate = {};

  final List<Map<String, dynamic>> tables = [
    {"name": "Table A", "capacity": 4, "price": 3000},
    {"name": "Table B", "capacity": 6, "price": 2500},
  ];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    final formatter = DateFormat('EEE, MMM dd', 'en_US');

    dates = List.generate(7, (index) {
      final date = today.add(Duration(days: index));
      return formatter.format(date);
    });

    selectedDate = dates.first;

    for (var date in dates) {
      timeSlotsByDate[date] = ["10:00 AM", "12:00 PM", "2:00 PM", "4:00 PM"];
    }
  }

  void toggleTableSelection(String tableName) {
    setState(() {
      if (selectedTables.contains(tableName)) {
        selectedTables.remove(tableName);
      } else {
        selectedTables.add(tableName);
      }
    });
  }

  void bookNow() {
    if (selectedTimeSlot == null || selectedTables.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select time and at least one table.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Confirm Booking"),
        content: Text(
          "Date: $selectedDate\n"
          "Time: $selectedTimeSlot\n"
          "Tables: ${selectedTables.join(', ')}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking successful!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSlots = timeSlotsByDate[selectedDate] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("London Pub", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/londonpub.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _infoTile(Icons.location_on, "Location", "Kathmandu", null),
                _infoTile(Icons.web, "Website", "Visit", () {
                  launchURL(context, 'https://www.facebook.com/LondonPub.ktm/');
                }),
                _infoTile(Icons.access_time, "Hours", "10AM - 10PM", null),
                _infoTile(Icons.people, "Capacity", "2323", () {}),
                _infoTile(Icons.info_outline, "About", "Details", () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("About London Pub"),
                      content: const Text(
                        "A luxury lounge offering curated experiences.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "London Pub",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                RatingBarIndicator(
                  rating: 4.0,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 24.0,
                ),
                const SizedBox(width: 10),
                const Text("4.0", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 5),
                const Text("(0 reviews)", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 30),
            _sectionHeader(Icons.calendar_today_outlined, "Select Date"),
            const SizedBox(height: 10),
            _dateSelector(),
            const SizedBox(height: 24),
            _sectionHeader(Icons.access_time, "Select Time"),
            const SizedBox(height: 12),
            _timeSelector(currentSlots),
            const SizedBox(height: 24),
            _sectionHeader(Icons.groups_2, "Select Table(s)"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: tables.map((table) {
                return TableCard(
                  tableName: table['name'],
                  capacity: table['capacity'],
                  price: table['price'],
                  isAvailable: true,
                  isSelected: selectedTables.contains(table['name']),
                  onTap: () => toggleTableSelection(table['name']),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: bookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 29, 217),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _dateSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dates.map((date) {
        bool isSelected = date == selectedDate;
        return GestureDetector(
          onTap: () => setState(() {
            selectedDate = date;
            selectedTimeSlot = null;
          }),
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.teal.shade800 : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _timeSelector(List<String> slots) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        bool isSelected = slot == selectedTimeSlot;
        return GestureDetector(
          onTap: () => setState(() {
            selectedTimeSlot = slot;
          }),
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.purple.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Text(
              slot,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 110, // fixed width for equal spacing
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Colors.teal),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TableCard extends StatelessWidget {
  final String tableName;
  final int capacity;
  final int price;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback onTap;

  const TableCard({
    super.key,
    required this.tableName,
    required this.capacity,
    required this.price,
    required this.isAvailable,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tableName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("Capacity: $capacity"),
            Text("Price: रु$price"),
            const SizedBox(height: 4),
            Text(
              isAvailable ? "Available" : "Unavailable",
              style: TextStyle(
                color: isAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> launchURL(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
    }
  } catch (e) {
    ScaffoldMessenger.of(
      // ignore: use_build_context_synchronously
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  }
}
