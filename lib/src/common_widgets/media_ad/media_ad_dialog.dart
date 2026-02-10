import 'package:flutter/material.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/common_widgets/app_close_button.dart';

import 'ad_video_player.dart';
import 'media_extension.dart';

class MediaAdDialog extends StatelessWidget {
  final String mediaUrl;
  final VoidCallback? onTap;

  const MediaAdDialog({
    super.key,
    required this.mediaUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(color: Colors.white),

              Positioned.fill(
                child: mediaUrl.isVideo
                    ? AdVideoPlayer(videoUrl: mediaUrl)
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onTap?.call();
                        },
                        child: AppCachedNetworkImage(
                          imageUrl: mediaUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),

              const PositionedDirectional(
                top: 8,
                end: 8,
                child: AppCloseButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
