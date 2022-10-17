class ListPenarikan {
  int? status;
  String? message;
  List<Data>? data;

  ListPenarikan({this.status, this.message, this.data});

  ListPenarikan.fromJson(Map<String, dynamic> json) {
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
  String? tglPengambilan;
  String? jumlahPengambilan;
  String? ttdKetua;
  String? ttdBendahara;

  Data(
      {this.tglPengambilan,
      this.jumlahPengambilan,
      this.ttdKetua,
      this.ttdBendahara});

  Data.fromJson(Map<String, dynamic> json) {
    tglPengambilan = json['tgl_pengambilan'];
    jumlahPengambilan = json['jumlah_pengambilan'];
    ttdKetua = json['ttd_ketua'];
    ttdBendahara = json['ttd_bendahara'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tgl_pengambilan'] = this.tglPengambilan;
    data['jumlah_pengambilan'] = this.jumlahPengambilan;
    data['ttd_ketua'] = this.ttdKetua;
    data['ttd_bendahara'] = this.ttdBendahara;
    return data;
  }
}
