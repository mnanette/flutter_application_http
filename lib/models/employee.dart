class Employee {
  String? username;
  String? password;
  Name? name;
  String? ssn;
  String? dob;
  String? hiredOn;
  String? terminatedOn;
  String? email;
  List<Phones>? phones;
  Address? address;
  List<String>? roles;
  String? department;
  String? gender;
  String? portrait;
  String? thumbnail;

  Employee(
      {this.username,
      this.password,
      this.name,
      this.ssn,
      this.dob,
      this.hiredOn,
      this.terminatedOn,
      this.email,
      this.phones,
      this.address,
      this.roles,
      this.department,
      this.gender,
      this.portrait,
      this.thumbnail});

  Employee.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    ssn = json['ssn'];
    dob = json['dob'];
    hiredOn = json['hiredOn'];
    terminatedOn = json['terminatedOn'];
    email = json['email'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) {
        phones!.add(Phones.fromJson(v));
      });
    }
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    roles = json['roles'].cast<String>();
    department = json['department'];
    gender = json['gender'];
    portrait = json['portrait'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['ssn'] = ssn;
    data['dob'] = dob;
    data['hiredOn'] = hiredOn;
    data['terminatedOn'] = terminatedOn;
    data['email'] = email;
    if (phones != null) {
      data['phones'] = phones!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['roles'] = roles;
    data['department'] = department;
    data['gender'] = gender;
    data['portrait'] = portrait;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class Name {
  String? first;
  String? last;

  Name({this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first'] = first;
    data['last'] = last;
    return data;
  }
}

class Phones {
  String? type;
  String? number;

  Phones({this.type, this.number});

  Phones.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['number'] = number;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? zip;

  Address({this.street, this.city, this.state, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    return data;
  }
}
