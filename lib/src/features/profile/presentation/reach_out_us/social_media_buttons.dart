import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../data/profile_repository.dart';

class SocialMediaButtons extends ConsumerWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialMediaLinks =
        ref.watch(companyProfileProvider).asData?.value.socialMediaLinks;
    bool hasSocialMediaLinks =
        socialMediaLinks != null && socialMediaLinks.isNotEmpty;
    return hasSocialMediaLinks
        ? ListView.separated(
            itemBuilder: (context, index) {
              return IconButton(
                  icon: AppCachedNetworkImage(
                    imageUrl: socialMediaLinks[index].icon,
                    fit: BoxFit.fitWidth,
                  ),
                  onPressed: () =>
                      launchUrl(Uri.parse(socialMediaLinks[index].link)));
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: socialMediaLinks.length)
        : const SizedBox.shrink();
  }
}
