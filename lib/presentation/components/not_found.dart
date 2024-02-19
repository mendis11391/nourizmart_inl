import '../../app/utils/app_export.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route not found'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText(
              text: '4 0 4',
              size: 40,
              color: Colors.red,
              weight: FontWeight.bold,
            ),
            SizedBox(height: getVerticalSize(50)),
            const AppText(
              text: 'Error route in RouteGenerator',
              size: 16,
              color: Colors.red,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
