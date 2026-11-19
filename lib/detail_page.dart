import 'package:material_ui/material_ui.dart';

import 'tugas.dart';

// BARU: halaman detail. Hanya membaca objek, tidak mengubahnya.
class DetailPage extends StatelessWidget {
  final Tugas tugas;

  const DetailPage({super.key, required this.tugas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Catatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tugas.judul,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    tugas.selesai
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                  ),
                  const SizedBox(width: 8),
                  Text(tugas.selesai ? 'Selesai' : 'Belum selesai'),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, 'toggle'),
                  child: Text(
                    tugas.selesai ? 'Tandai belum selesai' : 'Tandai selesai',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, 'hapus'),
                  child: const Text('Hapus catatan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
