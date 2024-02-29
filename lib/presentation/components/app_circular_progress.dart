import '../../app/utils/app_export.dart';

class AppCircularProgress extends StatelessWidget {
  final String? loadingText;
  const AppCircularProgress({super.key, this.loadingText = 'Please wait...'});

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Padding(
            padding: getPadding(top: 20),
            child: Visibility(
              visible: !isFieldEmpty(loadingText),
              replacement: CircularProgressIndicator(
                color: getPrimaryColor(),
                strokeWidth: getSize(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: getSize(23),
                    height: getSize(23),
                    child: CircularProgressIndicator(
                      color: getPrimaryColor(),
                      strokeWidth: getSize(2),
                    ),
                  ),
                  SizedBox(width: getHorizontalSize(10)),
                  AppText(text: loadingText!, size: 16)
                ],
              ),
            ),
          ),
        ),
      );
}
