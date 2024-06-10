import 'package:edirne_gezgini_ui/model/base_place.dart';

import 'enum/base_place_category.dart';

/*class Visitation extends BasePlace{
  final BasePlace visitedPlace;

  final BasePlaceCategory category;

  final String? note;

  Visitation({required this.visitedPlace, required this.category, this.note, required super.id, required super.createdAt, required super.updatedAt});
}*/
class Visitation {
  final String title;
  final String image;

  Visitation({
    required this.title,
    required this.image,
  });

  factory Visitation.fromMap(Map<String, dynamic> map) {
    return Visitation(
      title: map['title'],
      image: map['image'],
    );
  }
}
