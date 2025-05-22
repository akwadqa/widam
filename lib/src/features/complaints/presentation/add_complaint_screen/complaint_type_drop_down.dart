import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_drop_down_bottom_sheet.dart';
import 'package:widam/src/utils/utils.dart';

class ComplaintTypeDropDown extends StatefulWidget {
  const ComplaintTypeDropDown({super.key, this.onSaved});

  final void Function(ComplaintType?)? onSaved;

  @override
  State<ComplaintTypeDropDown> createState() => _ComplaintTypeDropDownState();
}

class _ComplaintTypeDropDownState extends State<ComplaintTypeDropDown> {
  late ComplaintType _complaintType;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _complaintType = ComplaintType.customerService;
    _controller.text = _complaintType.localize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      validator: qValidator([IsRequired(S.of(context).required)]),
      onSaved: (value) {
        widget.onSaved?.call(_complaintType);
      },
      decoration: InputDecoration(
          label: Text(S.of(context).selectComplaintType),
          suffixIcon: const Icon(Icons.arrow_drop_down)),
      onTap: () {
        showAdaptiveModalBottomSheet(
            context: context,
            builder: (context) {
              return AppDropDownBottomSheet<ComplaintType>(
                title: (item) => item.localize,
                items: ComplaintType.values,
                onTap: (item) {
                  _complaintType = item;
                  _controller.text = item.localize;
                },
              );
            });
      },
    );
  }
}

enum ComplaintType {
  customerService,
  technicalIssue,
}

extension ComplaintTypeExtension on ComplaintType {
  String get localize {
    switch (this) {
      case ComplaintType.customerService:
        return S.current.customerService;
      case ComplaintType.technicalIssue:
        return S.current.technicalIssue;
      default:
        return '';
    }
  }

  String get name {
    switch (this) {
      case ComplaintType.customerService:
        return 'Customer Service';
      case ComplaintType.technicalIssue:
        return 'Technical Issue';
      default:
        return '';
    }
  }
}
