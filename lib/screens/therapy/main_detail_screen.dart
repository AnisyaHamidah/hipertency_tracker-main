import 'package:flutter/material.dart';
import 'package:hipertency_tracker/screens/practice_overview_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String duration;
  final String videoId;

  // tombol bawah
  final String primaryButtonText;

  /// Kalau kamu isi ini dari luar, tombol akan pakai action ini.
  /// Kalau null -> defaultnya push ke PracticeOverviewScreen.
  final VoidCallback? onPrimaryPressed;

  // ====== Data untuk halaman PracticeOverviewScreen (optional) ======
  final String practiceSubtitle;

  final String? patientName;
  final String? systolic;
  final String? diastolic;
  final String? healthHistory;
  final String? smokingHistory;
  final String? lastDataTimeText;

  /// Action tombol "Input Data Sekarang" di halaman practice
  final VoidCallback? onInputNow;

  const MaterialDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.videoId,
    this.primaryButtonText = 'Mulai Materi',
    this.onPrimaryPressed,

    // default subtitle untuk halaman berikutnya
    this.practiceSubtitle = 'Mulai Sesi Praktik',

    // default data dummy/optional
    this.patientName,
    this.systolic,
    this.diastolic,
    this.healthHistory,
    this.smokingHistory,
    this.lastDataTimeText,
    this.onInputNow,
  });

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ✅ Default aksi tombol bawah:
  // - kalau user isi onPrimaryPressed -> jalankan itu
  // - kalau null -> push ke PracticeOverviewScreen
  void _handlePrimaryPressed() {
    if (widget.onPrimaryPressed != null) {
      widget.onPrimaryPressed!.call();
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PracticeOverviewScreen(
          appTitle: widget.title,
          appSubtitle: widget.practiceSubtitle,
          name: widget.patientName ?? '-',
          systolic: widget.systolic ?? '-',
          diastolic: widget.diastolic ?? '-',
          healthHistory: widget.healthHistory ?? '-',
          smokingHistory: widget.smokingHistory ?? '-',
          lastDataTimeText: widget.lastDataTimeText ?? 'Hari ini, -',
          onInputNow: widget.onInputNow,
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.pop(context),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
        ),
      ),
    );
  }

  Widget _bottomCTA(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2D72FF), Color(0xFF5A97FF)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2D72FF).withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            // ✅ sekarang tombol pasti pindah halaman (default) atau action custom
            onPressed: _handlePrimaryPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.primaryButtonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    const videoHeight = 300.0;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomCTA(context),
      body: Column(
        children: [
          // ================= VIDEO =================
          SizedBox(
            width: double.infinity,
            height: videoHeight,
            child: ValueListenableBuilder<YoutubePlayerValue>(
              valueListenable: _controller,
              builder: (context, value, _) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRect(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: screenW,
                          height: screenW * (9 / 16),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    if (!value.isPlaying)
                      Center(
                        child: GestureDetector(
                          onTap: () => _controller.play(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D72FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),

                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 12),
                          child: _backButton(context),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.play_circle_outline,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        widget.duration,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
