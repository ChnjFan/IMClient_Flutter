// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_dao.dart';

// ignore_for_file: type=lint
mixin _$CredentialDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserCredentialsTable get userCredentials => attachedDatabase.userCredentials;
  CredentialDaoManager get managers => CredentialDaoManager(this);
}

class CredentialDaoManager {
  final _$CredentialDaoMixin _db;
  CredentialDaoManager(this._db);
  $$UserCredentialsTableTableManager get userCredentials =>
      $$UserCredentialsTableTableManager(
        _db.attachedDatabase,
        _db.userCredentials,
      );
}
