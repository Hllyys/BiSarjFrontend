import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Bu fonksiyon, GraphQL bağlantısını kurar.
//Token'ı otomatik olarak SharedPreferences'tan çeker.
Future<ValueNotifier<GraphQLClient>> buildGraphQLClient() async {
  // Hive önbelleğini başlat (GraphQL için zorunlu)
  await initHiveForFlutter();

  // Backend GraphQL endpoint
  final httpLink = HttpLink('http://192.168.1.222:6189/api/graphql');

  //  Authorization header (token ekleme)
  final authLink = AuthLink(
    getToken: () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      debugPrint('AuthLink token: $token');
      return (token == null || token.isEmpty) ? null : 'Bearer $token';
    },
  );

  //  Linkleri birleştir
  final link = authLink.concat(httpLink);

  // Client oluştur
  final client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  return client;
}
