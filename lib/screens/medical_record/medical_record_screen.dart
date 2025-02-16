import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klinik_buma_ipr/providers/medical_record_provider.dart';
import 'package:klinik_buma_ipr/utils/constants.dart';
import 'package:klinik_buma_ipr/utils/routes.dart';
import 'package:klinik_buma_ipr/models/medical_record.dart'; // Import the MedicalRecord class

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = [
    'Semua',
    'Minggu Ini',
    'Bulan Ini',
    'Tahun Ini'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekam Medis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Consumer<MedicalRecordProvider>(
        builder: (context, provider, child) {
          final records = provider.records;

          if (records.isEmpty) {
            return _buildEmptyState();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips(),
                const SizedBox(height: AppSizes.paddingM),
                _buildStatistics(provider),
                const SizedBox(height: AppSizes.paddingM),
                _buildRecordsList(records),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 64,
            color: AppColors.primary.withOpacity(0.5),
          ),
          const SizedBox(height: AppSizes.paddingM),
          const Text(
            'Belum ada rekam medis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingS),
          const Text(
            'Rekam medis Anda akan muncul di sini',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.paddingS),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              selectedColor: AppColors.primary.withOpacity(0.2),
              backgroundColor: Colors.transparent,
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatistics(MedicalRecordProvider provider) {
    final stats = provider.getStatistics();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.paddingM),
            Row(
              children: [
                _buildStatItem(
                  icon: Icons.folder,
                  title: 'Total Rekam',
                  value: stats['total_records'].toString(),
                ),
                _buildStatItem(
                  icon: Icons.science,
                  title: 'Hasil Lab',
                  value: stats['records_with_lab_results'].toString(),
                ),
                _buildStatItem(
                  icon: Icons.calendar_today,
                  title: 'Tindak Lanjut',
                  value: stats['records_needing_followup'].toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsList(List<MedicalRecord> records) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
          child: InkWell(
            onTap: () => Routes.navigateToMedicalRecordDetail(context, record),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        record.diagnosis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${record.date.day}/${record.date.month}/${record.date.year}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingS),
                  Text(
                    'Dokter: ${record.doctor}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (record.prescription.isNotEmpty) ...[
                    const SizedBox(height: AppSizes.paddingS),
                    Text(
                      'Resep: ${record.prescription}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (record.hasAttachments()) ...[
                    const SizedBox(height: AppSizes.paddingS),
                    Wrap(
                      spacing: AppSizes.paddingXS,
                      children: record.attachments!.map((attachment) {
                        return Chip(
                          label: Text(attachment),
                          backgroundColor: AppColors.background,
                          labelStyle: const TextStyle(fontSize: 12),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Rekam Medis'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: Implement filter options
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Apply filters
              Navigator.pop(context);
            },
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );
  }
}
