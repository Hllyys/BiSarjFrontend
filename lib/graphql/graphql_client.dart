import 'package:flutter/foundation.dart';  
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ValueNotifier<GraphQLClient>> buildGraphQLClient() async {
  await initHiveForFlutter();

  final httpLink = HttpLink('http://192.168.1.222:6189/api/graphql');

  final authLink = AuthLink(
    getToken: () async {
      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString('token');
      debugPrint('AuthLink token: $t'); // geçici log
      return (t == null || t.isEmpty) ? null : 'Bearer $t';
    },
  );

  final link = authLink.concat(httpLink);

  return ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
}
