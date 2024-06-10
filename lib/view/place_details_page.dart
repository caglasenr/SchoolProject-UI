import 'package:auto_size_text/auto_size_text.dart';
import 'package:edirne_gezgini_ui/model/base_place.dart';
import 'package:edirne_gezgini_ui/model/enum/base_place_category.dart';
import 'package:flutter/material.dart';
import '../model/accommodation.dart';
import '../model/place.dart';


class PlaceDetailsPage extends StatefulWidget {
  final BasePlace place;

  final BasePlaceCategory category;

  const PlaceDetailsPage({super.key, required this.place, required this.category});

  @override
  State<StatefulWidget> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    late String title;
    late String? info;
    late String location;
    late String image;

    if(widget.category == BasePlaceCategory.place){
      Place currentPlace = widget.place as Place;
      title = currentPlace.title;
      info = currentPlace.info;
      location = currentPlace.location;
      image = currentPlace.image;
    } else{
      Accommodation currentAccommodation = widget.place as Accommodation;
      title = currentAccommodation.title;
      info = currentAccommodation.info;
      location = currentAccommodation.location;
      image = currentAccommodation.image;
    }

    double width = MediaQuery
        .of(context)
        .size
        .width / 100;
    double height = MediaQuery
        .of(context)
        .size
        .height / 100;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: height * 30,
                width: width * 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20,),

            AutoSizeText(
              info!,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
              maxLines: 10,
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child: AutoSizeText(
                "Konum",
                style: TextStyle(fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),

            AutoSizeText(
              location,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
