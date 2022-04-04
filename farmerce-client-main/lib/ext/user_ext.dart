import 'package:farmerce_client/graphql/user.data.gql.dart';

extension UserExt on GUserData {
  String get name {
    if (userProfile?.user.firstName.isNotEmpty ?? false) {
      return "${userProfile?.user.firstName} ${userProfile?.user.lastName}";
    }
    return "${userProfile?.phoneNumber}";
  }
}
