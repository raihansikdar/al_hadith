

import 'package:al_hadith/data/controller/book_controller.dart';
import 'package:al_hadith/data/controller/chapter_controller.dart';
import 'package:get/get.dart';

class StateBinder extends Bindings{
  @override
  void dependencies() {
  Get.put(ChapterController());
  Get.put(BookController());
  }

}