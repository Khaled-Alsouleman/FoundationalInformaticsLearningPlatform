import 'package:foundational_learning_platform/core/utils/index.dart';

class MyTextField extends StatelessWidget {
  final GlobalKey globalKey;
  final Text label;
  final String? hintText;
  final InputDecoration? decoration;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;

  const MyTextField({
    Key? key,
    required this.globalKey,
    this.decoration,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    required this.label,
    this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();

    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorTheme!.primaryColor,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Material(
      color: colorTheme.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Form(
            key: globalKey,
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: controller,
                decoration: decoration?.copyWith(
                  label: label,
                  hintText:  hintText ?? '',
                  hintStyle: textTheme.labelSmall,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  errorStyle:  textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: colorTheme.errorHeight,
                  ),
                ) ??
                    InputDecoration(
                      label: label,
                      hintText: hintText ?? 'Die Eingabe soll durch Komma getrennt eingeben',
                      hintStyle: textTheme.labelSmall,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      fillColor: colorTheme.transparent,
                      focusColor: colorTheme.transparent,
                      filled: true,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      errorText: null,
                      errorStyle:  textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: colorTheme.errorHeight,
                      ),
                    ),
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                },
                onFieldSubmitted: onSubmitted ?? (value) {},
                validator: validator,
                style: textTheme.bodySmall?.copyWith(color: colorTheme.primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
