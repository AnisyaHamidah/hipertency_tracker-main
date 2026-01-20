import 'package:flutter/material.dart';
import '../../therapy/therapy_form_screen.dart';

class TherapyCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int index;
  final String sectionTitle;

  const TherapyCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.index,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TherapyFormScreen(
              therapyTitle: title,
              therapyDescription: 'Terapi $title untuk mengelola tekanan darah',
              sectionTitle: sectionTitle,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          width: 130,
          margin: EdgeInsets.only(left: index == 0 ? 0 : 0, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.10),
                blurRadius: 5,
                offset: const Offset(8, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
