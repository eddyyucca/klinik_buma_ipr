import 'package:flutter/foundation.dart';
import 'package:klinik_buma_ipr/models/appointment.dart';

class AppointmentProvider with ChangeNotifier {
  // List untuk menyimpan semua janji temu
  List<Appointment> _appointments = [
    Appointment.dummy(),
    Appointment(
      id: '2',
      doctor: 'Dr. Budi',
      date: DateTime.now().add(const Duration(days: 1)),
      time: '14:30',
      type: 'Konsultasi',
      status: 'Terjadwal',
    ),
    Appointment(
      id: '3',
      doctor: 'Dr. Maya',
      date: DateTime.now().add(const Duration(days: 3)),
      time: '10:00',
      type: 'Pemeriksaan Lab',
      status: 'Terjadwal',
    ),
  ];

  // Getter untuk mengakses semua janji temu
  List<Appointment> get appointments => _appointments;

  // Getter untuk janji temu yang akan datang
  List<Appointment> get upcomingAppointments {
    return _appointments
        .where((appointment) =>
            appointment.date.isAfter(DateTime.now()) &&
            appointment.status == 'Terjadwal')
        .toList();
  }

  // Getter untuk janji temu yang sudah selesai
  List<Appointment> get completedAppointments {
    return _appointments
        .where((appointment) => appointment.status == 'Selesai')
        .toList();
  }

  // Method untuk menambah janji temu baru
  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  // Method untuk mengupdate janji temu
  void updateAppointment(Appointment appointment) {
    final index = _appointments.indexWhere((a) => a.id == appointment.id);
    if (index != -1) {
      _appointments[index] = appointment;
      notifyListeners();
    }
  }

  // Method untuk membatalkan janji temu
  void cancelAppointment(String id) {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] =
          _appointments[index].copyWith(status: 'Dibatalkan');
      notifyListeners();
    }
  }

  // Method untuk menyelesaikan janji temu
  void completeAppointment(String id) {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(status: 'Selesai');
      notifyListeners();
    }
  }

  // Method untuk menjadwalkan ulang janji temu
  void rescheduleAppointment(String id, DateTime newDate, String newTime) {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(
        date: newDate,
        time: newTime,
      );
      notifyListeners();
    }
  }

  // Method untuk mendapatkan janji temu berdasarkan dokter
  List<Appointment> getAppointmentsByDoctor(String doctor) {
    return _appointments.where((a) => a.doctor == doctor).toList();
  }

  // Method untuk mendapatkan janji temu berdasarkan rentang tanggal
  List<Appointment> getAppointmentsByDateRange(DateTime start, DateTime end) {
    return _appointments
        .where((a) =>
            a.date.isAfter(start.subtract(const Duration(days: 1))) &&
            a.date.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }

  // Method untuk memeriksa apakah ada konflik jadwal
  bool hasTimeConflict(DateTime date, String time, {String? excludeId}) {
    return _appointments.any((a) =>
        a.id != excludeId &&
        a.date.year == date.year &&
        a.date.month == date.month &&
        a.date.day == date.day &&
        a.time == time &&
        a.status == 'Terjadwal');
  }

  // Method untuk membersihkan semua data
  void clearAppointments() {
    _appointments.clear();
    notifyListeners();
  }
}
