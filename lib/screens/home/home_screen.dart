// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'widgets/blood_pressure_card.dart';
import 'widgets/user_header.dart';
import 'widgets/section_header.dart';
import '../../data/therapy_data.dart';
import '../therapy/therapy_form_screen.dart';
import '../therapy/widgets/sub_therapy_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData _iconForSubTitle(String title) {
    final t = title.toLowerCase();
    if (t.contains('yoga') || t.contains('meditasi')) {
      return Icons.self_improvement_rounded;
    }
    if (t.contains('pernapasan') || t.contains('napas')) {
      return Icons.air_rounded;
    }
    if (t.contains('musik')) return Icons.music_note_rounded;
    if (t.contains('tawa')) return Icons.emoji_emotions_rounded;

    if (t.contains('pijat')) return Icons.spa_rounded;
    if (t.contains('akup')) return Icons.push_pin;
    if (t.contains('refleksi')) return Icons.fingerprint;

    if (t.contains('seledri') || t.contains('daun')) {
      return Icons.local_florist_rounded;
    }
    if (t.contains('bawang')) return Icons.restaurant_rounded;

    if (t.contains('ibadah')) return Icons.volunteer_activism_rounded;
    if (t.contains('murotal')) return Icons.headphones_rounded;

    if (t.contains('ace') || t.contains('beta') || t.contains('obat')) {
      return Icons.medication_rounded;
    }

    return Icons.play_circle_outline_rounded;
  }

  Widget _therapySection({
    required BuildContext context,
    required String sectionTitle,
    required IconData sectionIcon,
    required Color sectionIconColor,
    required Color sectionBgColor,
    required List<Map<String, dynamic>> categories,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: sectionTitle,
          icon: sectionIcon,
          iconColor: sectionIconColor,
          backgroundColor: sectionBgColor,
        ),
        const SizedBox(height: 12),

        ...categories.map((cat) {
          final catTitle = cat['title'] as String;
          final catColor = cat['color'] as Color;
          final subs =
              subTherapyMap[catTitle] ?? const <Map<String, String>>[];

          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  catTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subs.length,
                    itemBuilder: (context, index) {
                      final sub = subs[index];
                      final title = sub['title'] ?? '';
                      final desc = sub['description'] ?? '';

                      return SizedBox(
                        width: 120,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0, 6, 12, 6),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TherapyFormScreen(
                                    therapyTitle: title,
                                    therapyDescription: desc,
                                    sectionTitle: sectionTitle,
                                  ),
                                ),
                              );
                            },
                            child: SubTherapyCard(
                              title: title,
                              description: desc,
                              icon: _iconForSubTitle(title),
                              accentColor: catColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const nonPharmTitle = 'Terapi Non-Farmakologis';
    const pharmTitle = 'Terapi Farmakologis';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== HEADER =====
            SafeArea(
              bottom: false,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade700,
                      Colors.blue.shade500,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserHeader(),
                      SizedBox(height: 25),
                      BloodPressureCard(),
                    ],
                  ),
                ),
              ),
            ),

            /// ===== CONTENT =====
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _therapySection(
                    context: context,
                    sectionTitle: nonPharmTitle,
                    sectionIcon: Icons.self_improvement,
                    sectionIconColor: Colors.purple,
                    sectionBgColor: const Color(0xFFF3E5F5),
                    categories: nonpharmacologicalTherapies,
                  ),

                  const SizedBox(height: 8),

                  _therapySection(
                    context: context,
                    sectionTitle: pharmTitle,
                    sectionIcon: Icons.spa_outlined,
                    sectionIconColor: Colors.pink,
                    sectionBgColor: const Color(0xFFFCE4EC),
                    categories: pharmacologicalTherapies,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
