import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siakad_app/bloc/login/login_bloc.dart';
import 'package:siakad_app/data/datasources/local_remote_datasource.dart';
import 'package:siakad_app/pages/auth/auth_page.dart';
import 'package:siakad_app/pages/auth/splash_page.dart';
import 'package:siakad_app/pages/mahasiswa/mahasiswa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Siakad App",
      home: FutureBuilder(
        future: AuthLocalDatasource().isLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return const MahasiswaPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
