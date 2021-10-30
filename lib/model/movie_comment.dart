class MovieComment {
  int? id;
  String userName;
  String review;
  double rating;

  MovieComment(
      {this.id,
      required this.userName,
      required this.review,
      required this.rating});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      "name": userName,
      "review": review,
      "rate": rating,
    };
    return map;
  }

  factory MovieComment.fromMap(Map<String, dynamic> map) {
    return MovieComment(
        id: map["id"],
        userName: map["name"],
        review: map["review"],
        rating: map["rate"]);
  }
}
