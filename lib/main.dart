import 'package:flutter/material.dart';
import 'package:internship_task/ui_task.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:internship_task/utils/routes/routes.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internship_task/viewmodel/bottom_nav_view_model.dart';
import 'package:internship_task/viewmodel/task_view_view_model.dart';
import 'package:internship_task/viewmodel/homeviewviewmodel.dart';
import 'package:internship_task/viewmodel/profile_view_view_model.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ImageUtils(),),
      ChangeNotifierProvider(create: (context) => BottomNavViewModel(),),
      ChangeNotifierProvider(create: (context) => HomeViewViewModel(),),
      ChangeNotifierProvider(create: (context) => ProfileViewViewModel(),),
      ChangeNotifierProvider(create: (context) => TaskViewViewModel(),)
    ],
    child:  OverlayKit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: (settings) {
          return Routes.generateRoute(settings);
        },
      ),
    )
    );
  }
}

