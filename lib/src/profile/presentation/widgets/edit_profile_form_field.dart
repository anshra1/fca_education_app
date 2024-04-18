import 'package:fca_education_app/%20core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField(
     {
    required this.fieldTitle,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    super.key,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const Gap(10),
        IField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
        ),
        const Gap(30),
      ],
    );
  }
}
