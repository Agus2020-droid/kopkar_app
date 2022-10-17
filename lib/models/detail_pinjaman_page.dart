class ShowPinjaman {
  int? status;
  String? message;
  List<Data>? data;

  ShowPinjaman({this.status, this.message, this.data});

  ShowPinjaman.fromJson(Map<String, dynamic> json) {
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
  String? posisi;
  String? ttdKetua;
  String? ttdHrbp;
  String? statusPengajuan;
  String? plafon;
  int? noPinjaman;
  String? jenisPinjaman;
  String? tglPengajuan;
  String? namaBarang;
  String? merk;
  String? spesifikasi;
  String? unit;
  String? tenor;
  String? totalKredit;
  String? periodeAngsuran;
  String? angsuran;
  String? totalAngsuran;
  String? sisaAngsuran;
  String? countAngsuran;

  Data(
      {this.posisi,
      this.ttdKetua,
      this.ttdHrbp,
      this.statusPengajuan,
      this.plafon,
      this.noPinjaman,
      this.jenisPinjaman,
      this.tglPengajuan,
      this.namaBarang,
      this.merk,
      this.spesifikasi,
      this.unit,
      this.tenor,
      this.totalKredit,
      this.periodeAngsuran,
      this.angsuran,
      this.totalAngsuran,
      this.sisaAngsuran,
      this.countAngsuran});

  Data.fromJson(Map<String, dynamic> json) {
    posisi = json['posisi'];
    ttdKetua = json['ttd_ketua'];
    ttdHrbp = json['ttd_hrbp'];
    statusPengajuan = json['status_pengajuan'];
    plafon = json['plafon'];
    noPinjaman = json['no_pinjaman'];
    jenisPinjaman = json['jenis_pinjaman'];
    tglPengajuan = json['tgl_pengajuan'];
    namaBarang = json['nama_barang'];
    merk = json['merk'];
    spesifikasi = json['spesifikasi'];
    unit = json['unit'];
    tenor = json['tenor'];
    totalKredit = json['total_kredit'];
    periodeAngsuran = json['periode_angsuran'];
    angsuran = json['angsuran'];
    totalAngsuran = json['total_angsuran'];
    sisaAngsuran = json['sisaAngsuran'];
    countAngsuran = json['count_angsuran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['posisi'] = this.posisi;
    data['ttd_ketua'] = this.ttdKetua;
    data['ttd_hrbp'] = this.ttdHrbp;
    data['status_pengajuan'] = this.statusPengajuan;
    data['plafon'] = this.plafon;
    data['no_pinjaman'] = this.noPinjaman;
    data['jenis_pinjaman'] = this.jenisPinjaman;
    data['tgl_pengajuan'] = this.tglPengajuan;
    data['nama_barang'] = this.namaBarang;
    data['merk'] = this.merk;
    data['spesifikasi'] = this.spesifikasi;
    data['unit'] = this.unit;
    data['tenor'] = this.tenor;
    data['total_kredit'] = this.totalKredit;
    data['periode_angsuran'] = this.periodeAngsuran;
    data['angsuran'] = this.angsuran;
    data['total_angsuran'] = this.totalAngsuran;
    data['sisaAngsuran'] = this.sisaAngsuran;
    data['count_angsuran'] = this.countAngsuran;
    return data;
  }
}
