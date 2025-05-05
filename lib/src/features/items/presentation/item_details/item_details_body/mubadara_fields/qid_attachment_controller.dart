import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qid_attachment_controller.g.dart';

@riverpod
class QidAttachmentController extends _$QidAttachmentController {
  @override
  XFile? build() => null;

  void setQidAttachment(XFile value) => state = value;
}
