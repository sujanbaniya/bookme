import 'package:bookmeworld/screen/kausitheatre.dart';
import 'package:flutter/material.dart';

class TheaterPage extends StatelessWidget {
  const TheaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theater'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                const Text(
                  "Popular Theatres",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 3,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(
                      colors: [Colors.cyan, Colors.blueAccent],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Where Stories Come to Life",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            BarWidget(
              title: "Kausi Theatre",
              subtitle: "Teku, Kathmandu",
              imagePath:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKarSbm7FPISL0BS_0rg5BvmVtwTrSkA8l5A&s",
              destination: KaushiTheater(),
              price: "1000",
              rating: "4.5",
            ),
          ],
        ),
      ),
    );
  }
}

class BarWidget extends StatefulWidget {
  const BarWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.destination,
    required this.price,
    required this.rating,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final Widget destination;
  final String price;
  final String rating;

  @override
  State<BarWidget> createState() => _BarWidgetState();
}

class _BarWidgetState extends State<BarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.destination),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LeftHoverTextWidget(price: widget.price),
                  RightHoverTextWidget(rating: widget.rating),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xA70310C2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RightHoverTextWidget extends StatelessWidget {
  const RightHoverTextWidget({super.key, required this.rating});
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xA70310C2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24),
            const SizedBox(width: 6),
            Text(
              rating,
              style: const TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftHoverTextWidget extends StatelessWidget {
  const LeftHoverTextWidget({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xA70310C2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Text(
          "Rs. $price/-",
          style: const TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );
  }
}
