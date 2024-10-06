import 'package:foundational_learning_platform/core/shared/bloc_providers.dart';
import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:foundational_learning_platform/core/utils/my_Global_Observer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await AppBlocProviders.getProviders();

  Bloc.observer = MyGlobalObserver();
  runApp(MyApp(providers: providers));
}

class MyApp extends StatelessWidget {
  final List<BlocProvider> providers;

  const MyApp({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grundlagen Informatik',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
