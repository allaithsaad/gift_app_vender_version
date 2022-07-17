import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:storeapp/Controller/categoryController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/Screens/ControlScreen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

final categoryController = Get.find<CategoryController>();

class _CategoryScreenState extends State<CategoryScreen> {
  var selectedCatgory = categoryController.categorylist.length == 0
      ? 0
      : categoryController.categorylist[0].categoryId!;

  @override
  void initState() {
    //  categoryController.getCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryController.moveListFromAllToSelectedProducte(selectedCatgory);
    return Scaffold(
      appBar: AppBar(
        title: Text("Any thing "),
      ),
      body: GetBuilder<CategoryController>(
        builder: (controller) => controller.categorylist.isEmpty
            ? Center(
                child: SpinKitCircle(
                color: Colors.purple,
                size: 50,
              ))
            : controller.selectedcategoryProducte.isEmpty
                ? Center(
                    child: SpinKitCircle(
                    color: Colors.purple,
                    size: 50,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                categoryController.categorylist.length,
                                (index) {
                              var _catcgory = categoryController.categorylist
                                  .elementAt(index);
                              var _selected =
                                  selectedCatgory == _catcgory.categoryId;
                              return Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 10),
                                child: RawChip(
                                  label: Text(categoryController
                                      .categorylist[index].name!),
                                  elevation: 5,
                                  padding: EdgeInsets.only(
                                    left: 8,
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  selectedColor: Theme.of(context).primaryColor,
                                  labelStyle: TextStyle(color: Colors.black),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.05))),
                                  selected: _selected,
                                  avatar: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: categoryController
                                                .categorylist[index].imageUrl ??
                                            '',
                                        placeholder: (context, url) => Center(
                                          child: Opacity(
                                              opacity: 0.70,
                                              child: SvgPicture.asset(
                                                'assets/images/full_logo.svg',
                                                fit: BoxFit.fitHeight,
                                                color: Colors.white,
                                                colorBlendMode:
                                                    BlendMode.softLight,
                                                //   color: Colors.greenAccent,
                                              )),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Opacity(
                                              opacity: 0.70,
                                              child: SvgPicture.asset(
                                                'assets/images/full_logo.svg',
                                                fit: BoxFit.fitHeight,
                                                color: Colors.white,
                                                colorBlendMode:
                                                    BlendMode.softLight,
                                                //   color: Colors.greenAccent,
                                              )),
                                        ),
                                        width: 30,
                                        height: 25,
                                        fit: BoxFit.cover,
                                        // height: 60,
                                      )),
                                  onSelected: (value) {
                                    setState(() {
                                      selectedCatgory = categoryController
                                          .categorylist[index].categoryId!;

                                      categoryController
                                          .moveListFromAllToSelectedProducte(
                                              selectedCatgory);
                                      categoryController.update();
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GetBuilder<CategoryController>(
                            builder: (controller) => categoryController
                                        .categorylistProducte.length ==
                                    0
                                ? Text('Loading >>>')
                                : new GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: categoryController
                                        .selectedcategoryProducte.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, i) => Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: GestureDetector(
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                        child: SizedBox(
                                                            height: 200,
                                                            width: 200,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  categoryController
                                                                      .selectedcategoryProducte[
                                                                          i]
                                                                      .image![0],
                                                            ))),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Badge(
                                                        toAnimate: true,
                                                        shape:
                                                            BadgeShape.square,
                                                        badgeColor:
                                                            Colors.deepPurple,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5)),
                                                        badgeContent: Text(
                                                            categoryController
                                                                    .selectedcategoryProducte[
                                                                        i]
                                                                    .price
                                                                    .toString() +
                                                                'Ry',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () => {}),
                                        )),
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
