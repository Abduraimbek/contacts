import 'dart:convert';

class Contact {
  String firstName;
  String? lastName;
  String phone1;
  String? phone2;
  String color;

  Contact({
    required this.firstName,
    required this.phone1,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phone1'] = phone1;
    map['phone2'] = phone2;
    map['color'] = color;
    return map;
  }

  String toJSONString() {
    final Map<String, dynamic> map = toMap();
    final String jsonString = jsonEncode(map);
    return jsonString;
  }
}
