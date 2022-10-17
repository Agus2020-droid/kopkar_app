class ListPinjaman {
  int? status;
  String? message;
  List<Data>? data;

  ListPinjaman({this.status, this.message, this.data});

  ListPinjaman.fromJson(Map<String, dynamic> json) {
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
  int? noPinjaman;
  String? tglPengajuan;
  String? jenisPinjaman;
  String? totalKredit;
  String? balance;

  Data(
      {this.noPinjaman,
      this.tglPengajuan,
      this.jenisPinjaman,
      this.totalKredit,
      this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    noPinjaman = json['no_pinjaman'];
    tglPengajuan = json['tgl_pengajuan'];
    jenisPinjaman = json['jenis_pinjaman'];
    totalKredit = json['total_kredit'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_pinjaman'] = this.noPinjaman;
    data['tgl_pengajuan'] = this.tglPengajuan;
    data['jenis_pinjaman'] = this.jenisPinjaman;
    data['total_kredit'] = this.totalKredit;
    data['balance'] = this.balance;
    return data;
  }
}
