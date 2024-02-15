import 'dart:ui';

class Recognition {

  String name;
  String staff_id;
  Rect location;
  List<double> embeddings;
  double distance;
  String salrytype;
  /// Constructs a Category.
  Recognition(this.name,this.staff_id, this.location,this.embeddings,this.distance, this.salrytype);

}
