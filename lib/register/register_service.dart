import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:un_work_out/base/graphql_config.dart';

class GraphQLService {
  static final graphQLConfig = GraphQLConfig();
  static final graphQLClient = graphQLConfig.clientToQuery();

  Future<String> getUserEmailById({required String id}) async {
    try {
      QueryResult result = await graphQLClient.query(
        QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(
              """ 
              query GetUserEmailById(\$id: String!) {
                getUserEmailById(id: \$id) {
                  msg
                  email
                  }
                }
              """,
            ),
            variables: {
              'id': id,
            }),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }
      var res = result.data?['getUserEmailById'];
      if (res == null) {
        throw Exception('User not found');
      }
      return res['email'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> createUser({
    required String name,
    required String lastName,
    required String birthDate,
    required String gender,
    required String cellPhone,
    required String email,
    required String password,
  }) async {
    try {
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
              mutation CreateUser(\$name: String!, \$lastName: String!, \$birthDate: String!, \$gender: String!, \$cellPhone: String!, \$email: String!, \$password: String!) {
                createUser(name: \$name, lastName: \$lastName, birthDate: \$birthDate, gender: \$gender, cellPhone: \$cellPhone, email: \$email, password: \$password) {
                  msg
                }
              }
              """,
          ),
          variables: {
            'name': name,
            'lastName': lastName,
            'birthDate': birthDate,
            'gender': gender,
            'cellPhone': cellPhone,
            'email': email,
            'password': password,
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }
      var res = result.data?['createUser'];
      if (res == null) {
        throw Exception('Failed to create user');
      }
      return res['msg'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
