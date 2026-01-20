import 'package:flutter/material.dart';
import 'package:hipertency_tracker/screens/therapy/widgets/sub_therapy_card.dart';
import 'material_screen.dart';

class SubTherapyScreen extends StatelessWidget {
  final String therapyTitle;
  final String appBarTitle;
  final List<Map<String, String>> subTherapies;

  final String patientName;
  final String patientBirthDate;
  final String bpSystolic;
  final String bpDiastolic;
  final String healthHistory;
  final String smokingHistory;

  const SubTherapyScreen({
    super.key,
    required this.therapyTitle,
    required this.appBarTitle,
    required this.subTherapies,
    required this.patientName,
    required this.patientBirthDate,
    required this.bpSystolic,
    required this.bpDiastolic,
    required this.healthHistory,
    required this.smokingHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              therapyTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: subTherapies.length,
              itemBuilder: (context, index) {
                final sub = subTherapies[index];
                final subTitle = sub['title'] ?? '';
                final subDesc = sub['description'] ?? '';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MaterialScreen(
                          therapyTitle: subTitle,
                          therapyDescription: subDesc,
                          patientName: patientName,
                          patientBirthDate: patientBirthDate,
                          bpSystolic: bpSystolic,
                          bpDiastolic: bpDiastolic,
                          notes: healthHistory,
                        ),
                      ),
                    );
                  },
                  child: SubTherapyCard(title: subTitle, description: subDesc),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
