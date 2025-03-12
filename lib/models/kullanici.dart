class Kullanici {
  final String id;
  final String email;
  final String sifre;
  final bool isAdmin;
  final List<String> ilanlarim; // Kullanıcının ilan ID'leri

  Kullanici({
    required this.id,
    required this.email,
    required this.sifre,
    this.isAdmin = false,
    List<String>? ilanlarim,
  }) : ilanlarim = ilanlarim ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'sifre': sifre,
      'isAdmin': isAdmin,
      'ilanlarim': ilanlarim,
    };
  }

  factory Kullanici.fromMap(Map<String, dynamic> map) {
    return Kullanici(
      id: map['id'],
      email: map['email'],
      sifre: map['sifre'],
      isAdmin: map['isAdmin'] ?? false,
      ilanlarim: List<String>.from(map['ilanlarim'] ?? []),
    );
  }
}
