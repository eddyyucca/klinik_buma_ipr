class MedicalRecord {
  final String id;
  final String diagnosis;
  final String doctor;
  final DateTime date;
  final String prescription;
  final List<String>? attachments;
  final String? notes;
  final Map<String, dynamic>? labResults;
  final String? nextCheckupDate;

  MedicalRecord({
    required this.id,
    required this.diagnosis,
    required this.doctor,
    required this.date,
    required this.prescription,
    this.attachments,
    this.notes,
    this.labResults,
    this.nextCheckupDate,
  });

  // Constructor untuk data dummy
  factory MedicalRecord.dummy() {
    return MedicalRecord(
      id: '1',
      diagnosis: 'Flu',
      doctor: 'Dr. Sari',
      date: DateTime.now(),
      prescription: 'Paracetamol, Vitamin C',
      attachments: ['resep.pdf', 'hasil_lab.pdf'],
      notes: 'Pasien menunjukkan gejala flu dengan demam ringan',
      labResults: {
        'suhu': '38.5°C',
        'tekanan_darah': '120/80',
        'detak_jantung': '80bpm'
      },
      nextCheckupDate: '2025-02-24',
    );
  }

  // Konversi dari JSON
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      diagnosis: json['diagnosis'],
      doctor: json['doctor'],
      date: DateTime.parse(json['date']),
      prescription: json['prescription'],
      attachments: List<String>.from(json['attachments'] ?? []),
      notes: json['notes'],
      labResults: json['labResults'],
      nextCheckupDate: json['nextCheckupDate'],
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diagnosis': diagnosis,
      'doctor': doctor,
      'date': date.toIso8601String(),
      'prescription': prescription,
      'attachments': attachments,
      'notes': notes,
      'labResults': labResults,
      'nextCheckupDate': nextCheckupDate,
    };
  }

  // Method untuk membuat salinan dengan modifikasi
  MedicalRecord copyWith({
    String? id,
    String? diagnosis,
    String? doctor,
    DateTime? date,
    String? prescription,
    List<String>? attachments,
    String? notes,
    Map<String, dynamic>? labResults,
    String? nextCheckupDate,
  }) {
    return MedicalRecord(
      id: id ?? this.id,
      diagnosis: diagnosis ?? this.diagnosis,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      prescription: prescription ?? this.prescription,
      attachments: attachments ?? this.attachments,
      notes: notes ?? this.notes,
      labResults: labResults ?? this.labResults,
      nextCheckupDate: nextCheckupDate ?? this.nextCheckupDate,
    );
  }

  // Daftar kategori diagnosis yang umum
  static List<String> get diagnosisCategories => [
        'Pemeriksaan Rutin',
        'Penyakit Dalam',
        'Penyakit Menular',
        'Gawat Darurat',
        'Kontrol Rutin',
      ];

  // Method untuk mengecek apakah perlu kontrol ulang
  bool needsFollowUp() {
    return nextCheckupDate != null;
  }

  // Method untuk mengecek apakah ada hasil lab
  bool hasLabResults() {
    return labResults != null && labResults!.isNotEmpty;
  }

  // Method untuk mengecek apakah ada lampiran
  bool hasAttachments() {
    return attachments != null && attachments!.isNotEmpty;
  }

  @override
  String toString() {
    return 'MedicalRecord{id: $id, diagnosis: $diagnosis, doctor: $doctor, date: $date, prescription: $prescription}';
  }
}
