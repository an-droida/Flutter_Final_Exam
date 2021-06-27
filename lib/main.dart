import 'package:final_exam/cubit/expenses_cubit.dart';
import 'package:final_exam/presentation/router/app_router.dart';
import 'package:final_exam/utility/app_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpensesDataCubit>(
          create: (context) => ExpensesDataCubit(),
        ),
      ],
      child: MaterialApp(
        title: "My Expenses",
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
