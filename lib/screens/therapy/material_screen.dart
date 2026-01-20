// lib/screens/material_screen.dart
import 'package:flutter/material.dart';
import 'main_detail_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialScreen extends StatefulWidget {
  final String therapyTitle;
  final String therapyDescription;
  final String patientName;
  final String patientBirthDate;
  final String bpSystolic;
  final String bpDiastolic;
  final String notes;

  const MaterialScreen({
    super.key,
    required this.therapyTitle,
    required this.therapyDescription,
    required this.patientName,
    required this.patientBirthDate,
    required this.bpSystolic,
    required this.bpDiastolic,
    required this.notes,
  });

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  @override
  Widget build(BuildContext context) {
    // Sample materials
    final materials = [
      {
        'title': 'Video Pengantar ${widget.therapyTitle}',
        'description':
            'Pelajari dasar-dasar dari ${widget.therapyTitle} dan manfaatnya untuk kesehatan tekanan darah Anda.',
        'videoId': 'iK5bZTvKZDw',
        'duration': '10 menit',
      },
      {
        'title': 'Teknik Dasar',
        'description':
            'Pelajari teknik-teknik dasar yang perlu Anda kuasai untuk memulai ${widget.therapyTitle}.',
        'videoId': 'YMx8Bbev6T4',
        'duration': '15 menit',
      },
      {
        'title': 'Tips Praktis',
        'description':
            'Dapatkan tips-tips praktis untuk menerapkan ${widget.therapyTitle} dalam kehidupan sehari-hari.',
        'videoId': 'iLnmTe5Q2Qw',
        'duration': '8 menit',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.therapyTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Materi Pembelajaran',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${materials.length} video',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ...materials.asMap().entries.map((entry) {
                    int index = entry.key;
                    var material = entry.value;
                    return _buildMaterialCard(
                      context,
                      index + 1,
                      material['title'] as String,
                      material['description'] as String,
                      material['duration'] as String,
                      material['videoId'] as String,
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard(
    BuildContext context,
    int index,
    String title,
    String description,
    String duration,
    String videoId,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigasi ke video player atau halaman detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MaterialDetailScreen(
                title: title,
                description: description,
                duration: duration,
                videoId: videoId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle,
                        size: 35,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Materi $index',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialDetail(
    BuildContext context,
    String title,
    String description,
    String duration,
    String videoId,
  ) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
        builder: (context, player) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// PLAYER
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: player,
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue.shade700),
                      const SizedBox(width: 10),
                      Text(duration),
                    ],
                  ),

                  const SizedBox(height: 15),
                  Text(
                    'Deskripsi',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(description),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                      ),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
