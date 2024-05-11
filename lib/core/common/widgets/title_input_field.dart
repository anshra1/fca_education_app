import 'package:fca_education_app/core/common/widgets/i_field.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class TiltledInputField extends StatelessWidget {
  const TiltledInputField({
    required this.controller,
    required this.title,
    this.required = true,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    super.key,
  });
  final bool required;
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.neutralTextColour,
                ),
                children: !required
                    ? null
                    : [
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colours.redColour),
                        ),
                      ],
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const Gap(10),
        IField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          style: hintStyle,
          overrideValidator: true,
          validator: (value) {
            if (!required) return null;
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
