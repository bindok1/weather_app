class Sys {
  String? pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };
}
