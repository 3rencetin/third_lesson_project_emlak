import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/emlak.dart';

String formatPrice(double price) {
  return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
}

class EmlakDetay extends StatefulWidget {
  final Emlak emlak;
  final VoidCallback emlakSil;

  const EmlakDetay({
    Key? key,
    required this.emlak,
    required this.emlakSil,
  }) : super(key: key);

  @override
  _EmlakDetayState createState() => _EmlakDetayState();
}

class _EmlakDetayState extends State<EmlakDetay> {
  late TextEditingController _baslikController;
  late TextEditingController _aciklamaController;
  late TextEditingController _fiyatController;
  late TextEditingController _resimUrlController;
  late TextEditingController _konumController;
  late TextEditingController _odaSayisiController;
  late TextEditingController _banyoSayisiController;
  late TextEditingController _metreKareController;
  late TextEditingController _binaYasiController;
  late String _secilenTip;
  late bool _satilikMi;

  @override
  void initState() {
    super.initState();
    _baslikController = TextEditingController(text: widget.emlak.baslik);
    _aciklamaController = TextEditingController(text: widget.emlak.aciklama);
    _fiyatController =
        TextEditingController(text: formatPrice(widget.emlak.fiyat));
    _resimUrlController = TextEditingController(text: widget.emlak.resimUrl);
    _konumController = TextEditingController(text: widget.emlak.konum);
    _odaSayisiController =
        TextEditingController(text: widget.emlak.odaSayisi.toString());
    _banyoSayisiController =
        TextEditingController(text: widget.emlak.banyoSayisi.toString());
    _metreKareController =
        TextEditingController(text: widget.emlak.metreKare.toString());
    _binaYasiController =
        TextEditingController(text: widget.emlak.binaYasi.toString());
    _secilenTip = widget.emlak.tip;
    _satilikMi = widget.emlak.satilikMi;
  }

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
        title: Text(widget.emlak.baslik),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Emlak Silinecek'),
                  content: const Text(
                      'Bu emlak ilanını silmek istediğinize emin misiniz?'),
                  actions: [
                    TextButton(
                      child: const Text('İptal'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Sil'),
                      onPressed: () {
                        widget.emlakSil();
                        Navigator.pop(context); // Dialog'u kapat
                        Navigator.pop(context); // Detay sayfasını kapat
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              try {
                final fiyatStr = _fiyatController.text.replaceAll('.', '');
                final guncelEmlak = Emlak(
                  id: widget.emlak.id,
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
                Navigator.pop(context, guncelEmlak);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Değişiklikler kaydedildi'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hata: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'emlak_${widget.emlak.id}',
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  widget.emlak.resimUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₺ ${formatPrice(widget.emlak.fiyat)} TL',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.emlak.satilikMi
                                      ? Colors.blue
                                      : Colors.orange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  widget.emlak.satilikMi
                                      ? 'Satılık'
                                      : 'Kiralık',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildFeature(Icons.king_bed,
                                  '${widget.emlak.odaSayisi} Oda'),
                              _buildFeature(Icons.bathtub,
                                  '${widget.emlak.banyoSayisi} Banyo'),
                              _buildFeature(Icons.square_foot,
                                  '${widget.emlak.metreKare} m²'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Açıklama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(widget.emlak.aciklama),
                          const SizedBox(height: 16),
                          const Text(
                            'Konum',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              Text(widget.emlak.konum),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Düzenle',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _baslikController,
                            decoration: const InputDecoration(
                              labelText: 'Başlık',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _aciklamaController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Açıklama',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _fiyatController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Fiyat (TL)',
                              border: OutlineInputBorder(),
                              helperText: 'Örnek: 12.500.000',
                              prefixText: '₺ ',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                if (newValue.text.isEmpty) {
                                  return newValue;
                                }
                                final number = int.parse(newValue.text);
                                final result = number
                                    .toString()
                                    .replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]}.',
                                    );
                                return TextEditingValue(
                                  text: result,
                                  selection: TextSelection.collapsed(
                                      offset: result.length),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _resimUrlController,
                            decoration: const InputDecoration(
                              labelText: 'Resim URL',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _konumController,
                            decoration: const InputDecoration(
                              labelText: 'Konum',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _odaSayisiController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Oda Sayısı',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _banyoSayisiController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Banyo Sayısı',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _metreKareController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Metre Kare',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _binaYasiController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Bina Yaşı',
                                    border: OutlineInputBorder(),
                                  ),
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
                            onChanged: (yeniDeger) {
                              setState(() {
                                _satilikMi = yeniDeger;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}
