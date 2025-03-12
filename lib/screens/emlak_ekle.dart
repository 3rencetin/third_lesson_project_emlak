import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/emlak.dart';

class EmlakEkle extends StatefulWidget {
  final String kullaniciId;

  const EmlakEkle({
    Key? key,
    required this.kullaniciId,
  }) : super(key: key);

  @override
  _EmlakEkleState createState() => _EmlakEkleState();
}

class _EmlakEkleState extends State<EmlakEkle> {
  final _formKey = GlobalKey<FormState>();
  final _baslikController = TextEditingController();
  final _aciklamaController = TextEditingController();
  final _fiyatController = TextEditingController();
  final _resimUrlController = TextEditingController();
  final _konumController = TextEditingController();
  final _odaSayisiController = TextEditingController();
  final _banyoSayisiController = TextEditingController();
  final _metreKareController = TextEditingController();
  final _binaYasiController = TextEditingController();
  String _secilenTip = 'Daire';
  bool _satilikMi = true;

  @override
  void dispose() {
    _baslikController.dispose();
    _aciklamaController.dispose();
    _fiyatController.dispose();
    _resimUrlController.dispose();
    _konumController.dispose();
    _odaSayisiController.dispose();
    _banyoSayisiController.dispose();
    _metreKareController.dispose();
    _binaYasiController.dispose();
    super.dispose();
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName giriniz';
    }
    final numericValue = value.replaceAll('.', '');
    if (double.tryParse(numericValue) == null) {
      return 'Geçerli bir sayı giriniz';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Emlak Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _baslikController,
                decoration: const InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                  helperText: 'Örnek: Deniz Manzaralı 3+1 Daire',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir başlık girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _aciklamaController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  border: OutlineInputBorder(),
                  helperText: 'Emlak hakkında detaylı bilgi',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir açıklama girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fiyatController,
                decoration: const InputDecoration(
                  labelText: 'Fiyat (TL)',
                  border: OutlineInputBorder(),
                  helperText: 'Örnek: 12.500.000',
                  prefixText: '₺ ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) {
                      return newValue;
                    }
                    final number = int.parse(newValue.text);
                    final result = number.toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]}.',
                        );
                    return TextEditingValue(
                      text: result,
                      selection: TextSelection.collapsed(offset: result.length),
                    );
                  }),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir fiyat girin';
                  }
                  final numericValue = value.replaceAll('.', '');
                  if (double.tryParse(numericValue) == null) {
                    return 'Geçerli bir sayı girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _resimUrlController,
                decoration: const InputDecoration(
                  labelText: 'Resim URL',
                  border: OutlineInputBorder(),
                  helperText: 'Varsayılan resim kullanılacaktır',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir resim URL\'si girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _konumController,
                decoration: const InputDecoration(
                  labelText: 'Konum',
                  border: OutlineInputBorder(),
                  helperText: 'Örnek: Kadıköy, İstanbul',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir konum girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _odaSayisiController,
                      decoration: const InputDecoration(
                        labelText: 'Oda Sayısı',
                        border: OutlineInputBorder(),
                        helperText: 'Örnek: 3',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) =>
                          _validateNumber(value, 'Oda sayısı'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _banyoSayisiController,
                      decoration: const InputDecoration(
                        labelText: 'Banyo Sayısı',
                        border: OutlineInputBorder(),
                        helperText: 'Örnek: 1',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) =>
                          _validateNumber(value, 'Banyo sayısı'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _metreKareController,
                      decoration: const InputDecoration(
                        labelText: 'Metre Kare',
                        border: OutlineInputBorder(),
                        helperText: 'Örnek: 120',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) =>
                          _validateNumber(value, 'Metre kare'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _binaYasiController,
                      decoration: const InputDecoration(
                        labelText: 'Bina Yaşı',
                        border: OutlineInputBorder(),
                        helperText: 'Örnek: 5',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) => _validateNumber(value, 'Bina yaşı'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _secilenTip,
                decoration: const InputDecoration(
                  labelText: 'Emlak Tipi',
                  border: OutlineInputBorder(),
                ),
                items: ['Daire', 'Villa', 'Müstakil']
                    .map((tip) => DropdownMenuItem(
                          value: tip,
                          child: Text(tip),
                        ))
                    .toList(),
                onChanged: (yeniTip) {
                  if (yeniTip != null) {
                    setState(() {
                      _secilenTip = yeniTip;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Satılık mı?'),
                value: _satilikMi,
                onChanged: (value) {
                  setState(() {
                    _satilikMi = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _emlakEkle();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Emlak Ekle',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _emlakEkle() {
    try {
      final fiyatStr = _fiyatController.text.replaceAll('.', '');
      final yeniEmlak = Emlak(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        kullaniciId: widget.kullaniciId,
        baslik: _baslikController.text.trim(),
        aciklama: _aciklamaController.text.trim(),
        fiyat: double.parse(fiyatStr),
        resimUrl: _resimUrlController.text.trim(),
        konum: _konumController.text.trim(),
        odaSayisi: int.parse(_odaSayisiController.text),
        banyoSayisi: int.parse(_banyoSayisiController.text),
        metreKare: double.parse(_metreKareController.text),
        binaYasi: int.parse(_binaYasiController.text),
        tip: _secilenTip,
        satilikMi: _satilikMi,
      );

      Navigator.pop(context, yeniEmlak);
      print('Yeni emlak oluşturuldu: ${yeniEmlak.toMap()}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
