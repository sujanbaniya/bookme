import 'package:bookmeworld/screen/durbarlounge.dart';
import 'package:bookmeworld/screen/londonpub.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoungeandPub extends StatelessWidget {
  const LoungeandPub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                const Text(
                  "Popular Lounge & Pubs",
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
                  "More Than Music — It's a Movement.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            BarWidget(
              title: "Durbar Lounge",
              subtitle: "Durbarmarg, Kathmandu",
              imagePath:
                  "https://scontent.fktm20-1.fna.fbcdn.net/v/t39.30808-6/456112405_832503872370144_4005081239197835263_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHV6WNaazT7wdsJPYbIQPvBJkgM24L0tI4mSAzbgvS0juUfVTO8QqL2iLz1TLztsNQ75SSfdUrP33b2bpkt8IBu&_nc_ohc=cUW511AFIz4Q7kNvwHJPeUH&_nc_oc=AdlFAyWTk0wJG3b2KKpkW5rDmDHsV_hB6vxJYnA9zUuo60X_klWHfHiOGt3cXLoxHTM&_nc_zt=23&_nc_ht=scontent.fktm20-1.fna&_nc_gid=bXTnOD-kz8xe_NDbIhwVXQ&oh=00_AfTt4ktx69rjGH0d1s32VL4OU5Qwkk2KJzzrVLOPSNPHmA&oe=68850781",
              destination: Durbarlounge(),
              price: "1000",
              rating: "4.5",
            ),
            BarWidget(
              title: "London Pub",
              subtitle: "Durbarmarg, Kathmandu",
              imagePath:
                  "https://scontent.fktm20-1.fna.fbcdn.net/v/t39.30808-6/516797720_1321763703290374_3532575389921474813_n.jpg?stp=dst-jpg_s960x960_tt6&_nc_cat=110&ccb=1-7&_nc_sid=cc71e4&_nc_eui2=AeGOUguvtHhIzriAYRLDbWXnUZoVIYF_BLZRmhUhgX8EtpS3eW9f1Mxwzsi8yp3E_MXtaLfESh8G8YFOVdTiBg9S&_nc_ohc=nru97UJvinEQ7kNvwHtgvCh&_nc_oc=AdkPgRjr-4lrMxUrTSpP0B-d5sj-NstCcXVFqn4mrDR78e9OX-n-B0yFSfT44v5oS_E&_nc_zt=23&_nc_ht=scontent.fktm20-1.fna&_nc_gid=gm_I86fdkojaOx-mAwym2A&oh=00_AfSvw1_bNpnzfG-E3pJO9o3SU8BmS7EYRuwXjWeargJM5A&oe=6884FA33", // Replace with your own image
              destination: Londonpub(),
              price: "2000",
              rating: "3.5",
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
                  child: CachedNetworkImage(
                    imageUrl: widget.imagePath,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.broken_image)),
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
