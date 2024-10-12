import 'package:foundational_learning_platform/core/utils/index.dart';

class BuildInputField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Function(String value)? onChanged;
  final String? Function(String?)? validator;

  const BuildInputField({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.label,
    this.hintText = '',
    this.validator,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: MyTextField(
        globalKey: formKey,
        controller: controller,
        label: Text(label),
        hintText: hintText,
        validator: validator,
        onChanged: onChanged?? (_){},
      ),
    );
  }
}
