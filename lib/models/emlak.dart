class Emlak {
  final String id;
  final String baslik;
  final String aciklama;
  final double fiyat;
  final String resimUrl;
  final String konum;
  final int odaSayisi;
  final int banyoSayisi;
  final double metreKare;
  final int binaYasi;
  final String tip;
  final bool satilikMi;

  Emlak({
    required this.id,
    required this.baslik,
    required this.aciklama,
    required this.fiyat,
    required this.resimUrl,
    required this.konum,
    required this.odaSayisi,
    required this.banyoSayisi,
    required this.metreKare,
    required this.binaYasi,
    required this.tip,
    required this.satilikMi,
  });

  // JSON'dan nesne oluşturma
  factory Emlak.fromJson(Map<String, dynamic> json) {
    return Emlak(
      id: json['id'] as String,
      baslik: json['baslik'] as String,
      aciklama: json['aciklama'] as String,
      fiyat: json['fiyat'] as double,
      resimUrl: json['resimUrl'] as String,
      konum: json['konum'] as String,
      odaSayisi: json['odaSayisi'] as int,
      banyoSayisi: json['banyoSayisi'] as int,
      metreKare: json['metreKare'] as double,
      binaYasi: json['binaYasi'] as int,
      tip: json['tip'] as String,
      satilikMi: json['satilikMi'] as bool,
    );
  }

  // Nesneyi JSON'a çevirme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'baslik': baslik,
      'aciklama': aciklama,
      'fiyat': fiyat,
      'resimUrl': resimUrl,
      'konum': konum,
      'odaSayisi': odaSayisi,
      'banyoSayisi': banyoSayisi,
      'metreKare': metreKare,
      'binaYasi': binaYasi,
      'tip': tip,
      'satilikMi': satilikMi,
    };
  }
}
