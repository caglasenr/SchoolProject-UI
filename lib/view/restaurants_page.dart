import 'dart:js';
import 'package:edirne_gezgini_ui/bloc/restaurants_bloc/restaurants_bloc.dart';
import 'package:edirne_gezgini_ui/bloc/restaurants_bloc/restaurants_event.dart';
import 'package:edirne_gezgini_ui/bloc/restaurants_bloc/restaurants_state.dart';
import 'package:edirne_gezgini_ui/bloc/restaurants_bloc/restaurants_status.dart';
import 'package:edirne_gezgini_ui/model/enum/base_place_category.dart';
import 'package:edirne_gezgini_ui/model/restaurant.dart';
import 'package:edirne_gezgini_ui/repository/restaurant_repository.dart';
import 'package:edirne_gezgini_ui/service/restaurant_service.dart';
import 'package:edirne_gezgini_ui/view/place_details_page.dart';
import 'package:flutter/material.dart';
import '../widget/place_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantsPage extends StatelessWidget {
  RestaurantRepository restaurantRepository = RestaurantRepository();

  RestaurantsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsBloc(
        restaurantService: RestaurantService(restaurantRepository: restaurantRepository),
      )..add(GetRestaurantList()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Restoranlar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state.restaurantListStatus is GetRestaurantListSuccess) {
              return _buildRestaurantListView(state.restaurantList.cast<Restaurant>());
            } else if (state.restaurantListStatus is GetRestaurantListFailed) {
              return _buildErrorWidget((state.restaurantListStatus as GetRestaurantListFailed).message);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),

      ),
    );
  }

  Widget _buildRestaurantListView(List<Restaurant> restaurants) {
    double width = MediaQuery.of(context as BuildContext).size.width / 100;
    double height = MediaQuery.of(context as BuildContext).size.height / 100;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: restaurants.length,
      itemBuilder: (BuildContext context, int index) {
        var currentRestaurant = restaurants[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(place: currentRestaurant, category: BasePlaceCategory.restaurant),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlaceCard(
              title: currentRestaurant.title,
              image: currentRestaurant.image,
              width: width,
              height: height,
              isVisited: false,
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}


