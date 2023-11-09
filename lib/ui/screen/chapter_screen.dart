import 'package:al_hadith/ui/widgets/text_component.dart';
import 'package:al_hadith/controller/database_controller.dart';
import 'package:al_hadith/ui/uitility/assets_path.dart';
import 'package:al_hadith/ui/uitility/custom_size_extention.dart';
import 'package:al_hadith/ui/uitility/style.dart';
import 'package:al_hadith/ui/widgets/searchBar_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChapterScreen extends StatefulWidget {
  final int bookId;
   ChapterScreen({super.key, required this.bookId});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ChapterController>().fetchChapterListData(id: widget.bookId);
    });

    print("========>${widget.bookId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: const Icon(Icons.arrow_back_ios)),
          title: Padding(
            padding:  EdgeInsets.only(top: 8.rh),
            child: GetBuilder<ChapterController>(
              builder: (_chapterController) {
                if(_chapterController.chapterList.isEmpty){
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                        text: _chapterController.chapterList.first.bookName ?? '',
                        color: AppColors.whiteColor,
                        fontSize: Constants.textSmallFontSize,
                        fontWeight: Constants.titleFontWeight,
                        height: 0.06
                    ),
                    SizedBox(height: 14.rh,),
                    TextComponent(
                        text: "7525 Hadith",
                        color: AppColors.whiteColor,
                        fontSize: Constants.k12FontSize,
                        fontWeight: Constants.mediumFontWeight,
                        height: 0.10
                    ),
                  ],
                );
              }
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(AssetsPath.dothSVG),
            ),
          ],
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),


        body: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.rh),
              topRight: Radius.circular(20.rh),
            ),
            color: AppColors.boxColor,
          ),
          child:  SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(16.rh),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBarWidget(),
                  SizedBox(height: 16.rh,),
                  GetBuilder<ChapterController>(
                    builder: (_chapterController) {
                      if(_chapterController.isLoading){
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.separated(
                       // physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _chapterController.chapterList.length,
                          itemBuilder: (context,index){
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10.rh)
                            ),
                            child: ListTile(
                              tileColor: AppColors.whiteColor,
                              leading: Container(
                                height: 40.rh,
                                width: 40.rh,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(20.rh)
                                ),
                                child: Center(
                                  child: TextComponent(
                                      text: index.toString(),
                                      textAlign: TextAlign.center,
                                      color: AppColors.whiteColor,
                                      fontSize: Constants.textFontSize,
                                      fontWeight: Constants.regularFontWeight,
                                      height: 1.0),
                                ),
                              ),
                              title: TextComponent(
                                  text: _chapterController.chapterList[index].title ?? '',
                                  color: AppColors.TileTitleTextColor,
                                  fontSize: Constants.k14FontSize,
                                  fontWeight: Constants.mediumFontWeight,
                                  height: 0.10,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                              ),
                              subtitle: TextComponent(
                                  text: _chapterController.chapterList[index].hadisRange ?? '',
                                  color: AppColors.TileSubTitleTextColor,
                                  fontSize: Constants.k12FontSize,
                                  fontWeight: Constants.mediumFontWeight,
                                  height: 0.10
                              ),
                            ),
                          );
                          }, separatorBuilder: (context,index)=>SizedBox(height: 8.rh,),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

