import 'package:flutter/material.dart';
import 'package:un_work_out/register/register_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GraphQLService _graphQLService = GraphQLService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cellPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "Nombres",
                      hintText: "ingrese sus nombres",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      labelText: "Apellidos",
                      hintText: "Ingrese sus apellidos",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                      labelText: "Fecha de nacimiento",
                      hintText: "DD/MM/AAAA",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                      labelText: "Sexo",
                      hintText: "Ingrese su sexo",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _cellPhoneController,
                  decoration: InputDecoration(
                      labelText: "Celular",
                      hintText: "Ingrese su celular",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Correo electronico",
                      hintText: "ingrese su correo electronico",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: "Contraseña",
                      hintText: "Ingrese su contraseña",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: 5, left: 100, top: 10, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _graphQLService.createUser(
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            birthDate: _birthDateController.text,
                            gender: _genderController.text,
                            cellPhone: _cellPhoneController.text,
                            email: _emailController.text,
                            password: _passwordController.text);
                      },
                      child: Text("Registrar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD60909),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 5, left: 5, top: 10, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text("Cancelar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD60909),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
