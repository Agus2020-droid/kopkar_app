class DetailShu {
  int? status;
  String? message;
  List<Data>? data;

  DetailShu({this.status, this.message, this.data});

  DetailShu.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? idShu;
  String? nikKtp;
  String? tglShu;
  String? namaBank;
  String? noRek;
  String? peranBelanjaWanamart;
  String? peranSimpananWanamart;
  String? lainLain;
  String? peranKredit;
  String? peranSimpanan;
  String? pengurus;
  String? jumlahShu;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idShu,
      this.nikKtp,
      this.tglShu,
      this.namaBank,
      this.noRek,
      this.peranBelanjaWanamart,
      this.peranSimpananWanamart,
      this.lainLain,
      this.peranKredit,
      this.peranSimpanan,
      this.pengurus,
      this.jumlahShu,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idShu = json['id_shu'];
    nikKtp = json['nik_ktp'];
    tglShu = json['tgl_shu'];
    namaBank = json['nama_bank'];
    noRek = json['no_rek'];
    peranBelanjaWanamart = json['peran_belanja_wanamart'];
    peranSimpananWanamart = json['peran_simpanan_wanamart'];
    lainLain = json['lain_lain'];
    peranKredit = json['peran_kredit'];
    peranSimpanan = json['peran_simpanan'];
    pengurus = json['pengurus'];
    jumlahShu = json['jumlah_shu'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_shu'] = this.idShu;
    data['nik_ktp'] = this.nikKtp;
    data['tgl_shu'] = this.tglShu;
    data['nama_bank'] = this.namaBank;
    data['no_rek'] = this.noRek;
    data['peran_belanja_wanamart'] = this.peranBelanjaWanamart;
    data['peran_simpanan_wanamart'] = this.peranSimpananWanamart;
    data['lain_lain'] = this.lainLain;
    data['peran_kredit'] = this.peranKredit;
    data['peran_simpanan'] = this.peranSimpanan;
    data['pengurus'] = this.pengurus;
    data['jumlah_shu'] = this.jumlahShu;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
