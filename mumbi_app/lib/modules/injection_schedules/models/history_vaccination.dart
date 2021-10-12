class HistoryVaccination {
  int lich_su_tiem_id;
  int doi_tuong_id;
  int vacxin_id;
  String ten_vacxin;
  String khang_nguyen;
  int trang_thai;
  String ngay_tiem; //": "10:30 09/06/2021",
  int thu_tu_mui_tiem;
  String co_so_tiem_chung;
  String seo;
  String truoc_24h;
  String lo_vacxin;
  Map<String, dynamic> phan_ung_sau_tiem;
  // {
  //     "ngay_phan_ung": null,
  //     "loai_phan_ung": "Không có phản ứng",
  //     "ket_qua": null
  // }

  String getTrangThai() {
    if (trang_thai == 2) {
      return "Đã tiêm";
    }
    return "undefined";
  }

  HistoryVaccination.fromJson(Map<String, dynamic> json) {
    lich_su_tiem_id = (json['lich_su_tiem_id'] as double).toInt();
    doi_tuong_id = (json['doi_tuong_id'] as double).toInt();
    vacxin_id = (json['vacxin_id'] as double).toInt();
    ten_vacxin = json['ten_vacxin'];
    khang_nguyen = json['khang_nguyen'];
    trang_thai = json['trang_thai'];
    ngay_tiem = json['ngay_tiem'];
    thu_tu_mui_tiem = json['thu_tu_mui_tiem'];
    co_so_tiem_chung = json['co_so_tiem_chung'];
    seo = json['seo'];
    /*truoc_24h = json['truoc_24h'];*/
    lo_vacxin = json['lo_vacxin'];
    phan_ung_sau_tiem = json['phan_ung_sau_tiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lich_su_tiem_id'] = this.lich_su_tiem_id;
    data['doi_tuong_id'] = this.doi_tuong_id;
    data['vacxin_id'] = this.vacxin_id;
    data['ten_vacxin'] = this.ten_vacxin;
    data['khang_nguyen'] = this.khang_nguyen;
    data['trang_thai'] = this.trang_thai;
    data['ngay_tiem'] = this.ngay_tiem;
    data['thu_tu_mui_tiem'] = this.thu_tu_mui_tiem;
    data['co_so_tiem_chung'] = this.co_so_tiem_chung;
    data['seo'] = this.seo;
    // data['truoc_24h'] = truoc_24h;
    data['lo_vacxin'] = lo_vacxin;
    data['phan_ung_sau_tiem'] = phan_ung_sau_tiem;
    return data;
  }
}
