import '../../app/utils/app_export.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final String name;
  final ValueChanged<bool>? onChanged;
  final GestureTapCallback? onTap;

  const AppSwitch({
    super.key,
    required this.value,
    required this.name,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Transform.scale(
            scale: 1.1,
            child: Switch(
              value: value,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.shade300,
              activeColor: getPrimaryColor(),
              onChanged: onChanged,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: getPadding(right: 5, top: 5, bottom: 5),
              child: AppText(
                text: name,
                size: 12,
              ),
            ),
          )
        ],
      );
}
