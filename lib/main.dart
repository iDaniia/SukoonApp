import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sukoon/Pages/Lodear.dart';
import 'package:sukoon/Pages/classes/noti.dart';
import 'package:sukoon/bloc/authentication_bloc.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Noti.init();
  runApp(const MyApp());
}

class DefaultFirebaseOptions {}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationBloc(),
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: LoaderPage()));
  }
}