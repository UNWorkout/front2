import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:un_work_out/base/graphql_config.dart';

class GraphQLService {
  static final graphQLConfig = GraphQLConfig();
  static final graphQLClient = graphQLConfig.clientToQuery();

  Future<Map<String, String>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
              mutation LoginUser(\$email: String!, \$password: String!) {
                loginUser(email: \$email, password: \$password) {
                  msg
                  token
                }
              }
              """,
          ),
          variables: {
            'email': email,
            'password': password,
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
      var res = result.data?['loginUser'];
      if (res == null) {
        throw Exception('Login failed');
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', res['token']);
      return {
        'msg': res['msg'],
        'token': res['token'],
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
