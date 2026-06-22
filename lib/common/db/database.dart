import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';
import 'daos/credential_dao.dart';
import 'daos/user_dao.dart';
import 'daos/conversation_dao.dart';
import 'daos/message_dao.dart';
import 'daos/friend_dao.dart';
import 'daos/friend_request_dao.dart';
import 'daos/settings_dao.dart';

part 'database.g.dart';

/// 应用数据库。
///
/// 全局唯一实例，通过 Get.put(..., permanent: true) 注入。
@DriftDatabase(
  tables: [
    UserCredentials,
    UserProfiles,
    Conversations,
    Messages,
    Friends,
    FriendRequests,
    AppSettings,
  ],
  daos: [
    CredentialDao,
    UserProfileDao,
    ConversationDao,
    MessageDao,
    FriendDao,
    FriendRequestDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}

/// 在后台线程打开数据库，避免阻塞 UI。
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imclient.db'));
    return NativeDatabase.createInBackground(file);
  });
}
