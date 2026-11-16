import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _category = "internship";
  String _description = "";
  String _thumbnailUrl = "";
  DateTime? _endedAt;

  final TextEditingController _dateController = TextEditingController();

  final List<String> _categoryChoices = [
    "full-time",
    "part-time",
    "internship",
    "research",
    "volunteer",
    "freelance",
  ];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _endedAt) {
      setState(() {
        _endedAt = picked;
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pengalaman',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input 1: Judul Pengalaman (TextFormField)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Software Engineer Intern",
                      labelText: "Judul Pengalaman",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _title = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Judul pengalaman tidak boleh kosong!";
                      }
                      if (value.trim().length < 3) {
                        return "Judul pengalaman minimal 3 karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input 2: Kategori Pengalaman (DropdownButtonFormField)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Kategori Pengalaman",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _category,
                    items: _categoryChoices.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue ?? "internship";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Pilih salah satu kategori!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input 3: Deskripsi (TextFormField Multiline)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Deskripsikan tanggung jawab atau pencapaian",
                      labelText: "Deskripsi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                      }
                      if (value.trim().length < 10) {
                        return "Deskripsi minimal 10 karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input 4: URL Thumbnail (TextFormField dengan validasi URL)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "https://example.com/thumbnail.png (Opsional)",
                      labelText: "URL Thumbnail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnailUrl = value ?? "";
                      });
                    },
                    validator: (String? value) {
                      if (value != null && value.trim().isNotEmpty) {
                        final uri = Uri.tryParse(value.trim());
                        if (uri == null ||
                            !uri.hasScheme ||
                            (!uri.isScheme('http') && !uri.isScheme('https'))) {
                          return "Format URL thumbnail tidak valid (harus diawali http/https)!";
                        }
                      }
                      return null;
                    },
                  ),
                ),

                // Input 5: Tanggal Selesai (DatePicker)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Pilih tanggal selesai (Opsional)",
                      labelText: "Tanggal Selesai",
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),

                // Tombol Simpan
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 14.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Ringkasan Pengalaman Baru'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Judul: $_title'),
                                      const SizedBox(height: 6),
                                      Text('Kategori: $_category'),
                                      const SizedBox(height: 6),
                                      Text('Deskripsi: $_description'),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Thumbnail: ${_thumbnailUrl.isEmpty ? "(Tidak diisi)" : _thumbnailUrl}',
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Tanggal Selesai: ${_dateController.text.isEmpty ? "(Masih Berlangsung / Tidak diisi)" : _dateController.text}',
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _formKey.currentState!.reset();
                                      setState(() {
                                        _title = "";
                                        _category = "internship";
                                        _description = "";
                                        _thumbnailUrl = "";
                                        _endedAt = null;
                                        _dateController.clear();
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
  }
}
