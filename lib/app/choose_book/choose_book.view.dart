import 'package:SMLingg/app/choose_book/book.provider.dart';
import 'package:SMLingg/app/components/custom.class_appbar.component.dart';
import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/lesson/lesson.provider.dart';
import 'package:SMLingg/app/unit/unit.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/config/resouces.dart';
import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/services/book_list.service.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChooseBook extends StatefulWidget {
  @override
  _ChooseBookState createState() => _ChooseBookState();
}

class _ChooseBookState extends State<ChooseBook> {
  CarouselSlider carouselSlider;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackGround,
      appBar: MyCustomAppbar(
        chooseBook: true,
        title: 'BOOK',
        showAvatar: false,
        height: SizeConfig.screenHeight * 0.11,
        width: SizeConfig.screenWidth,
      ),
      body: Consumer<BookModel>(
        builder: (_, bookModel, __) {
          return Column(children: [
            Container(
                child: Container(
              height: SizeConfig.screenHeight * 0.35,
              width: SizeConfig.screenWidth,
              child: CarouselSlider.builder(
                carouselController: carouselController,
                itemBuilder: (context, index) => listClassImage(index, bookModel.getGrade()),
                options: CarouselOptions(
                    viewportFraction: 1.2,
                    initialPage: bookModel.getGrade(),
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 2,
                    onPageChanged: (index, reason) {
                      bookModel.setGrade(index, context);
                      Application.sharePreference.putInt("setGrade", index);
                    }),
                itemCount: ClassImage.classImage.length,
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ClassImage.classImage.map((url) {
                int index = ClassImage.classImage.indexOf(url);
                return AnimatedContainer(
                    width: (bookModel.getGrade() == index)
                        ? SizeConfig.safeBlockHorizontal * 7
                        : SizeConfig.safeBlockHorizontal * 1.5,
                    height: (bookModel.getGrade() == index)
                        ? SizeConfig.safeBlockHorizontal * 2.25
                        : SizeConfig.safeBlockHorizontal * 1.5,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: bookModel.getGrade() == index
                        ? BoxDecoration(color: Color(0xFF2485F4), borderRadius: BorderRadius.circular(15))
                        : BoxDecoration(color: Color(0xFFADD6F3), borderRadius: BorderRadius.circular(15)),
                    duration: Duration(milliseconds: 500));
              }).toList(),
            ),
            SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
            FutureBuilder(
                future: BookListService().loadBookList(bookModel.getGrade()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? BooksList(books: snapshot.data)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
          ]);
        },
      ),
    );
  }

  Widget listClassImage(int index, int _current) {
    return Container(
        decoration: BoxDecoration(
            color: (index == _current) ? Color(0xFFFFC639) : Color(0xFFDEF0FD),
            borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 3)),
        width: SizeConfig.safeBlockHorizontal * 80,
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 8),
        child: Image.asset(ClassImage.classImage[index]));
  }
}

class BooksList extends StatelessWidget {
  final List<Book> books;

  const BooksList({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int indexBook = 0;
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            (books.length / 2).round(),
            (row) => (indexBook + 2 <= books.length
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BookItem(item: books[indexBook++]),
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 10),
                      BookItem(item: books[indexBook++])
                    ],
                  )
                : BookItem(item: books[indexBook++])))
      ],
    ));
  }
}

class BookItem extends StatelessWidget {
  final Book item;

  const BookItem({Key key, this.item}) : super(key: key);

  String checkDownLine() {
    String newString = '';
    List<String> nameList = item.name.split(' ');
    int index = nameList.indexWhere((element) => element == item.grade.toString());
    for (int i = 0; i < nameList.length; i++) {
      newString += '${nameList[i]} ';
      if (i == index) {
        newString += '\n';
      }
    }
    return newString;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Consumer<LessonModel>(builder: (_, lessonModel, __) {
      return Column(
        children: [
          Container(
              child: Column(
            children: <Widget>[
              CustomButton(
                elevation: SizeConfig.safeBlockVertical * 0.7,
                radius: SizeConfig.safeBlockHorizontal * 3,
                backgroundColor: Color(0xFFE5F3FD),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 3),
                    (item.cover != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2),
                            child: Image.network(
                              item.cover,
                              width: SizeConfig.safeBlockHorizontal * 30,
                              height: SizeConfig.safeBlockHorizontal * 40,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            color: Colors.transparent,
                            width: SizeConfig.safeBlockHorizontal * 30,
                            height: SizeConfig.safeBlockHorizontal * 0.22),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                    Container(
                      height: SizeConfig.safeBlockHorizontal * 11,
                      width: SizeConfig.screenWidth * 0.42,
                      child: FittedBox(
                        child: Text(checkDownLine(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.w600, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
                height: SizeConfig.safeBlockHorizontal * 60,
                width: SizeConfig.blockSizeHorizontal * 43,
                shadowColor: Color(0xFFADD6F3),
                onPressed: () {
                  if (item.grade <= 5) {
                    Get.to(UnitScreen(grade: item.grade, bookID: item.id));
                  } else if (Provider.of<BookModel>(context, listen: false).play6To12) {
                    Get.to(UnitScreen(grade: item.grade, bookID: item.id));
                  }
                },
              ),
            ],
          )),
          // Container(
          //   width: SizeConfig.blockSizeHorizontal * 43,
          //   child: Row(
          //     children: [
          //       Container(
          //           height: SizeConfig.safeBlockHorizontal * 2.5,
          //           width: SizeConfig.safeBlockHorizontal * 30,
          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          //           child: Stack(alignment: Alignment.center, children: [
          //             Container(
          //               width: SizeConfig.blockSizeHorizontal * 30,
          //               color: Color(0xFFE5F3FD),
          //             ),
          //             AnimatedPositioned(
          //               left: -SizeConfig.blockSizeHorizontal * 30 +
          //                   (item.doneQuestions / item.totalQuestions) * SizeConfig.blockSizeHorizontal * 30,
          //               duration: Duration(milliseconds: 500),
          //               child: Container(
          //                 height: SizeConfig.safeBlockHorizontal * 2.5,
          //                 width: SizeConfig.safeBlockHorizontal * 30,
          //                 decoration: BoxDecoration(
          //                     color: Color(0xFFADD6F3),
          //                     border: Border.all(color: Color(0xFFE5F3FD)),
          //                     borderRadius: BorderRadius.circular(90)),
          //               ),
          //             ),
          //           ])),
          //       Expanded(child: SizedBox()),
          //       Text(
          //           item.totalQuestions != 0
          //               ? ("${double.parse((item.doneQuestions / item.totalQuestions * 100).toStringAsFixed(1))}%" ==
          //                       "100.0%"
          //                   ? "100%"
          //                   : "${double.parse((item.doneQuestions / item.totalQuestions * 100).toStringAsFixed(1))}%")
          //               : "0%",
          //           style: TextStyle(
          //             color: Color(0xFF84BDE5),
          //             fontFamily: "Quicksand",
          //             fontWeight: FontWeight.w600,
          //             fontSize: SizeConfig.safeBlockHorizontal * 4,
          //           )),
          //     ],
          //   ),
          // ),
          SizedBox(height: SizeConfig.safeBlockHorizontal * 5)
        ],
      );
    });
  }
}
