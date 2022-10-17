class TotalSimpanan {
  int? status;
  String? message;
  int? data;

  TotalSimpanan({this.status, this.message, this.data});

  TotalSimpanan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
