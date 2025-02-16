import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klinik_buma_ipr/providers/appointment_provider.dart';
import 'package:klinik_buma_ipr/utils/constants.dart';
import 'package:klinik_buma_ipr/models/appointment.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '09:00';
  String selectedDoctor = 'Dr. Sari';
  String selectedType = 'Pemeriksaan Rutin';

  final List<String> appointmentTypes = [
    'Pemeriksaan Rutin',
    'Konsultasi',
    'Pemeriksaan Lab',
    'Vaksinasi',
  ];

  final List<String> doctors = [
    'Dr. Sari',
    'Dr. Budi',
    'Dr. Andi',
    'Dr. Maya',
  ];

  final List<String> timeSlots = [
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Janji Baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Jenis Pemeriksaan'),
            _buildTypeSelector(),
            const SizedBox(height: AppSizes.paddingL),
            _buildSectionTitle('Pilih Dokter'),
            _buildDoctorSelector(),
            const SizedBox(height: AppSizes.paddingL),
            _buildSectionTitle('Pilih Tanggal'),
            _buildDateSelector(),
            const SizedBox(height: AppSizes.paddingL),
            _buildSectionTitle('Pilih Waktu'),
            _buildTimeSelector(),
            const SizedBox(height: AppSizes.paddingXL),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingM),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: AppSizes.paddingS,
      runSpacing: AppSizes.paddingS,
      children: appointmentTypes.map((type) {
        final isSelected = type == selectedType;
        return ChoiceChip(
          label: Text(type),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                selectedType = type;
              });
            }
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorSelector() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        final isSelected = doctor == selectedDoctor;
        return Card(
          margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(doctor),
            subtitle: const Text('Dokter Umum'),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : null,
            onTap: () {
              setState(() {
                selectedDoctor = doctor;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDateSelector() {
    return Card(
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.textSecondary),
              const SizedBox(width: AppSizes.paddingM),
              Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Wrap(
      spacing: AppSizes.paddingS,
      runSpacing: AppSizes.paddingS,
      children: timeSlots.map((time) {
        final isSelected = time == selectedTime;
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                selectedTime = time;
              });
            }
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<AppointmentProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _createAppointment(context, provider),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
            ),
            child: const Text(
              'Buat Janji',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _createAppointment(BuildContext context, AppointmentProvider provider) {
    if (provider.hasTimeConflict(selectedDate, selectedTime)) {
      _showConflictDialog(context);
      return;
    }

    final appointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      doctor: selectedDoctor,
      date: selectedDate,
      time: selectedTime,
      type: selectedType,
      status: 'Terjadwal',
    );

    provider.addAppointment(appointment);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Janji temu berhasil dibuat!'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }

  void _showConflictDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jadwal Bentrok'),
        content: const Text(
          'Maaf, jadwal yang Anda pilih sudah terisi. Silakan pilih waktu lain.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
