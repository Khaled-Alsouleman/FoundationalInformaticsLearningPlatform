import 'package:foundational_learning_platform/core/utils/index.dart';

class NoDataPage extends StatelessWidget {
  final String message;

  const NoDataPage({super.key, this.message = 'Es wurden keine Daten gefunden!!'});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Animate(
      child: RoundedShadowContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: LottieBuilder.asset(
                  'animation/oopsNoData.json',
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().shader();
  }
}
