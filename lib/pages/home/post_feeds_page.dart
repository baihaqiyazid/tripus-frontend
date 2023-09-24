import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:tripusfrontend/helper/theme.dart';
import 'package:tripusfrontend/pages/home/widgets/place_search.dart';

class PostFeedsPage extends StatefulWidget {
  const PostFeedsPage({super.key});

  @override
  State<PostFeedsPage> createState() => _PostFeedsPageState();
}

class _PostFeedsPageState extends State<PostFeedsPage> {
  List<MapBoxPlace> places = [];
  TextEditingController locationController = TextEditingController(text: '');
  final ValueNotifier<String> searchText = ValueNotifier('');

  var placesSearch = PlacesSearch(
    apiKey:
        'pk.eyJ1IjoiYmFpaGFxeSIsImEiOiJjbGpzODBuMDMwYmo0M2p2c2JneXE2MGlrIn0.xeSSV9yBJ-nTKgbh2JrOhQ',
    limit: 10,
    country: 'ID',
  );


  void clearPlaces() {
    setState(() {
      places.clear(); // Clear the places list
    });
  }

  Future<List<MapBoxPlace>> getPlaces(String name) async {
    try {
      final result = await placesSearch.getPlaces(name);
      print("result: ${result}");

      setState(() {
        places = result!;
      });
      return places;
    } catch (e) {
      // Handle error jika terjadi exception
      print("Error: $e");
      setState(() {
        places = [];
      });
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget uploadImage() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 27, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerPostColor,
        ),
        child: Column(
          children: [
            IconButton(
                onPressed: () {},
                iconSize: 54,
                icon: Image.asset(
                  'assets/icon_add_image.png',
                )),
            Row(
              children: [
                Text(
                  "Tap to choose",
                  style: primaryTextStylePlusJakartaSans.copyWith(
                      color: Color(0xffA1A1A1), fontSize: 10),
                ),
                Text(
                  "Image",
                  style: primaryTextStylePlusJakartaSans.copyWith(
                      color: textButtonSecondaryColor, fontSize: 10),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget description() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 12, fontWeight: semibold),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            width: 200,
            height: 100,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerPostColor,
            ),
            child: TextFormField(
              textAlign: TextAlign.justify,
              style: primaryTextStylePlusJakartaSans.copyWith(fontSize: 12),
              maxLines: 6,
              decoration: InputDecoration.collapsed(
                hintText: "Type Here...",
                hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                    color: Color(0xffA1A1A1), fontSize: 12),
              ),
            ),
          ),
        ],
      );
    }

    Widget location() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 12,
                fontWeight: semibold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerPostColor,
              ),
              child: ValueListenableBuilder<String>(
                valueListenable: searchText,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: locationController,
                    onChanged: (newValue) {
                      searchText.value = newValue;
                      getPlaces(newValue);
                    },
                    textAlign: TextAlign.justify,
                    style: primaryTextStylePlusJakartaSans.copyWith(fontSize: 12),
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: "Type Here...",
                      hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                        color: Color(0xffA1A1A1),
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            places.length != 0?
            Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerPostColor,
              ),
              child: ListView(
                children: [
                  ...places.map((place) => LocationItem(
                      place: place,
                      locationController: locationController,
                      onClearPlaces: clearPlaces,)).toList(),
                ],
              ),
            ) : Container(),
          ],
        ),
      );
    }


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 15), // Ukuran tinggi AppBar dengan margin vertical
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20), // Margin horizontal
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Post Photo"),
            titleTextStyle: TextStyle(
                fontWeight: semibold, color: textPrimaryColor, fontSize: 16),
            centerTitle: true,
            iconTheme: IconThemeData(color: textPrimaryColor),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {

                },
                child: Text(
                  "Done",
                  style: buttonSecondaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            toolbarHeight: kToolbarHeight + 15,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  uploadImage(),
                  const SizedBox(
                    width: 18,
                  ),
                  description()
                ],
              ),
              location()
            ],
          ),
        ),
      ),
    );
  }
}
