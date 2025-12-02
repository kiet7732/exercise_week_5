import 'package:exercise_week_5/providers/note_provider.dart';
import 'package:exercise_week_5/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const SimpleNoteApp());
}

class SimpleNoteApp extends StatelessWidget {
  const SimpleNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Bọc ứng dụng với ChangeNotifierProvider để cung cấp NoteProvider
    // cho toàn bộ cây widget.
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        title: 'Simple Note App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
