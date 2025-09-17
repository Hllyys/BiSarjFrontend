import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> initGraphQLClient({String? token}) {
  final httpLink = HttpLink('http://192.168.1.222:6189/api/graphql');

  Link link = httpLink;

  if (token != null && token.isNotEmpty) {
    final authLink = AuthLink(getToken: () async => 'Bearer $token');
    link = authLink.concat(httpLink);
  }

  return ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: null)),
  );
}
