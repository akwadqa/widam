import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/profile/data/profile_repository.dart';

@RoutePage()
class TermsConditionsAndPrivacyPolicyScreen extends ConsumerWidget {
  const TermsConditionsAndPrivacyPolicyScreen({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsAndConditionsAsync = ref.watch(companyProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? S.of(context).termsAndConditions),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: termsAndConditionsAsync.when(
            data: (data) => SingleChildScrollView(
                  child: Html(data: data.termsAndConditions),
                ),
            error: (error, stackTrace) =>
                AppBanner(message: error.toString(), stackTrace: stackTrace),
            loading: () => const Center(child: FadeCircleLoadingIndicator())),
      ),
    );
  }
}
