import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/theme.dart';
import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;
  MainPage({this.currentIndex = 0, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget navigation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 30, right: 27, left: 27),
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.0,
                sigmaY: 4.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 0, left: 0, top: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //begin color
                      Colors.white.withOpacity(0.9),
                      //end color
                      Colors.white.withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      offset: Offset(0, 2), // Shadow offset
                      blurRadius: 4, // Shadow blur radius
                      spreadRadius: 0, // Shadow spread radius
                    ),
                  ]),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          SvgPicture.asset('assets/icon_home.svg',
                              color: widget.currentIndex == 0
                                  ? textButtonSecondaryColor
                                  : bottomNavigationColor),
                          SizedBox(
                            height: 2,
                          ),
                          widget.currentIndex == 0
                              ? ClipOval(
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    color: textButtonSecondaryColor,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          SvgPicture.asset('assets/icon_love.svg',
                              color: widget.currentIndex == 1
                                  ? textButtonSecondaryColor
                                  : bottomNavigationColor),
                          SizedBox(
                            height: 2,
                          ),
                          widget.currentIndex == 1
                              ? ClipOval(
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    color: textButtonSecondaryColor,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          SvgPicture.asset('assets/icon_notification.svg',
                              color: widget.currentIndex == 2
                                  ? textButtonSecondaryColor
                                  : bottomNavigationColor),
                          SizedBox(
                            height: 2,
                          ),
                          widget.currentIndex == 2
                              ? ClipOval(
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    color: textButtonSecondaryColor,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          SvgPicture.asset('assets/icon_chat.svg',
                              color: widget.currentIndex == 3
                                  ? textButtonSecondaryColor
                                  : bottomNavigationColor),
                          SizedBox(
                            height: 2,
                          ),
                          widget.currentIndex == 3
                              ? ClipOval(
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    color: textButtonSecondaryColor,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      label: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    switch (widget.currentIndex) {
      case 0:
        return HomePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: navigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body(),
    );
  }
}
