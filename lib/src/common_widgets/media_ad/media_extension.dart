extension MediaUrlExtension on String {
  bool get isVideo {
    final uri = Uri.tryParse(this);
    if (uri == null) return false;

    final path = uri.path.toLowerCase();

    return path.endsWith('.mp4') ||
        path.endsWith('.mov') ||
        path.endsWith('.avi') ||
        path.endsWith('.mkv') ||
        path.endsWith('.webm');
  }

  bool get isImage {
    final uri = Uri.tryParse(this);
    if (uri == null) return false;

    final path = uri.path.toLowerCase();

    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp');
  }
}
