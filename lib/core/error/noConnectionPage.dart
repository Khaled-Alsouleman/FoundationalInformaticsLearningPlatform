import 'package:foundational_learning_platform/core/utils/index.dart';
class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: RoundedShadowContainer(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppDimensions.paddingXLarge),
              SizedBox(
                width:  screenSize.width /4,
                height:  screenSize.width /4,
                child: LottieBuilder.asset(
                  'animation/noConnection.json',
                ),
              ),
               Text('Überprüfen Sie bitte Ihre internetverbindung',
                  style: textTheme.headlineSmall,)
            ],
          ),
      ),
    );
  }
}
