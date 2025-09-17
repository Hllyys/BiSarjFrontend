import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../mutations.dart';

class LoginService {
  final GraphQLClient client;

  LoginService(this.client);

  Future<bool> login(String email, String password, bool rememberMe) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(loginMutation),
        variables: {"email": email, "password": password},
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final token = result.data?['loginUser']['token'];
    final user = result.data?['loginUser']['user'];

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();

      if (rememberMe) {
        await prefs.setString("token", token);
        await prefs.setString("userFirstName", user['firstName']);
        await prefs.setString("userLastName", user['lastName']);
        await prefs.setBool("rememberMe", true);
      } else {
        await prefs.clear(); 
      }
      return true;
    }
    return false;
  }
}
