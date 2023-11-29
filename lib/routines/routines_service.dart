import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:un_work_out/base/graphql_config.dart';

class GraphQLService {
  static final graphQLConfig = GraphQLConfig();
  static final graphQLClient = graphQLConfig.clientToQuery();

  // Agregar Rutina
  Future<void> addRoutine(
      String usuarioId, List<Map<String, dynamic>> diasSemana) async {
    try {
      await graphQLClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation AddRoutine(\$usuarioId: ID!, \$diasSemana: [ExercisedayInput]) {
              addRoutine(usuario_id: \$usuarioId, dias_semana: \$diasSemana) {
                
              }
            }
            """,
          ),
          variables: {
            'usuarioId': usuarioId,
            'diasSemana': diasSemana,
          },
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Actualizar Rutina
  Future<Map<String, dynamic>> updateRoutine(String id, String? day,
      List<int>? ejercicios, String? horaInicio, int? duracionMax) async {
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation UpdateRoutine(\$id: ID!, \$day: String, \$ejercicios: [Int], \$horaInicio: String, \$duracionMax: Int) {
              updateRoutine(ID: \$id, DAY: \$day, ejercicios: \$ejercicios, Hora_inicio: \$horaInicio, Duracion_Max: \$duracionMax) {
                _id
                dias_semana {
                  
                }
                promedio
                usuario_id
              }
            }
            """,
          ),
          variables: {
            'id': id,
            'day': day,
            'ejercicios': ejercicios,
            'horaInicio': horaInicio,
            'duracionMax': duracionMax,
          },
        ),
      );
      return result.data?['updateRoutine'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Eliminar Rutina
  Future<void> deleteRoutine(String id) async {
    try {
      await graphQLClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation DeleteRoutine(\$id: ID!) {
              deleteRoutine(ID: \$id) {
                _id
              }
            }
            """,
          ),
          variables: {
            'id': id,
          },
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Consulta de Rutina de Usuario
  Future<List> routineUser(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('Auth token not found');
    }
    try {
      final result = await graphQLClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            query RoutineUser(\$id: ID!) {
            routineUser(ID: \$id) {
              dias_semana {
                Duracion_Max
                Hora_inicio
                dia
                ejercicios
              }
            }
          }
            """,
          ),
          variables: {
            'id': id,
          },
          context: Context().withEntry(
            HttpLinkHeaders(
              headers: {
                'auth': '$token',
              },
            ),
          ),
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
      List? res = result.data?['routineUser']['dias_semana'];
      if (res == null || res.isEmpty) {
        return [];
      }

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
