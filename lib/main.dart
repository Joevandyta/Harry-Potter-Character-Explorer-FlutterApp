import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_char_app/core/dependency_injection.dart';
import 'package:harry_potter_char_app/domain/models/house_name.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_bloc.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_event.dart';
import 'package:harry_potter_char_app/presentation/home_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(HarryPotterApp());
}

class HarryPotterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CharacterBloc>()..add(GetCharacterEvent(House.all.displayName))),
          ],
          child: HomeScreen()),
    );
  }
}