import 'package:foundational_learning_platform/core/utils/index.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String initialValue;
  final String label;
  final ValueChanged<String?> onChanged;
  const MyDropdownMenu({super.key, required this.items, required this.initialValue, required this.label, required this.onChanged});


  @override
  Widget build(BuildContext context) {
    String? dropdownValue = items.contains(initialValue) ? initialValue : null;
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style:  textTheme.labelLarge!.copyWith(color: colorTheme!.inactiveColor)),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: textTheme.labelLarge,),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
