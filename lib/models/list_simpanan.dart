class ListSimpanan {
  int? status;
  String? message;
  List<Data>? data;

  ListSimpanan({this.status, this.message, this.data});

  ListSimpanan.fromJson(Map<String, dynamic> json) {
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
  String? jumlahSimpanan;
  String? tglPotongan;

  Data({this.jumlahSimpanan, this.tglPotongan});

  Data.fromJson(Map<String, dynamic> json) {
    jumlahSimpanan = json['jumlah_simpanan'];
    tglPotongan = json['tgl_potongan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_simpanan'] = this.jumlahSimpanan;
    data['tgl_potongan'] = this.tglPotongan;
    return data;
  }
}
