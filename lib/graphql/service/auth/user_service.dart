import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../graphql/mutations.dart';

class UserService {
  static GraphQLClient _clientOf(BuildContext context) =>
      GraphQLProvider.of(context).value;

  /// meUser { token, user{...} } döner
  static Future<Map<String, dynamic>?> fetchMeUser(BuildContext context) async {
    final client = _clientOf(context);
    final result = await client.query(
      QueryOptions(
        document: gql(meUserQuery),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) {
      throw result.exception!;
    }
    return result.data?['meUser'] as Map<String, dynamic>?;
  }

  /// SP’de userId yoksa meUser ile çekip SP’ye yazar.
  /// meUser.token dönerse SP’deki 'token' değerini de günceller.
  static Future<int?> ensureUserIdFromMeUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // 1) SP’de zaten varsa direkt dön
    final cached = prefs.getInt('userId');
    if (cached != null && cached > 0) return cached;

    // 2) meUser çağır
    final meUser = await fetchMeUser(context);
    if (meUser == null) return null;

    // 3) user.id'yi yaz
    final user = meUser['user'] as Map<String, dynamic>?;
    final int? id = user?['id'] as int?;
    if (id != null && id > 0) {
      await prefs.setInt('userId', id);
    }

    return id;
  }
}
