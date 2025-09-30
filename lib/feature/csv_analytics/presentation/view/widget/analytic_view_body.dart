import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/manager/anlytic_cubit.dart';

import '../../../../../core/download_fiels/download_file.dart';
import '../../../../../core/utils/constans.dart';

class AnalyticViewBody extends StatelessWidget {
  const AnalyticViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticCubit, AnalyticState>(
      builder: (context, state) {
        if (state.status == AnalyticStatus.success) {
          return AnaLyticViewItem();
        } else if (state.status == AnalyticStatus.failure) {
          return Text(state.errMessage ?? '');
        } else {
          return SpinKitFadingCircle(color: Colors.blue, size: 60);
        }
      },
    );
  }
}

class AnaLyticViewItem extends StatefulWidget {
  const AnaLyticViewItem({super.key});

  @override
  State<AnaLyticViewItem> createState() => _AnaLyticViewItemState();
}

class _AnaLyticViewItemState extends State<AnaLyticViewItem> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalyticCubit>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// عنوان فوق Dropdown
          Row(
            children: const [
              Icon(Icons.analytics, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text(
                "نوع التحليل",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.list_alt, color: Colors.blueAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.blueAccent),
            value: cubit.state.filters.analyticsType,
            hint: const Text("اختر نوع التحليل"),
            items: cubit.state.data
                .map(
                  (e) => DropdownMenuItem<String>(
                value: e.name,
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(e.name),
                  ],
                ),
              ),
            )
                .toList(),
            onChanged: (val) {
              setState(() {
                final param =
                cubit.state.filters.copyWith(analyticsType: val?.trim());
                cubit.setParam(param);
              });
            },
          ),

          const SizedBox(height: 24),

          /// زرار التحميل
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () async {
              await requestStoragePermission();
              final downloader = FileDownloaderUI();
              final param = cubit.state.filters;
              await downloader.downloadFile(
                context,
                '${kBaseUrl}csv_analytics/file/?${param.toQueryParams()}',
                'analytics',
              );
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              "تحميل التقرير",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
