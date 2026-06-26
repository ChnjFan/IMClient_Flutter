import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/db/daos/friend_dao.dart';

class FriendListLogic extends GetxController {
  static const double sectionHeaderHeight = 40;
  static const double contactItemHeight = 64;
  static const double indexBarWidth = 24;
  static const double indexLetterHeight = 15;

  final ScrollController scrollController = ScrollController();

  final Map<String, GlobalKey> sectionKeys = {};
  final Map<String, double> letterOffsets = {};
  final RxString highlightedLetter = ''.obs;

  Map<String, List<FriendWithProfile>> groups = {};
  List<String> groupKeys = [];
  String Function(FriendWithProfile) displayName = (_) => '';
  double topOffset = 0;

  void computeOffsets() {
    letterOffsets.clear();
    double offset = topOffset;
    for (final key in groupKeys) {
      sectionKeys.putIfAbsent(key, () => GlobalKey());
      letterOffsets[key] = offset;
      offset += sectionHeaderHeight;
      offset += (groups[key]?.length ?? 0) * contactItemHeight;
    }
  }

  int totalItemCount() {
    int count = 0;
    for (final key in groupKeys) {
      count++;
      count += groups[key]!.length;
    }
    return count;
  }

  void scrollToLetter(String letter) {
    final offset = letterOffsets[letter];
    if (offset != null && scrollController.hasClients) {
      final maxScroll = scrollController.position.maxScrollExtent;
      scrollController.animateTo(
        offset.clamp(0.0, maxScroll),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  String? getLetterAtPosition(Offset localPosition) {
    const letters = contactsIndexLetters;
    final effectiveHeight = letters.length * indexLetterHeight;
    if (effectiveHeight <= 0) return null;
    final index = (localPosition.dy / (effectiveHeight / letters.length)).floor();
    if (index < 0 || index >= letters.length) return null;
    return letters[index];
  }

  void onIndexBarTap(Offset localPosition) {
    final letter = getLetterAtPosition(localPosition);
    if (letter != null && groupKeys.contains(letter)) {
      scrollToLetter(letter);
    }
  }

  void onIndexBarDrag(Offset localPosition) {
    final letter = getLetterAtPosition(localPosition);
    if (letter != null && letter != highlightedLetter.value) {
      highlightedLetter.value = letter;
      if (groupKeys.contains(letter)) {
        scrollToLetter(letter);
      }
    }
  }

  void clearHighlight() => highlightedLetter.value = '';

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

/// 右侧索引栏字母表（A-Z + #）。
// ignore: constant_identifier_names
const List<String> contactsIndexLetters = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
  'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
  'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '#',
];
