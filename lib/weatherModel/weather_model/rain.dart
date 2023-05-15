class Rain {
  double? threeour;

  Rain({this.threeour});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        threeour: (json['threeour'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'threeour': threeour,
      };
}
