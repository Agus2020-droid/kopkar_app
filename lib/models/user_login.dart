class Login {
  int? status;
  String? message;
  Data? data;

  Login({this.status, this.message, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Dataku? dataku;

  Data({this.dataku});

  Data.fromJson(Map<String, dynamic> json) {
    dataku =
        json['dataku'] != null ? new Dataku.fromJson(json['dataku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataku != null) {
      data['dataku'] = this.dataku!.toJson();
    }
    return data;
  }
}

class Dataku {
  User? user;
  Token? token;

  Dataku({this.user, this.token});

  Dataku.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? nikKtp;
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
  String? nama;
  String? tempatLahir;
  String? tglLahir;
  String? tglMasuk;
  String? jabatan;
  String? kepengurusan;
  String? alamat;
  String? status;
  String? fotoPegawai;

  User(
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
      this.updatedAt,
      this.nama,
      this.tempatLahir,
      this.tglLahir,
      this.tglMasuk,
      this.jabatan,
      this.kepengurusan,
      this.alamat,
      this.status,
      this.fotoPegawai});

  User.fromJson(Map<String, dynamic> json) {
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
    nama = json['nama'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    tglMasuk = json['tgl_masuk'];
    jabatan = json['jabatan'];
    kepengurusan = json['kepengurusan'];
    alamat = json['alamat'];
    status = json['status'];
    fotoPegawai = json['foto_pegawai'];
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
    data['nama'] = this.nama;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    data['tgl_masuk'] = this.tglMasuk;
    data['jabatan'] = this.jabatan;
    data['kepengurusan'] = this.kepengurusan;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    data['foto_pegawai'] = this.fotoPegawai;
    return data;
  }
}

class Token {
  String? token;

  Token({this.token});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
