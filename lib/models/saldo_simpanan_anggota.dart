class SaldoSimpananAnggota {
  int? status;
  String? message;
  Data? data;

  SaldoSimpananAnggota({this.status, this.message, this.data});

  SaldoSimpananAnggota.fromJson(Map<String, dynamic> json) {
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
  int? simpok;
  int? simwa;
  int? simsuk;

  Data({this.simpok, this.simwa, this.simsuk});

  Data.fromJson(Map<String, dynamic> json) {
    simpok = json['simpok'];
    simwa = json['simwa'];
    simsuk = json['simsuk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['simpok'] = this.simpok;
    data['simwa'] = this.simwa;
    data['simsuk'] = this.simsuk;
    return data;
  }
}
