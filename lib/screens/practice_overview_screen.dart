import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PracticeOverviewScreen extends StatefulWidget {
  final String appTitle;
  final String appSubtitle;

  final String name;
  final String systolic;
  final String diastolic;
  final String healthHistory;
  final String smokingHistory;

  final String lastDataTimeText;

  /// Optional: dipanggil setelah user menekan "Simpan Data"
  final VoidCallback? onInputNow;

  final VoidCallback? onProfile;
  final VoidCallback? onHome;
  final VoidCallback? onHistory;

  const PracticeOverviewScreen({
    super.key,
    required this.appTitle,
    required this.appSubtitle,
    required this.name,
    required this.systolic,
    required this.diastolic,
    required this.healthHistory,
    required this.smokingHistory,
    required this.lastDataTimeText,
    this.onInputNow,
    this.onProfile,
    this.onHome,
    this.onHistory,
  });

  @override
  State<PracticeOverviewScreen> createState() => _PracticeOverviewScreenState();
}

class _PracticeOverviewScreenState extends State<PracticeOverviewScreen> {
  int _currentIndex = 1; // 0=Profile, 1=Home, 2=Riwayat

  @override
  Widget build(BuildContext context) {
    final bg = Colors.grey.shade100;
    const blue = Color(0xFF2D72FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blue,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
        title: Column(
          children: [
            Text(
              widget.appTitle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              widget.appSubtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _mainCard(context),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _mainCard(BuildContext context) {
    const blue = Color(0xFF2D72FF);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Data Tekanan Darah Sebelum',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),

          _infoRow('Nama', widget.name, boldValue: true),
          const SizedBox(height: 10),
          _infoRow('Tekanan Darah', '${widget.systolic}/${widget.diastolic}', boldValue: true),
          const SizedBox(height: 10),
          _infoRow('Riwayat Kesehatan', widget.healthHistory),
          const SizedBox(height: 10),
          _infoRow('Riwayat Rokok', widget.smokingHistory),

          const SizedBox(height: 16),

          // Card kecil: Gunakan Data Terakhir
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gunakan Data Terakhir',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.lastDataTimeText,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.systolic}/${widget.diastolic}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: blue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'mmHg',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Tombol besar: Input Data Sekarang (munculin form)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                final result = await _showPracticeInputSheet(context);

                if (result != null && mounted) {
                  widget.onInputNow?.call(); // optional callback setelah simpan

                  // TODO: simpan ke DB/API sesuai kebutuhan kamu
                  // print(result);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tersimpan: ${result['systolic']}/${result['diastolic']} mmHg, ${result['duration_minutes']} menit',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Input Data Sekarang',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> _showPracticeInputSheet(BuildContext context) async {
    const blue = Color(0xFF2D72FF);

    final systolicCtrl = TextEditingController(text: '');
    final diastolicCtrl = TextEditingController(text: '');
    final notesCtrl = TextEditingController();

    int selectedDuration = 5;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Durasi Praktik
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Durasi Praktik',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [5, 10, 15].map((m) {
                            final selected = selectedDuration == m;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ChoiceChip(
                                  label: Text('$m Menit'),
                                  selected: selected,
                                  onSelected: (_) => setModalState(() => selectedDuration = m),
                                  selectedColor: blue.withOpacity(0.15),
                                  backgroundColor: Colors.white,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: selected ? blue : Colors.black87,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 14),

                        // Ukuran Tekanan Darah Setelah Praktik
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ukuran Tekanan Darah Setelah Praktik',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: _bpField(label: 'Sistolik', controller: systolicCtrl),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _bpField(label: 'Diastolik', controller: diastolicCtrl),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Catatan
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Catatan (Opsional)',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: notesCtrl,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Tulis kondisi atau perasaan anda saat ini ...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: blue, width: 1.2),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Simpan
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              final s = int.tryParse(systolicCtrl.text.trim()) ?? 0;
                              final d = int.tryParse(diastolicCtrl.text.trim()) ?? 0;

                              if (s <= 0 || d <= 0) {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  const SnackBar(content: Text('Isi Sistolik & Diastolik dengan benar')),
                                );
                                return;
                              }

                              Navigator.pop<Map<String, dynamic>>(ctx, {
                                'duration_minutes': selectedDuration,
                                'systolic': s,
                                'diastolic': d,
                                'notes': notesCtrl.text.trim(),
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Simpan Data',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    systolicCtrl.dispose();
    diastolicCtrl.dispose();
    notesCtrl.dispose();

    return result;
  }

  Widget _bpField({
    required String label,
    required TextEditingController controller,
  }) {
    const blue = Color(0xFF2D72FF);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: blue, width: 1.2),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text('mmHg', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _infoRow(String label, String value, {bool boldValue = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: boldValue ? FontWeight.w800 : FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomNav() {
    const blue = Color(0xFF2D72FF);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
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
        child: Row(
          children: [
            _navItem(
              index: 0,
              icon: Icons.person_outline,
              label: 'Profile',
              onTap: () {
                setState(() => _currentIndex = 0);
                widget.onProfile?.call();
              },
            ),
            _navItem(
              index: 1,
              icon: Icons.home_rounded,
              label: 'Home',
              onTap: () {
                setState(() => _currentIndex = 1);
                widget.onHome?.call();
              },
              highlightBubble: true,
            ),
            _navItem(
              index: 2,
              icon: Icons.history,
              label: 'Riwayat',
              onTap: () {
                setState(() => _currentIndex = 2);
                widget.onHistory?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool highlightBubble = false,
  }) {
    const blue = Color(0xFF2D72FF);
    final selected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (highlightBubble && selected)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: blue.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: blue),
              )
            else
              Icon(icon, color: selected ? blue : Colors.grey.shade500),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: selected ? blue : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
