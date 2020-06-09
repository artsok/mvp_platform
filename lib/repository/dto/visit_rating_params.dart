import 'dart:typed_data';

import 'control_card_visit.dart';

class VisitRatingParams extends ControlCardVisit {
  ByteData rating;

  ByteData getRating() {
    return rating;
  }

  void setRating(ByteData rating) {
    this.rating = rating;
  }
}
