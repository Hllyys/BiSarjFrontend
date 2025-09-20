import 'package:flutter/widgets.dart';
import 'package:frontend_bisarj/graphql/mutations.dart' as Mutations;
import 'package:graphql_flutter/graphql_flutter.dart';

class AccountService {
  static GraphQLClient _clientOf(BuildContext context) =>
      GraphQLProvider.of(context).value;

  static Future<Map<String, dynamic>?> deleteUser(
    BuildContext context, {
    required int id,
    bool? trash = true,
  }) async {
    final client = _clientOf(context);

    final result = await client.mutate(
      MutationOptions(
        document: gql(Mutations.deleteUser),
        variables: {'id': id, if (trash != null) 'trash': trash},
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data?['deleteUser'] as Map<String, dynamic>?;
  }
}
