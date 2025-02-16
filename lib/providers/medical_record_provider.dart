import 'package:flutter/foundation.dart';
import 'package:klinik_buma_ipr/models/medical_record.dart';

class MedicalRecordProvider with ChangeNotifier {
  // List untuk menyimpan semua rekam medis
  List<MedicalRecord> _records = [
    MedicalRecord.dummy(),
    MedicalRecord(
      id: '2',
      diagnosis: 'Sakit Kepala',
      doctor: 'Dr. Budi',
      date: DateTime.now().subtract(const Duration(days: 7)),
      prescription: 'Ibuprofen',
      notes: 'Pasien mengeluh sakit kepala sejak 3 hari yang lalu',
      labResults: {
        'tekanan_darah': '130/85',
        'detak_jantung': '75bpm',
      },
    ),
    MedicalRecord(
      id: '3',
      diagnosis: 'Check Up Rutin',
      doctor: 'Dr. Maya',
      date: DateTime.now().subtract(const Duration(days: 30)),
      prescription: 'Vitamin C, Vitamin D',
      notes: 'Hasil pemeriksaan normal',
      labResults: {
        'kolesterol': '180mg/dL',
        'gula_darah': '95mg/dL',
        'asam_urat': '5.5mg/dL',
      },
      nextCheckupDate: DateTime.now().add(const Duration(days: 90)).toString(),
    ),
  ];

  // Getter untuk mengakses semua rekam medis
  List<MedicalRecord> get records => _records;

  // Getter untuk rekam medis terbaru
  List<MedicalRecord> get recentRecords {
    final sortedRecords = List<MedicalRecord>.from(_records);
    sortedRecords.sort((a, b) => b.date.compareTo(a.date));
    return sortedRecords.take(5).toList();
  }

  // Method untuk menambah rekam medis baru
  void addRecord(MedicalRecord record) {
    _records.add(record);
    notifyListeners();
  }

  // Method untuk mengupdate rekam medis
  void updateRecord(MedicalRecord record) {
    final index = _records.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _records[index] = record;
      notifyListeners();
    }
  }

  // Method untuk menghapus rekam medis
  void deleteRecord(String id) {
    _records.removeWhere((record) => record.id == id);
    notifyListeners();
  }

  // Method untuk mendapatkan rekam medis berdasarkan ID
  MedicalRecord? getRecordById(String id) {
    try {
      return _records.firstWhere((record) => record.id == id);
    } catch (e) {
      return null;
    }
  }

  // Method untuk mendapatkan rekam medis berdasarkan dokter
  List<MedicalRecord> getRecordsByDoctor(String doctor) {
    return _records.where((record) => record.doctor == doctor).toList();
  }

  // Method untuk mendapatkan rekam medis berdasarkan rentang tanggal
  List<MedicalRecord> getRecordsByDateRange(DateTime start, DateTime end) {
    return _records
        .where((record) =>
            record.date.isAfter(start.subtract(const Duration(days: 1))) &&
            record.date.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }

  // Method untuk mendapatkan rekam medis berdasarkan diagnosis
  List<MedicalRecord> getRecordsByDiagnosis(String diagnosis) {
    return _records
        .where((record) =>
            record.diagnosis.toLowerCase().contains(diagnosis.toLowerCase()))
        .toList();
  }

  // Method untuk mendapatkan semua dokter yang pernah dikunjungi
  List<String> get allDoctors {
    return _records.map((record) => record.doctor).toSet().toList();
  }

  // Method untuk mendapatkan semua jenis diagnosis
  List<String> get allDiagnoses {
    return _records.map((record) => record.diagnosis).toSet().toList();
  }

  // Method untuk mendapatkan rekam medis yang memerlukan tindak lanjut
  List<MedicalRecord> get recordsNeedingFollowUp {
    return _records.where((record) => record.needsFollowUp()).toList();
  }

  // Method untuk mendapatkan rekam medis dengan hasil lab
  List<MedicalRecord> get recordsWithLabResults {
    return _records.where((record) => record.hasLabResults()).toList();
  }

  // Method untuk mendapatkan statistik rekam medis
  Map<String, dynamic> getStatistics() {
    return {
      'total_records': _records.length,
      'records_with_lab_results': recordsWithLabResults.length,
      'records_needing_followup': recordsNeedingFollowUp.length,
      'unique_doctors': allDoctors.length,
      'latest_record_date': _records.isNotEmpty
          ? _records.map((r) => r.date).reduce((a, b) => a.isAfter(b) ? a : b)
          : null,
    };
  }

  // Method untuk membersihkan semua data
  void clearRecords() {
    _records.clear();
    notifyListeners();
  }
}
