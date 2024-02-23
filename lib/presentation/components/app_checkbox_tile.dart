import '../../app/utils/app_export.dart';

class AppCheckboxListTile extends StatefulWidget {
  final EdgeInsetsGeometry contentPadding;
  final Widget title;
  final String item;
  final RxList<String> selectedItems;
  final ValueSetter<bool?>? onChanged;

  const AppCheckboxListTile({
    super.key,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
    required this.title,
    required this.item,
    required this.selectedItems,
    required this.onChanged,
  });

  @override
  AppCheckboxListTileState createState() => AppCheckboxListTileState();
}

class AppCheckboxListTileState extends State<AppCheckboxListTile> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.selectedItems.contains(widget.item);
  }

  @override
  void didUpdateWidget(covariant AppCheckboxListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.selectedItems.contains(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final newValue = !value;
        setState(() {
          value = newValue;
        });
        widget.onChanged?.call(newValue);
      },
      child: Container(
        padding: widget.contentPadding,
        child: Row(
          children: [
            Expanded(child: widget.title),
            Checkbox(
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue ?? false;
                });
                widget.onChanged?.call(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
