import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:tripusfrontend/pages/home/post_feeds_page.dart';
import 'package:tripusfrontend/pages/home/widgets/feeds_widget.dart';

import '../../helper/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    Widget category() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // OPEN TRIP
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 7, horizontal: 14), // Set the desired padding values
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(textButtonSecondaryColor),
                ),
                child: Text("Open Trip", style: buttonPrimaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semibold
                ),)
            ),
            // SHARE COST
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 7, horizontal: 14), // Set the desired padding values
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(textButtonSecondaryColor),
                ),
                child: Text("Share Cost", style: buttonPrimaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semibold
                ),)
            ),
            // TRANSACTION
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 7, horizontal: 14), // Set the desired padding values
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8), // Set the desired border radius
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(textButtonSecondaryColor),
                ),
                child: Text("Transaction", style: buttonPrimaryTextStyle.copyWith(
                    fontSize: 14, fontWeight: semibold
                ),)
            ),
          ],
        ),
      );
    }


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: SvgPicture.asset('assets/logo.svg'),
            actions: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostFeedsPage())),
                icon: Image.asset('assets/icon_plus.png'),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icon_profile_default.png', width: 30, height: 30,),
              ),
            ],
            toolbarHeight: kToolbarHeight + 15,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              category(),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView(
                  children: [
                    FeedsWidget(),
                    FeedsWidget(),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
