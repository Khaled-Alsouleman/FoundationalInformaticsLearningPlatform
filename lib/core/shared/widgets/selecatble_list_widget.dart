import 'package:foundational_learning_platform/core/utils/index.dart';

class ListSelectable extends StatefulWidget {
  final List<String> items;
  final Function(int) onItemSelected;
  final List<int> selectedIndices;
  final int initialSelectedIndex;

  const ListSelectable({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.selectedIndices,
    this.initialSelectedIndex = -1,
  });

  @override
  _ListSelectableState createState() => _ListSelectableState();
}

class _ListSelectableState extends State<ListSelectable> {
  late ScrollController _scrollController;
  late List<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();


    _selectedIndices = List<int>.from(widget.selectedIndices);


    if (widget.initialSelectedIndex != -1 &&
        !_selectedIndices.contains(widget.initialSelectedIndex)) {
      _selectedIndices.add(widget.initialSelectedIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 80,
      child: Center(
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: widget.items.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final isSelected = _selectedIndices.contains(index);

              return Align(
                alignment: Alignment.center,
                child: InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      if (_selectedIndices.contains(index)) {
                        _selectedIndices.remove(index);
                      } else {
                        _selectedIndices.add(index);
                      }
                    });
                    widget.onItemSelected(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSelected ? 45 : 50,
                    height: isSelected ? 45 : 50,
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorsTheme.primaryColor
                          : colorsTheme.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: colorsTheme.inactiveColor.withOpacity(.2),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.items[index],
                      style: textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? colorsTheme.white
                            : colorsTheme.primaryColor.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
