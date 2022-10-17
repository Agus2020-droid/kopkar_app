class DataAnggota {
  String? status;
  String? message;
  Data? data;

  DataAnggota({this.status, this.message, this.data});

  DataAnggota.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  int? nikKtp;
  String? nama;
  String? nikKaryawan;
  String? tempatLahir;
  String? tglLahir;
  String? tglMasuk;
  String? jabatan;
  String? kepengurusan;
  String? alamat;
  String? status;
  String? fotoPegawai;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.nikKtp,
      this.nama,
      this.nikKaryawan,
      this.tempatLahir,
      this.tglLahir,
      this.tglMasuk,
      this.jabatan,
      this.kepengurusan,
      this.alamat,
      this.status,
      this.fotoPegawai,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nikKtp = json['nik_ktp'];
    nama = json['nama'];
    nikKaryawan = json['nik_karyawan'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    tglMasuk = json['tgl_masuk'];
    jabatan = json['jabatan'];
    kepengurusan = json['kepengurusan'];
    alamat = json['alamat'];
    status = json['status'];
    fotoPegawai = json['foto_pegawai'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik_ktp'] = this.nikKtp;
    data['nama'] = this.nama;
    data['nik_karyawan'] = this.nikKaryawan;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    data['tgl_masuk'] = this.tglMasuk;
    data['jabatan'] = this.jabatan;
    data['kepengurusan'] = this.kepengurusan;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    data['foto_pegawai'] = this.fotoPegawai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
