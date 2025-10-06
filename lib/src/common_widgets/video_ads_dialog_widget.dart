import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/theme/app_colors.dart';

Future<void> showAdVideoDialog(
  BuildContext context, {
  required String videoSD,
  required String videoHD,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return _AdVideoDialog(
        videoSD: videoSD,
        videoHD: videoHD,
      );
    },
  );
}

class _AdVideoDialog extends StatefulWidget {
  final String videoSD;
  final String videoHD;

  const _AdVideoDialog({required this.videoSD, required this.videoHD});

  @override
  State<_AdVideoDialog> createState() => _AdVideoDialogState();
}

class _AdVideoDialogState extends State<_AdVideoDialog> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize(widget.videoHD);
  }

  Future<void> _initialize(String url) async {
    setState(() => _isLoading = true);

    // dispose old ones
     _chewieController?.dispose();
    await _videoController?.dispose();

    _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      showControls: false,
      allowFullScreen: true,
    );

    // Close dialog automatically when finished
    _videoController!.addListener(() {
      if (_videoController!.value.position >=
          _videoController!.value.duration) {
        if (mounted) Navigator.of(context).pop();
      }
    });

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      backgroundColor: Colors.transparent,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(color: AppColors.ghostWhite,),
              Positioned.fill(
                child: _isLoading
                    ? const Center(child: FadeCircleLoadingIndicator())
                    : FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _chewieController!.videoPlayerController.value.size.width,
                          height: _chewieController!.videoPlayerController.value.size.height,
                          child: Chewie(controller: _chewieController!),
                        ),
                      ),
              ),

              // Close button
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.close,
                      color: Colors.blueAccent, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              // Quality switch
              // Positioned(
              //   top: 8,
              //   right: 8,
              //   child: PopupMenuButton<String>(
              //     icon: const Icon(Icons.hd, color: Colors.white),
              //     onSelected: (quality) async {
              //       final url = (quality == "HD")
              //           ? widget.videoHD
              //           : widget.videoSD;
              //       await _initialize(url);
              //     },
              //     itemBuilder: (context) => const [
              //       PopupMenuItem(value: "SD", child: Text("SD Quality")),
              //       PopupMenuItem(value: "HD", child: Text("HD Quality")),
              //     ],
              //   ),
              // ),
         
            ],
          ),
        ),
      ),
    );
  }
}
