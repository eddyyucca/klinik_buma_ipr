class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final DateTime? birthDate;
  final String? address;
  final String? bloodType;
  final double? height;
  final double? weight;
  final List<String>? allergies;
  final Map<String, dynamic>? insurance;
  final DateTime? lastCheckup;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.birthDate,
    this.address,
    this.bloodType,
    this.height,
    this.weight,
    this.allergies,
    this.insurance,
    this.lastCheckup,
  });

  // Constructor untuk data dummy
  factory User.dummy() {
    return User(
      id: '1',
      name: 'Andreas Wibowo',
      email: 'andreas@email.com',
      phone: '081234567890',
      birthDate: DateTime(1990, 5, 15),
      address: 'Jl. Sudirman No. 123, Jakarta',
      bloodType: 'O+',
      height: 175,
      weight: 70,
      allergies: ['Seafood', 'Peanuts'],
      insurance: {
        'provider': 'BPJS Kesehatan',
        'number': '9876543210',
        'valid_until': '2025-12-31',
      },
      lastCheckup: DateTime.now().subtract(const Duration(days: 30)),
    );
  }

  // Konversi dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      address: json['address'],
      bloodType: json['bloodType'],
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : null,
      insurance: json['insurance'],
      lastCheckup: json['lastCheckup'] != null
          ? DateTime.parse(json['lastCheckup'])
          : null,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'birthDate': birthDate?.toIso8601String(),
      'address': address,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'allergies': allergies,
      'insurance': insurance,
      'lastCheckup': lastCheckup?.toIso8601String(),
    };
  }

  // Method untuk membuat salinan dengan modifikasi
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    DateTime? birthDate,
    String? address,
    String? bloodType,
    double? height,
    double? weight,
    List<String>? allergies,
    Map<String, dynamic>? insurance,
    DateTime? lastCheckup,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      allergies: allergies ?? this.allergies,
      insurance: insurance ?? this.insurance,
      lastCheckup: lastCheckup ?? this.lastCheckup,
    );
  }

  // Daftar golongan darah yang valid
  static List<String> get bloodTypes =>
      ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  // Method untuk menghitung BMI
  double? getBMI() {
    if (height != null && weight != null) {
      final heightInMeters = height! / 100;
      return weight! / (heightInMeters * heightInMeters);
    }
    return null;
  }

  // Method untuk mengecek apakah perlu checkup
  bool needsCheckup() {
    if (lastCheckup == null) return true;
    final daysSinceLastCheckup = DateTime.now().difference(lastCheckup!).inDays;
    return daysSinceLastCheckup > 180; // 6 bulan
  }

  // Method untuk mengecek apakah asuransi masih aktif
  bool hasActiveInsurance() {
    if (insurance == null || !insurance!.containsKey('valid_until'))
      return false;
    final validUntil = DateTime.parse(insurance!['valid_until']);
    return validUntil.isAfter(DateTime.now());
  }

  // Method untuk mendapatkan umur
  int? getAge() {
    if (birthDate == null) return null;
    return DateTime.now().year - birthDate!.year;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone}';
  }
}
