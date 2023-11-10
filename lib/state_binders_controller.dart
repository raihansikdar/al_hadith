import 'package:al_hadith/controller/book_controller.dart';
import 'package:al_hadith/controller/chapter_controller.dart';

import 'package:get/get.dart';

class StateBinder extends Bindings{
  @override
  void dependencies() {
  Get.put(ChapterController());
  Get.put(BookController());
  }

}