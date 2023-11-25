import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/app_pagination_widget.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/complaints/presentation/complaint_item.dart/complaint_item.dart';
import 'package:widam/src/features/complaints/presentation/complaints_list/complaints_controller.dart';

class ComplaintsList extends ConsumerWidget {
  const ComplaintsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final complaintsAsync = ref.watch(complaintsControllerProvider);

    return complaintsAsync.when(
        data: (complaints) => AppPaginationWidget(
              onLoading:
                  ref.read(complaintsControllerProvider.notifier).onLoading,
              child: ListView.separated(
                  itemCount: complaints.data.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints.data[index];
                    return ComplaintItem(complaint: complaint);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20.0)),
            ),
        loading: () => const FadeCircleLoadingIndicator(),
        error: (error, stackTrace) =>
            AppBanner(message: error.toString(), stackTrace: stackTrace));
  }
}
