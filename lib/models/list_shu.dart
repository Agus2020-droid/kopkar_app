class ListShu {
  int? status;
  String? message;
  List<Data>? data;

  ListShu({this.status, this.message, this.data});

  ListShu.fromJson(Map<String, dynamic> json) {
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
  String? tglShu;
  String? jumlahShu;
  String? namaBank;
  String? noRek;

  Data({this.idShu, this.tglShu, this.jumlahShu, this.namaBank, this.noRek});

  Data.fromJson(Map<String, dynamic> json) {
    idShu = json['id_shu'];
    tglShu = json['tgl_shu'];
    jumlahShu = json['jumlah_shu'];
    namaBank = json['nama_bank'];
    noRek = json['no_rek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_shu'] = this.idShu;
    data['tgl_shu'] = this.tglShu;
    data['jumlah_shu'] = this.jumlahShu;
    data['nama_bank'] = this.namaBank;
    data['no_rek'] = this.noRek;
    return data;
  }
}
