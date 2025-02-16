class Appointment {
  final String id;
  final String doctor;
  final DateTime date;
  final String time;
  final String type;
  String status;

  Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.type,
    this.status = 'Terjadwal',
  });

  // Constructor untuk data dummy
  factory Appointment.dummy() {
    return Appointment(
      id: '1',
      doctor: 'Dr. Sari',
      date: DateTime.now(),
      time: '09:00',
      type: 'Pemeriksaan Rutin',
      status: 'Terjadwal',
    );
  }

  // Konversi dari JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctor: json['doctor'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      type: json['type'],
      status: json['status'],
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor,
      'date': date.toIso8601String(),
      'time': time,
      'type': type,
      'status': status,
    };
  }

  // Method untuk membuat salinan dengan modifikasi
  Appointment copyWith({
    String? id,
    String? doctor,
    DateTime? date,
    String? time,
    String? type,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  // Daftar tipe appointment yang tersedia
  static List<String> get types => [
        'Pemeriksaan Rutin',
        'Konsultasi',
        'Pemeriksaan Lab',
        'Vaksinasi',
        'Kontrol',
      ];

  // Daftar status yang mungkin
  static List<String> get statuses => [
        'Terjadwal',
        'Selesai',
        'Dibatalkan',
        'Ditunda',
      ];

  // Method untuk mengecek apakah appointment sudah lewat
  bool isPassed() {
    final now = DateTime.now();
    return date.isBefore(now);
  }

  // Method untuk mengecek apakah appointment bisa dibatalkan
  bool canBeCancelled() {
    return status == 'Terjadwal' && !isPassed();
  }

  // Method untuk mengecek apakah appointment bisa dijadwalkan ulang
  bool canBeRescheduled() {
    return status == 'Terjadwal' && !isPassed();
  }

  @override
  String toString() {
    return 'Appointment{id: $id, doctor: $doctor, date: $date, time: $time, type: $type, status: $status}';
  }
}
