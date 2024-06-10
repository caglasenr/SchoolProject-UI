import 'package:auto_size_text/auto_size_text.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_bloc.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_event.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_state.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_status.dart';
import 'package:edirne_gezgini_ui/model/dto/visitation_dto.dart';
import 'package:edirne_gezgini_ui/model/enum/base_place_category.dart';
import 'package:edirne_gezgini_ui/widget/place_card.dart';
import 'package:flutter/material.dart';
import 'package:edirne_gezgini_ui/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
class VisitationsPage extends StatefulWidget {
  const VisitationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _VisitationsPageState();
}

class _VisitationsPageState extends State<VisitationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<VisitationsBloc>().add(GetVisitationList());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: const Text(
          "Gittiğim Yerler",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<VisitationsBloc, VisitationsState>(
        builder: (context, state) {
          if (state.visitationsStatus is GetVisitationListPending) {
            return Center(child: CircularProgressIndicator());
          } else if (state.visitationsStatus is GetVisitationListSuccess) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                buildSectionTitle("Gittiğim Mekanlar"),
                buildVisitationListView(state.visitationList[BasePlaceCategory.place], context, width, height),
                buildSectionTitle("Gittiğim Konaklama Yerleri"),
                buildVisitationListView(state.visitationList[BasePlaceCategory.accommodation], context, width, height),
                buildSectionTitle("Gittiğim Restoranlar"),
                buildVisitationListView(state.visitationList[BasePlaceCategory.restaurant], context, width, height),
              ],
            );
          } else if (state.visitationsStatus is GetVisitationListFailed) {
            return Center(child: Text('Bir hata oluştu: ${(state.visitationsStatus as GetVisitationListFailed).message}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AutoSizeText(
        title,
        style: const TextStyle(
          fontSize: 24,
          color: constants.primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildVisitationListView(List<VisitationDto>? visitations, BuildContext context, double width, double height) {
    if (visitations == null || visitations.isEmpty) {
      return const Center(child: Text("Ziyaret edilen yer yok."));
    }

    return SizedBox(
      height: height * 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: visitations.length,
        itemBuilder: (context, index) {
          var visitation = visitations[index];

          var visitedPlaceId = visitation.visitedPlaceId;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: visitedPlaceId != null
                ? PlaceCard(
              title: visitedPlaceId.title, //TITLE EKLEMEYE BAK
              image: visitedPlaceId.image, //IMAGE EKLEMEYE BAK
              width: width * 50,
              height: height * 30,
              isVisited: true,
            )
                : Container(),
          );
        },
      ),
    );
  }
}
