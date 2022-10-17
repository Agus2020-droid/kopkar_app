class UsersList {
  String? status;
  String? message;
  List<Data>? data;

  UsersList({this.status, this.message, this.data});

  UsersList.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? nikKtp;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? nikKaryawan;
  String? telp;
  String? level;
  String? fotoUser;
  String? lastSeen;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.nikKtp,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.nikKaryawan,
      this.telp,
      this.level,
      this.fotoUser,
      this.lastSeen,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nikKtp = json['nik_ktp'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nikKaryawan = json['nik_karyawan'];
    telp = json['telp'];
    level = json['level'];
    fotoUser = json['foto_user'];
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik_ktp'] = this.nikKtp;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['nik_karyawan'] = this.nikKaryawan;
    data['telp'] = this.telp;
    data['level'] = this.level;
    data['foto_user'] = this.fotoUser;
    data['last_seen'] = this.lastSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
