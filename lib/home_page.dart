import 'package:material_ui/material_ui.dart';

import 'detail_page.dart';
import 'tugas.dart';

// CUMA DIGESER: dulu bernama TaskHomePage di main.dart, sekarang HomePage.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Tugas> _tugas = <Tugas>[];

  int get _jumlahSelesai => _tugas.where((Tugas t) => t.selesai).length;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _simpan() {
    final String judul = _taskController.text.trim();
    if (judul.isEmpty) return;

    setState(() {
      _tugas.insert(0, Tugas(judul: judul));
    });
    _taskController.clear();
  }

  void _hapus(int index) {
    final Tugas tugasDihapus = _tugas[index];
    setState(() {
      _tugas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Catatan dihapus.'),
        // Flutter 3.50: SnackBar dengan aksi default-nya persist = true,
        // jadi timer tidak pernah menutupnya. Kita paksa auto-dismiss.
        duration: const Duration(seconds: 7),
        persist: false,
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () {
            setState(() {
              final int posisi = index < _tugas.length ? index : _tugas.length;
              _tugas.insert(posisi, tugasDihapus);
            });
          },
        ),
      ),
    );
  }

  Future<void> _bukaDetail(int index) async {
    final String? hasil = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) => DetailPage(tugas: _tugas[index]),
      ),
    );

    if (!mounted) return;

    if (hasil == 'hapus') {
      _hapus(index);
    } else if (hasil == 'toggle') {
      setState(() {
        _tugas[index].selesai = !_tugas[index].selesai;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme skema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Harian'),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController,
                      autofocus: false,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _simpan(),
                      decoration: const InputDecoration(
                        hintText: 'Tulis Catatan Anda',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed:
                        _taskController.text.trim().isEmpty ? null : _simpan,
                    child: const Text('Simpan'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${_tugas.length} tugas - $_jumlahSelesai selesai',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: skema.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _tugas.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Pengecualian warna manual yang diizinkan (1/2).
                            const Icon(
                              Icons.checklist,
                              size: 64,
                              color: Color(0xFF48484A),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Belum ada catatan. Tulis satu di atas.',
                              style: TextStyle(color: skema.onSurfaceVariant),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: _tugas.length,
                        separatorBuilder: (_, _) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          final Tugas tugas = _tugas[index];
                          return ListTile(
                            leading: Checkbox(
                              value: tugas.selesai,
                              onChanged: (bool? nilai) {
                                setState(() {
                                  tugas.selesai = nilai ?? false;
                                });
                              },
                            ),
                            title: Text(
                              tugas.judul,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: tugas.selesai
                                    ? TextDecoration.lineThrough
                                    : null,
                                // Pengecualian warna manual yang diizinkan (2/2).
                                color: tugas.selesai
                                    ? const Color(0xFF8E8E93)
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              tooltip: 'Hapus',
                              onPressed: () => _hapus(index),
                            ),
                            onTap: () => _bukaDetail(index),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
