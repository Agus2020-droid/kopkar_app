class ListBanner {
  int? status;
  String? message;
  List<Data>? data;

  ListBanner({this.status, this.message, this.data});

  ListBanner.fromJson(Map<String, dynamic> json) {
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
  int? idPengumuman;
  String? judul;
  String? isi;
  String? notifikasi;
  String? tglPengumuman;
  String? lampiran;
  String? author;

  Data(
      {this.idPengumuman,
      this.judul,
      this.isi,
      this.notifikasi,
      this.tglPengumuman,
      this.lampiran,
      this.author});

  Data.fromJson(Map<String, dynamic> json) {
    idPengumuman = json['id_pengumuman'];
    judul = json['judul'];
    isi = json['isi'];
    notifikasi = json['notifikasi'];
    tglPengumuman = json['tgl_pengumuman'];
    lampiran = json['lampiran'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengumuman'] = this.idPengumuman;
    data['judul'] = this.judul;
    data['isi'] = this.isi;
    data['notifikasi'] = this.notifikasi;
    data['tgl_pengumuman'] = this.tglPengumuman;
    data['lampiran'] = this.lampiran;
    data['author'] = this.author;
    return data;
  }
}
