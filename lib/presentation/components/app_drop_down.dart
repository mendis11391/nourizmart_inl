import '../../app/utils/app_export.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String? hintText;
  final List<T>? options;
  final T? value;
  final String Function(T)? getLabel;
  final void Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;
  final Color? fillColor;
  final bool? isNoTitle;
  final bool? isNeedMultilingual;
  final bool? isEnabled;
  final GlobalKey<FormFieldState<String>>? dropdownKey;

  const AppDropdownInput({
    super.key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
    this.validator,
    this.isNoTitle,
    this.fillColor = Colors.white,
    this.isNeedMultilingual = true,
    this.isEnabled = true,
    this.dropdownKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(getSize(5)),
      ),
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  getPadding(left: 10, right: 10), // , bottom: 2, top: 2
              labelText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getSize(5)),
              ),
            ),
            isEmpty: value == null || value == '',
            child: IgnorePointer(
              ignoring: !(isEnabled ?? true),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<T>(
                  key: dropdownKey,
                  // dropdownColor: AppColors.commonThemeShade50,
                  dropdownColor: AppColors.appThemeColor.shade50,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: getPrimaryColor(),
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  validator: validator,
                  value: value,
                  isDense: true,
                  onChanged: onChanged,
                  items: options!.map((T value) {
                    return DropdownMenuItem<T>(
                      value: value,
                      child: Text(
                        (isNeedMultilingual ?? false)
                            ? getLabel!(value).tr
                            : getLabel!(value),
                        style: TextStyle(
                          color: (isNoTitle ?? false)
                              ? Colors.black
                              : (value.toString() == options!.first)
                                  ? Colors.black54
                                  : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
