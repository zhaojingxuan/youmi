import 'day.dart';

class StoreSignIn {
  bool? isSignIn;
  List<Day>? day;

  StoreSignIn({this.isSignIn, this.day});

  factory StoreSignIn.fromJson(Map<String, dynamic> json) => StoreSignIn(
        isSignIn: json['isSignIn'] as bool?,
        day: (json['day'] as List<dynamic>?)
            ?.map((e) => Day.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'isSignIn': isSignIn,
        'day': day?.map((e) => e.toJson()).toList(),
      };
}
