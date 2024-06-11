import 'package:auto_size_text/auto_size_text.dart';
import 'package:edirne_gezgini_ui/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:edirne_gezgini_ui/bloc/favorites_bloc/favorites_event.dart';
import 'package:edirne_gezgini_ui/bloc/favorites_bloc/favorites_state.dart';
import 'package:edirne_gezgini_ui/service/favorite_service.dart';
import 'package:edirne_gezgini_ui/widget/place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edirne_gezgini_ui/constants.dart' as constants;
import 'package:edirne_gezgini_ui/model/dto/favorite_dto.dart';
import 'package:edirne_gezgini_ui/model/enum/base_place_category.dart';

import '../bloc/favorites_bloc/favorites_status.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;

    return BlocProvider(
      create: (context) => FavoritesBloc(
        favoriteService: context.read<FavoriteService>(),
      )..add(GetFavoriteList()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: const Text(
            "favorilerim",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.favoritesStatus is GetFavoriteListPending) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.favoritesStatus is GetFavoriteListSuccess) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: AutoSizeText(
                      "Favori mekanlarım",
                      style: TextStyle(
                          fontSize: 24,
                          color: constants.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // List places
                  SizedBox(
                    width: width * 100,
                    height: height * 65,
                    child: favoritePlacesListView(state.favoriteList[BasePlaceCategory.place] ?? [], width * 0.5, height * 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: AutoSizeText(
                      "Favori konaklama yerlerim",
                      style: TextStyle(
                          fontSize: 24,
                          color: constants.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // List accommodations
                  SizedBox(
                    width: width * 100,
                    height: height * 65,
                    child: favoriteAccommodationsListView(state.favoriteList[BasePlaceCategory.accommodation] ?? [], width * 0.5, height * 1),
                  ),
                ],
              );
            } else if (state.favoritesStatus is GetFavoriteListFailed) {
              final failureStatus = state.favoritesStatus as GetFavoriteListFailed;
              return Center(child: Text('Error: ${failureStatus.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget favoritePlacesListView(List<FavoriteDto> favoritePlaces, double width, double height) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: favoritePlaces.length,
      itemBuilder: (BuildContext context, int index) {
        var currentPlace = favoritePlaces[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlaceCard(
            title: currentPlace.favoritePlaceId,
            image: "", // buraya tekrar bakılacaaakkkk!!!
            width: width,
            height: height,
            isVisited: false,
          ),
        );
      },
    );
  }

  Widget favoriteAccommodationsListView(List<FavoriteDto> favoriteAccommodations, double width, double height) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: favoriteAccommodations.length,
      itemBuilder: (BuildContext context, int index) {
        var currentAccommodation = favoriteAccommodations[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlaceCard(
            title: currentAccommodation.favoritePlaceId,
            image: "", // buraya tekrar bakılacaaaakkkk!!!!
            width: width,
            height: height,
            isVisited: false,
          ),
        );
      },
    );
  }
}

