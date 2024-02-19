import '../../app/utils/app_export.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? helpText;
  // final IconData? prefix;
  final Widget? prefix;
  final Widget? suffix;
  final bool? isPassword;
  final bool? enabled;
  final bool? readOnly;
  final bool? autofocus;
  final bool? isDense;
  final bool? isEnableInteractive;
  final TextInputAction? inputAction;
  final VoidCallback? onEditingCompleted;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines, minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool? showCursor, isFixedLabel;
  final double? horizontalPadding, verticalPadding;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final bool? autoCorrect;
  final bool? onlyUnderLine;
  final Color? enabledBorderColor,
      editTextColor,
      focusBorderColor,
      cursorColor,
      fillColor;
  final bool? isHideErrorMessage;
  final bool? isShowHintStyle, counterStyleTransparent;
  final TextStyle? hintStyle, labelStyle;

  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.helpText,
    this.prefix,
    this.suffix,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.isEnableInteractive,
    this.autofocus,
    this.isDense,
    this.inputAction,
    this.onEditingCompleted,
    this.focusNode,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
    this.textAlign,
    this.showCursor,
    this.horizontalPadding,
    this.verticalPadding,
    this.initialValue,
    this.onTap,
    this.autoCorrect,
    this.isFixedLabel = false,
    this.onlyUnderLine = false,
    this.enabledBorderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.editTextColor,
    this.isHideErrorMessage,
    this.isShowHintStyle,
    this.counterStyleTransparent,
    this.hintStyle,
    this.labelStyle,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      style: TextStyle(
          fontSize: getFontSize(17), color: (editTextColor ?? Colors.black)),
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: isPassword ?? false,
      readOnly: readOnly ?? false,
      enableInteractiveSelection: isEnableInteractive,
      autofocus: autofocus ?? false,
      textInputAction: inputAction ?? TextInputAction.done,
      onEditingComplete: onEditingCompleted,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType ?? TextInputType.name,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      showCursor: showCursor ?? true,
      cursorColor: cursorColor,
      initialValue: initialValue,
      onTap: onTap,
      autocorrect: autoCorrect ?? false,
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hint ?? '',
        hintStyle: hintStyle,
        labelText: label ?? '',
        labelStyle: labelStyle,
        helperText: (isHideErrorMessage ?? true) ? null : helpText ?? '',
        counterStyle: (counterStyleTransparent ?? false)
            ? const TextStyle(color: Colors.transparent)
            : null,
        enabled: enabled ?? true,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: (onlyUnderLine ?? false)
            ? const UnderlineInputBorder()
            : const OutlineInputBorder(),
        // hintStyle: (isShowHintStyle ?? false)
        //     ? TextStyle(color: AppColors.appBlack54)
        //     : null,
        contentPadding: (isFixedLabel ?? false)
            ? getPadding(
                left: horizontalPadding ?? 8,
                right: horizontalPadding ?? 70,
                bottom: verticalPadding ?? 10,
                top: verticalPadding ?? 10)
            : getPadding(
                left: horizontalPadding ?? 8,
                right: horizontalPadding ?? 8,
                bottom: verticalPadding ?? 10,
                top: verticalPadding ?? 10),
        filled: true,
        fillColor: (onlyUnderLine ?? false)
            ? Colors.transparent
            : fillColor ?? AppColors.editFillColor,
        focusedBorder: (onlyUnderLine ?? false)
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    width: getHorizontalSize(1), color: getPrimaryColor()))
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(getSize(4))),
                borderSide: BorderSide(
                    width: getHorizontalSize(1),
                    color: focusBorderColor ?? getPrimaryColor()),
              ),
        enabledBorder: (onlyUnderLine ?? false)
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    width: getHorizontalSize(1),
                    color: AppColors.appDividerGray))
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(getSize(4))),
                borderSide: BorderSide(
                    width: getHorizontalSize(1),
                    color: enabledBorderColor ?? Colors.transparent),
              ),
        errorBorder: (onlyUnderLine ?? false)
            ? UnderlineInputBorder(
                borderSide:
                    BorderSide(width: getHorizontalSize(1), color: Colors.red))
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(getSize(4))),
                borderSide:
                    BorderSide(width: getHorizontalSize(1), color: Colors.red)),
      ),
    );
  }
}
