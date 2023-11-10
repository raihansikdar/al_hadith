import 'dart:developer';

import 'package:al_hadith/data/chapter_model.dart';
import 'package:al_hadith/database/database_helper.dart';
import 'package:get/get.dart';

class ChapterController extends GetxController {
  bool _isLoading = false;
  List<ChapterModel> chapterList = [];

  bool get isLoading => _isLoading;

  Future<bool> fetchChapterListData({required int id}) async {
    _isLoading = true;
    update();

    final db = await DatabaseHelper().database;
    final results = await db.query('chapter', where: 'book_id = ?', whereArgs: [id]);
   // log(results.toString());
    _isLoading = false;
    update();

    if (results.isNotEmpty) {
     chapterList.clear();
      for (final result in results) {
        final chapterModel = ChapterModel.fromJson(result);
        chapterList.add(chapterModel);
      }
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}


/*
* class ChapterController extends GetxController {
  var chapterList = <ChapterModel>[].obs;
  bool _isChapterInProgress = fasle;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final db = await DatabaseHelper().database;
    final results = await db.query('chapter');
    chapterList.value = results.map((e) => ChapterModel.fromJson(e)).toList();
  }
}

* */