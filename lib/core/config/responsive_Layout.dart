import 'package:foundational_learning_platform/core/utils/index.dart';

class ResponsiveLayout extends StatelessWidget {
 final Widget mobileBody;
 final Widget desktopBody;

 const ResponsiveLayout({super.key, required this.mobileBody, required this.desktopBody});

 @override
 Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

 if (kDebugMode) {
   print("Screen width: $screenWidth");
 }
  if (screenWidth < 600) {
   return mobileBody;
  } else {
   return desktopBody;
  }
 }
}
