import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/emlak.dart';

class EmlakEkle extends StatefulWidget {
  const EmlakEkle({Key? key}) : super(key: key);

  @override
  _EmlakEkleState createState() => _EmlakEkleState();
}

class _EmlakEkleState extends State<EmlakEkle> {
  final _formKey = GlobalKey<FormState>();
  final _baslikController = TextEditingController();
  final _aciklamaController = TextEditingController();
  final _fiyatController = TextEditingController();
  final _resimUrlController = TextEditingController(
    text:
        'https://images.unsplash.com/photo-1568605114967-8130f3a36994', // Varsayılan resim URL'si
  );
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
                  if (double.parse(numericValue) < 1000000) {
                    return 'Fiyat en az 1.000.000 TL olmalıdır';
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
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Oda sayısı girin';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Geçerli bir sayı girin';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _banyoSayisiController,
                      decoration: const InputDecoration(
                        labelText: 'Banyo Sayısı',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Banyo sayısı girin';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Geçerli bir sayı girin';
                        }
                        return null;
                      },
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
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Metre kare girin';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Geçerli bir sayı girin';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _binaYasiController,
                      decoration: const InputDecoration(
                        labelText: 'Bina Yaşı',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bina yaşı girin';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Geçerli bir sayı girin';
                        }
                        return null;
                      },
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
              Row(
                children: [
                  const Text('Satılık mı?'),
                  const SizedBox(width: 8),
                  Switch(
                    value: _satilikMi,
                    onChanged: (value) {
                      setState(() {
                        _satilikMi = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final yeniEmlak = Emlak(
                        id: DateTime.now().toString(),
                        baslik: _baslikController.text,
                        aciklama: _aciklamaController.text,
                        fiyat: double.parse(
                            _fiyatController.text.replaceAll('.', '')),
                        resimUrl: _resimUrlController.text,
                        konum: _konumController.text,
                        odaSayisi: int.parse(_odaSayisiController.text),
                        banyoSayisi: int.parse(_banyoSayisiController.text),
                        metreKare: double.parse(_metreKareController.text),
                        binaYasi: int.parse(_binaYasiController.text),
                        tip: _secilenTip,
                        satilikMi: _satilikMi,
                      );
                      Navigator.pop(context, yeniEmlak);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Lütfen tüm alanları doğru formatta doldurun'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
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
}
