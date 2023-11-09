import 'package:al_hadith/controller/book_controller.dart';
import 'package:al_hadith/data/book_model.dart';
import 'package:al_hadith/ui/screen/chapter_screen.dart';
import 'package:al_hadith/ui/uitility/assets_path.dart';
import 'package:al_hadith/ui/uitility/custom_size_extention.dart';
import 'package:al_hadith/ui/uitility/style.dart';
import 'package:al_hadith/ui/widgets/carousel_slider_widget.dart';
import 'package:al_hadith/ui/widgets/text_component.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<BookController>().fetchBookListData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SvgPicture.asset(AssetsPath.menuSVG),
        centerTitle: true,
        title: TextComponent(
          text: 'Al Hadith',
          color: AppColors.whiteColor,
          fontSize: Constants.appbarTitleSize,
          fontWeight: Constants.titleFontWeight,
          height: 0.04,
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 16.rh),
            child: SvgPicture.asset(AssetsPath.searchSVG),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400.rh,
            child: Stack(
              children: [

                Container(
                  height: 350.rh,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.rh),
                      bottomRight: Radius.circular(30.rh),
                    ),
                    color: AppColors.primaryColor,
                  ),
                  child: CarouselSliderWidget(),
                ),
                Positioned(
                  bottom: 5,
                  child: Container(
                      height: 100.rh,
                      width: 415.rh,

                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.rh),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.rh),
                          ),
                          elevation: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(AssetsPath.clockSVG),
                              SvgPicture.asset(AssetsPath.goSVG),
                              SvgPicture.asset(AssetsPath.appSVG),
                              SvgPicture.asset(AssetsPath.heartSVG),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all( 16.rh),
            child: TextComponent(text: "All Hadith Book",
                color: AppColors.bookTitleTextColor,
                fontSize: Constants.k15FontSize,
                fontWeight: Constants.titleFontWeight,
                height: 0.10),
          ),
          GetBuilder<BookController>(
            builder: (_bookController) {
              if(_bookController.isLoading){
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: SizedBox(
                  height: 250.rh,
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _bookController.bookList.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        onTap: (){
                          Get.to(()=>ChapterScreen(bookId: _bookController.bookList[index].id ?? 0,));
                        },
                        tileColor: AppColors.whiteColor,
                        leading: Container(
                          width: 46.rh,
                          height: 46.rh,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16.rh)
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 46.rh,
                                  height: 46.rh,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF19A382),
                                    shape: StarBorder.polygon(
                                      sides: 6,

                                    ),
                                  ),
                                ),
                              ),
                               Center(
                                 child: Padding(
                                   padding:  EdgeInsets.only(top: 10.rh),
                                   child: TextComponent(
                                        text: _bookController.bookList[index].abvrCode ?? '',
                                        color: AppColors.whiteColor,
                                        fontSize: Constants.titleFontSize,
                                        fontWeight: Constants.mediumFontWeight,
                                        height: 0.06,
                                      ),
                                 ),
                               ),
                            ],
                          ),
                        ),
                        title: Row(
                          children: [
                            TextComponent(
                                text: _bookController.bookList[index].title ?? '',
                                color: AppColors.TileTitleTextColor,
                                fontSize: Constants.k14FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            TextComponent(
                                text: _bookController.bookList[index].numberOfHadis.toString(),
                                color: AppColors.TileTitleTextColor,
                                fontSize: Constants.k14FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            TextComponent(
                                text: _bookController.bookList[index].bookName ?? '',
                                color: AppColors.TileSubTitleTextColor,
                                fontSize: Constants.k12FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                                maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            TextComponent(
                                text: _bookController.bookList[index].bookName ?? '',
                                color: AppColors.TileSubTitleTextColor,
                                fontSize: Constants.k12FontSize,
                                fontWeight: Constants.mediumFontWeight,
                                height: 0.10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context,index)=>SizedBox(height: 8.rh,), ),
                ),
              );
            }
          ),
        ],
      )
    );
  }
}



