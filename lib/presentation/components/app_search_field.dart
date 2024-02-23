import '../../app/utils/app_export.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final VoidCallback? callBackClear, callBackPrefix, callBackSearch;
  //final isPrefixIconVisible = false;
  final String labelText;
  final String? helpText;
  final Widget? suffix;
  final bool? enabled, removeCardShape;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final double? marginLeft, marginTop, marginRight, marginBottom, marginAll;
  final Color? fillColor;

  const AppSearchField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    this.callBackClear,
    //this.isPrefixIconVisible = false,
    this.callBackSearch,
    this.callBackPrefix,
    this.focusNode,
    this.onTap,
    this.suffix,
    this.labelText = 'Search',
    this.helpText = 'Search',
    this.marginLeft,
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginAll,
    this.enabled,
    this.removeCardShape = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getSize(removeCardShape! ? 0 : 10)),
      ),
      child: Container(
        //height: 55,
        margin: getMargin(
            left: marginLeft ?? marginAll ?? 4,
            top: marginTop ?? marginAll ?? 4,
            right: marginRight ?? marginAll ?? 4,
            bottom: marginBottom ?? marginAll ?? 4),

        child: TextFormField(
          enabled: enabled ?? true,
          controller: textEditingController,
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.sentences,
          focusNode: focusNode,
          style: TextStyle(fontSize: getFontSize(13)),
          onTap: onTap,
          decoration: InputDecoration(
            border: InputBorder.none,
            // isCollapsed: true,
            contentPadding: getPadding(all: 4),
            suffixIcon: suffix,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                size: getSize(20),
                color: Colors.black54,
              ),
              onPressed: callBackPrefix,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(getSize(5)),
              ),
              borderSide: BorderSide(
                  color: Colors.transparent, width: getHorizontalSize(1.25)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(getSize(2)),
                ),
                borderSide: BorderSide(
                    color: getPrimaryColor(), width: getHorizontalSize(2))),
            filled: true,
            hintStyle: TextStyle(
                fontSize: getFontSize(13),
                color: Colors.black54,
                textBaseline: TextBaseline.alphabetic),
            hintText: helpText,
            labelText: labelText,
            fillColor: fillColor ?? AppColors.editFillColor,
          ),
          enableSuggestions: false,
          autocorrect: false,
        ),
      ),
    );
  }
}
