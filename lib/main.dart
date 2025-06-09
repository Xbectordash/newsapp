import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_state.dart';
import 'package:newsapp/data/model/theme_model.dart';
import 'package:newsapp/presentation/screens/news_landing_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Load env file
  runApp(MyApp());
}

// void main(){
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => NewsBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.isLigthMode?ThemeModel().lightMode:ThemeModel().darkMode,
            home: NewsLandingScreen(),
          );
        },
      ),
    );
  }
}
