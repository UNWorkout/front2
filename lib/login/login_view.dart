import 'package:flutter/material.dart';
import 'package:un_work_out/login/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GraphQLService _graphQLService = GraphQLService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void handleLogin() async {
    try {
      var response = await _graphQLService.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.containsKey('token')) {
        Navigator.pushNamed(context, '/routines');
      } else {
        debugPrint('Inicio de sesión fallido');
      }
    } catch (e) {
      debugPrint('Error al iniciar sesión: $e');
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Correo electronico",
                    hintText: "Ingrese su correo electronico gmail",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    hintText: "Ingrese su contraseña",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 5.0, bottom: 5.0, right: 4.0),
                    child: ElevatedButton(
                      child: const Text("Ingresar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD60909),
                      ),
                      onPressed: () {
                        handleLogin();
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, top: 5.0, bottom: 5.0, right: 5.0),
                    child: ElevatedButton(
                      child: const Text("Registrarse"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD60909),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
