import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
