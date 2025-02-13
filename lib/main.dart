import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/blocs/players_cubit.dart';
import 'package:quizz/blocs/settings_cubit.dart';
import 'package:quizz/repositories/quiz_category_repository.dart';
import 'package:quizz/ui/screens/home_screen.dart';
import 'package:quizz/ui/screens/player_selection_screen.dart';
import 'package:quizz/ui/screens/quiz_screen.dart';
import 'package:quizz/ui/screens/quiz_settings_screen.dart';
import 'blocs/category_cubit.dart';

void main() {

  // Cubits instantiation
  final CategoryCubit categoryCubit = CategoryCubit(QuizCategoryRepository());
  final SettingsCubit settingsCubit = SettingsCubit();
  final PlayersCubit playersCubit = PlayersCubit();

  categoryCubit.loadCategories();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<CategoryCubit>(create: (_) => categoryCubit),
          BlocProvider<SettingsCubit>(create: (_) => settingsCubit),
          BlocProvider<PlayersCubit>(create: (_) => playersCubit),
        ],
        child: const MyApp()
      )
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto', // Change la police globale
        // textTheme: TextTheme(
        //   bodyLarge: const TextStyle(fontSize: 18, color: Colors.black),
        //   bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[600]),
        //   headlineLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            shadowColor: Colors.pinkAccent.withOpacity(0.9), // Effet de néon (ombre rose)
            elevation: 0, // Ombre plus prononcée pour le néon
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF3d485e), // Fond sombre des cartes en mode dark
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/player-selection': (context) => const PlayerSelectionScreen(),
        '/quiz-settings': (context) => const QuizSettingsScreen(),
        '/quiz': (context) =>  const QuizScreen(),
      },
      initialRoute: '/home',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
