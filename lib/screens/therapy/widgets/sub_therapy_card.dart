import 'package:flutter/material.dart';

class SubTherapyCard extends StatelessWidget {
  final String title;
  final String description; // tetap dipertahankan untuk kebutuhan data/route
  final IconData icon;
  final Color accentColor;

  const SubTherapyCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.self_improvement_rounded,
    this.accentColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // shadow kanan & bawah + berwarna
          BoxShadow(
            color: accentColor.withOpacity(0.18),
            blurRadius: 2,
            offset: const Offset(5, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accentColor, size: 22),
            ),
            const SizedBox(height: 8),

            // TITLE
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                height: 1.15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
