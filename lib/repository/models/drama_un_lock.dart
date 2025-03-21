class DramaUnLock {
  String? ep;

  DramaUnLock({this.ep});

  factory DramaUnLock.fromJson(Map<String, dynamic> json) => DramaUnLock(
        ep: json['ep'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ep': ep,
      };
}
