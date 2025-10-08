import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:monkey_app/core/widget/widget/custom_button.dart';
import 'package:monkey_app/feature/csv_analytics/presentation/manager/anlytic_cubit.dart';

import '../../../../../core/download_fiels/download_file.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/langs_key.dart';

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
final colorScheme =Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
               Icon(Icons.analytics, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                LangKeys.analytics.tr(),
                style: const TextStyle(
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
              prefixIcon:  Icon(Icons.list_alt, color:colorScheme.primary),
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
            icon:  Icon(Icons.arrow_drop_down_circle, color:colorScheme.primary),
            value: cubit.state.filters.analyticsType,
            hint:  Text(LangKeys.analytics.tr()),
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

        CustomButton(text: LangKeys.download.tr(), onPressed: () async {
          await requestStoragePermission();
          final downloader = FileDownloaderUI();
          final param = cubit.state.filters;
          await downloader.downloadFile(
            context,
            '${kBaseUrl}csv_analytics/file/?${param.toQueryParams()}',
            'analytics',
          );
        },)
        ],
      ),
    );
  }
}
