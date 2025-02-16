import 'package:flutter/material.dart';
import 'package:klinik_buma_ipr/models/appointment.dart';
import 'package:klinik_buma_ipr/models/medical_record.dart';

// Screens
import 'package:klinik_buma_ipr/screens/home_screen.dart';
import 'package:klinik_buma_ipr/screens/appointment/appointment_detail_screen.dart';
import 'package:klinik_buma_ipr/screens/appointment/create_appointment_screen.dart';
import 'package:klinik_buma_ipr/screens/medical_record/medical_record_screen.dart';
import 'package:klinik_buma_ipr/screens/medical_record/medical_record_detail_screen.dart';
import 'package:klinik_buma_ipr/screens/profile/profile_screen.dart';

class Routes {
  // Named routes
  static const String home = '/';
  static const String appointmentDetail = '/appointment-detail';
  static const String createAppointment = '/create-appointment';
  static const String medicalRecord = '/medical-record';
  static const String medicalRecordDetail = '/medical-record-detail';
  static const String profile = '/profile';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case appointmentDetail:
        final appointment = settings.arguments as Appointment;
        return MaterialPageRoute(
          builder: (_) => AppointmentDetailScreen(appointment: appointment),
        );

      case createAppointment:
        return MaterialPageRoute(
          builder: (_) => const CreateAppointmentScreen(),
        );

      case medicalRecord:
        return MaterialPageRoute(
          builder: (_) => const MedicalRecordScreen(),
        );

      case medicalRecordDetail:
        final record = settings.arguments as MedicalRecord;
        return MaterialPageRoute(
          builder: (_) => MedicalRecordDetailScreen(record: record),
        );

      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
    }
  }

  // Helper methods untuk navigasi
  static void navigateToAppointmentDetail(
      BuildContext context, Appointment appointment) {
    Navigator.pushNamed(
      context,
      appointmentDetail,
      arguments: appointment,
    );
  }

  static void navigateToCreateAppointment(BuildContext context) {
    Navigator.pushNamed(context, createAppointment);
  }

  static void navigateToMedicalRecord(BuildContext context) {
    Navigator.pushNamed(context, medicalRecord);
  }

  static void navigateToMedicalRecordDetail(
      BuildContext context, MedicalRecord record) {
    Navigator.pushNamed(
      context,
      medicalRecordDetail,
      arguments: record,
    );
  }

  static void navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, profile);
  }

  // Page transitions
  static PageRouteBuilder fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
