// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_dao.dart';

// ignore_for_file: type=lint
mixin _$FriendRequestDaoMixin on DatabaseAccessor<AppDatabase> {
  $FriendRequestsTable get friendRequests => attachedDatabase.friendRequests;
  $UserProfilesTable get userProfiles => attachedDatabase.userProfiles;
  FriendRequestDaoManager get managers => FriendRequestDaoManager(this);
}

class FriendRequestDaoManager {
  final _$FriendRequestDaoMixin _db;
  FriendRequestDaoManager(this._db);
  $$FriendRequestsTableTableManager get friendRequests =>
      $$FriendRequestsTableTableManager(
        _db.attachedDatabase,
        _db.friendRequests,
      );
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db.attachedDatabase, _db.userProfiles);
}
