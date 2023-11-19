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
  Future<Map<String, dynamic>> routineUser(String id) async {
    try {
      final result = await graphQLClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            query RoutineUser(\$id: ID!) {
              routineUser(ID: \$id) {
                _id
                dias_semana {
                  Duracion_Max
                  Hora_inicio
                  _id
                  dia
                  ejercicios
                }
                promedio
                usuario_id
              }
            }
            """,
          ),
          variables: {
            'id': id,
          },
        ),
      );
      return result.data?['routineUser'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Consulta de Rutina de Usuario por Día
  Future<Map<String, dynamic>> routineUserDay(String id, String day) async {
    try {
      final result = await graphQLClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            query RoutineUserDay(\$id: ID!, \$day: String!) {
              routineUserDay(ID: \$id, DAY: \$day) {
                Duracion_Max
                Hora_inicio
                _id
                dia
                ejercicios
              }
            }
            """,
          ),
          variables: {
            'id': id,
            'day': day,
          },
        ),
      );
      return result.data?['routineUserDay'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
