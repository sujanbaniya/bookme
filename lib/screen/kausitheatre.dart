// Combined Flutter UI for Theater Seat Booking
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(home: KaushiTheater()));

class KaushiTheater extends StatefulWidget {
  const KaushiTheater({super.key});

  @override
  State<KaushiTheater> createState() => _KaushiTheaterState();
}

class _KaushiTheaterState extends State<KaushiTheater> {
  // Shared Data
  late final List<String> dates;
  late String selectedDate;
  String? selectedTimeSlot;

  final Map<String, List<String>> timeSlotsByDate = {};

  int selectedDateIndex = 0;
  String selectedTime = "05:30 AM";
  final timeError = true;
  int selectedSeats = 3;
  final int pricePerSeat = 300;

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

  bool _isToday(String formattedDate) {
    final today = DateFormat('EEE, MMM dd', 'en_US').format(DateTime.now());
    return formattedDate == today;
  }

  void bookNow() {
    if (selectedTimeSlot == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select time.')));
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
          "Seats: $selectedSeats",
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
    final totalAmount = selectedSeats * pricePerSeat;
    final currentSlots = timeSlotsByDate[selectedDate] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theater Booking'),
        backgroundColor: const Color.fromARGB(255, 171, 168, 168),
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKarSbm7FPISL0BS_0rg5BvmVtwTrSkA8l5A&s',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _infoTile(Icons.location_on, "Location", "Kathmandu", null),
                _infoTile(Icons.web, "Website", "Visit", () {
                  launchURL(
                    context,
                    'https://www.facebook.com/durbar.moments/',
                  );
                }),
                _infoTile(Icons.access_time, "Hours", "10AM - 10PM", null),
                _infoTile(Icons.people, "Capacity", "250", () {}),
                _infoTile(Icons.info_outline, "About", "Details", () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("About Kausi theater"),
                      content: const Text(""),
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
              "Kausi Theater",
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
            const Text(
              "📅 Select Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedDateIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(dates[index]),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedDateIndex = index;
                          selectedDate = dates[index];
                          selectedTimeSlot = null;
                        });
                      },
                      selectedColor: Colors.lightBlueAccent,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "⏰ Select Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: currentSlots.map((slot) {
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
                        color: isSelected
                            ? Colors.deepPurple
                            : Colors.grey.shade300,
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
            ),
            if (timeError && _isToday(selectedDate))
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '*Invalid time\nPlease select a future time for today\'s booking',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),

            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.network(
                    'https://stbackend.bookmeworld.com/uploads/2025-07-07T07-14-06.525ZScreenshot 2025-07-07 125851.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // ignore: deprecated_member_use
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "🎭 Theatre Seating",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Premium theatre experience with comfortable seating",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "🪑 Select Number of Seats",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  seatInfoRow("Total Seats", "100"),
                  seatInfoRow("Price per Seat", "Rs. 300"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        "Number of Seats",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      DropdownButton<int>(
                        value: selectedSeats,
                        items: List.generate(10, (index) => index + 1)
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSeats = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  seatInfoRow("🎟️ Selected Seats", "$selectedSeats"),
                  seatInfoRow(
                    "💰 Total Amount:",
                    "Rs. $totalAmount",
                    bold: true,
                  ),
                ],
              ),
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

Widget seatInfoRow(String title, String value, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Future<void> launchURL(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
  }
}
