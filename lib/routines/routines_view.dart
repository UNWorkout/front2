import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:un_work_out/routines/routines_service.dart';
import 'package:un_work_out/base/navbar.dart';
import 'package:un_work_out/base/footer.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);
  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final GraphQLService _graphQLService = GraphQLService();
  List diasSemana = [];
  @override
  void initState() {
    super.initState();
    loadRoutineData();
  }

  void loadRoutineData() async {
    try {
      List fetchedDiasSemana = await _graphQLService.routineUser("1");
      setState(() {
        diasSemana = fetchedDiasSemana;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error al cargar los datos de la rutina: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = diasSemana.map((dia) {
      return Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Día: ${dia['dia']}'),
            ),
            Text('Duración máxima: ${dia['Duracion_Max']} minutos'),
            Text('Hora de inicio: ${dia['Hora_inicio']}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Iniciar'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      );
    }).toList();
    return Scaffold(
      appBar: Navbar(), // Usa tu clase Navbar personalizada como AppBar
      body: ListView(
        children: cards,
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
