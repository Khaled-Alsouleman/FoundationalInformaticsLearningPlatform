import 'package:foundational_learning_platform/core/utils/index.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;

    return Padding(
      padding: EdgeInsets.only(
        right: AppDimensions.paddingLarge,
        left: AppDimensions.paddingLarge,
        top: screenHeight > 594 ? 150 : 100,
      ),
      child: Column(
        children: [
          const Row(
            children: [],
          ),
          // Home-Content
          Text(
            AppContents.welcomeContent,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorsTheme.primaryColor,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          SizedBox(
            width: screenWidth / 2,
            child: Text(
              AppContents.plattformDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorsTheme.primaryColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Expanded(
            child: SizedBox(
              width: screenHeight / 3,
              child: LottieBuilder.network(
                'https://lottie.host/a7cc350e-7b40-42f4-89bf-e8bd10f3f4b7/Pn7QohtyDN.json',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
