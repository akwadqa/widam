import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';

class AdVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const AdVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<AdVideoPlayer> createState() => _AdVideoPlayerState();
}

class _AdVideoPlayerState extends State<AdVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      showControls: true,
    );

    _videoController!.addListener(() {
      final v = _videoController!;
      if (v.value.isInitialized &&
          v.value.position >= v.value.duration) {
        if (mounted) Navigator.of(context).pop();
      }
    });

    _loading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: FadeCircleLoadingIndicator());
    }

    final size = _videoController!.value.size;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }
}
