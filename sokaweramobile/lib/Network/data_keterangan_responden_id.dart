// To parse this JSON data, do
//
//     final dataKeteranganRespondenId = dataKeteranganRespondenIdFromJson(jsonString);

import 'dart:convert';

DataKeteranganRespondenId dataKeteranganRespondenIdFromJson(String str) =>
    DataKeteranganRespondenId.fromJson(json.decode(str));

String dataKeteranganRespondenIdToJson(DataKeteranganRespondenId data) =>
    json.encode(data.toJson());

class DataKeteranganRespondenId {
  DataKeteranganRespondenId({
    required this.code,
    required this.data,
  });

  final int code;
  final Data data;

  factory DataKeteranganRespondenId.fromJson(Map<String, dynamic> json) =>
      DataKeteranganRespondenId(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.namaKepalaKeluarga,
    required this.jumlahAnggotaKeluargaSesuaiKk,
    required this.jumlahAnggotaKeluargaSesuaiKkLaki,
    required this.jumlahAnggotaKeluargaSesuaiKkPerempuan,
    required this.jumlahAnggotaKeluargaTinggalDirumah,
    required this.jumlahAnggotaKeluargaTinggalDirumahLaki,
    required this.jumlahAnggotaKeluargaTinggalDirumahPerempuan,
    required this.jumlahAnggotaKeluargaTidakTinggalDirumah,
    required this.jumlahAnggotaKeluargaTidakTinggalDirumahLaki,
    required this.jumlahAnggotaKeluargaTidakTinggalDirumahPerempuan,
    required this.jumlahOrangBukanKeluargaTapiTinggalDirumah,
    required this.jumlahOrangBukanKeluargaTapiTinggalDirumahLaki,
    required this.jumlahOrangBukanKeluargaTapiTinggalDirumahPerempuan,
    required this.jumlahOrangTinggalDirumah,
    required this.jumlahOrangTinggalDirumahLaki,
    required this.jumlahOrangTinggalDirumahPerempuan,
    required this.jumlahAnggotaKeluargaMenyusui,
    required this.jumlahAnggotaKeluargaJaminanKesehatan,
    required this.jumlahAnggotaKeluargaJaminanKesehatanLaki,
    required this.jumlahAnggotaKeluargaJaminanKesehatanPerempuan,
    required this.jumlahAnggotaKeluargaSedangMencariPekerjaan,
    required this.jumlahAnggotaKeluargaSedangMencariPekerjaanLaki,
    required this.jumlahAnggotaKeluargaSedangMencariPekerjaanPerempuan,
    required this.jumlahAnggotaKeluargaSedangTki,
    required this.jumlahAnggotaKeluargaSedangTkiLaki,
    required this.jumlahAnggotaKeluargaSedangTkiPerempuan,
    required this.jumlahAnggotaKeluargaIkatanDinas,
    required this.jumlahAnggotaKeluargaIkatanDinasPns,
    required this.jumlahAnggotaKeluargaIkatanDinasTniPolri,
    required this.jumlahAnggotaKeluargaIkatanDinasPensiunan,
    required this.idPetugas,
    required this.nikKk,
    required this.rt,
    required this.rw,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.petugas,
    required this.anak,
  });

  final int id;
  final String namaKepalaKeluarga;
  final int jumlahAnggotaKeluargaSesuaiKk;
  final int jumlahAnggotaKeluargaSesuaiKkLaki;
  final int jumlahAnggotaKeluargaSesuaiKkPerempuan;
  final int jumlahAnggotaKeluargaTinggalDirumah;
  final int jumlahAnggotaKeluargaTinggalDirumahLaki;
  final int jumlahAnggotaKeluargaTinggalDirumahPerempuan;
  final int jumlahAnggotaKeluargaTidakTinggalDirumah;
  final int jumlahAnggotaKeluargaTidakTinggalDirumahLaki;
  final int jumlahAnggotaKeluargaTidakTinggalDirumahPerempuan;
  final int jumlahOrangBukanKeluargaTapiTinggalDirumah;
  final int jumlahOrangBukanKeluargaTapiTinggalDirumahLaki;
  final int jumlahOrangBukanKeluargaTapiTinggalDirumahPerempuan;
  final int jumlahOrangTinggalDirumah;
  final int jumlahOrangTinggalDirumahLaki;
  final int jumlahOrangTinggalDirumahPerempuan;
  final int jumlahAnggotaKeluargaMenyusui;
  final int jumlahAnggotaKeluargaJaminanKesehatan;
  final int jumlahAnggotaKeluargaJaminanKesehatanLaki;
  final int jumlahAnggotaKeluargaJaminanKesehatanPerempuan;
  final int jumlahAnggotaKeluargaSedangMencariPekerjaan;
  final int jumlahAnggotaKeluargaSedangMencariPekerjaanLaki;
  final int jumlahAnggotaKeluargaSedangMencariPekerjaanPerempuan;
  final int jumlahAnggotaKeluargaSedangTki;
  final int jumlahAnggotaKeluargaSedangTkiLaki;
  final int jumlahAnggotaKeluargaSedangTkiPerempuan;
  final int jumlahAnggotaKeluargaIkatanDinas;
  final int jumlahAnggotaKeluargaIkatanDinasPns;
  final int jumlahAnggotaKeluargaIkatanDinasTniPolri;
  final int jumlahAnggotaKeluargaIkatanDinasPensiunan;
  final int idPetugas;
  final String nikKk;
  final int rt;
  final int rw;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Petugas petugas;
  final List<Anak> anak;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        namaKepalaKeluarga: json["nama_kepala_keluarga"],
        jumlahAnggotaKeluargaSesuaiKk:
            json["jumlah_anggota_keluarga_sesuai_kk"],
        jumlahAnggotaKeluargaSesuaiKkLaki:
            json["jumlah_anggota_keluarga_sesuai_kk_laki"],
        jumlahAnggotaKeluargaSesuaiKkPerempuan:
            json["jumlah_anggota_keluarga_sesuai_kk_perempuan"],
        jumlahAnggotaKeluargaTinggalDirumah:
            json["jumlah_anggota_keluarga_tinggal_dirumah"],
        jumlahAnggotaKeluargaTinggalDirumahLaki:
            json["jumlah_anggota_keluarga_tinggal_dirumah_laki"],
        jumlahAnggotaKeluargaTinggalDirumahPerempuan:
            json["jumlah_anggota_keluarga_tinggal_dirumah_perempuan"],
        jumlahAnggotaKeluargaTidakTinggalDirumah:
            json["jumlah_anggota_keluarga_tidak_tinggal_dirumah"],
        jumlahAnggotaKeluargaTidakTinggalDirumahLaki:
            json["jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki"],
        jumlahAnggotaKeluargaTidakTinggalDirumahPerempuan:
            json["jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan"],
        jumlahOrangBukanKeluargaTapiTinggalDirumah:
            json["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah"],
        jumlahOrangBukanKeluargaTapiTinggalDirumahLaki:
            json["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki"],
        jumlahOrangBukanKeluargaTapiTinggalDirumahPerempuan:
            json["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan"],
        jumlahOrangTinggalDirumah: json["jumlah_orang_tinggal_dirumah"],
        jumlahOrangTinggalDirumahLaki:
            json["jumlah_orang_tinggal_dirumah_laki"],
        jumlahOrangTinggalDirumahPerempuan:
            json["jumlah_orang_tinggal_dirumah_perempuan"],
        jumlahAnggotaKeluargaMenyusui: json["jumlah_anggota_keluarga_menyusui"],
        jumlahAnggotaKeluargaJaminanKesehatan:
            json["jumlah_anggota_keluarga_jaminan_kesehatan"],
        jumlahAnggotaKeluargaJaminanKesehatanLaki:
            json["jumlah_anggota_keluarga_jaminan_kesehatan_laki"],
        jumlahAnggotaKeluargaJaminanKesehatanPerempuan:
            json["jumlah_anggota_keluarga_jaminan_kesehatan_perempuan"],
        jumlahAnggotaKeluargaSedangMencariPekerjaan:
            json["jumlah_anggota_keluarga_sedang_mencari_pekerjaan"],
        jumlahAnggotaKeluargaSedangMencariPekerjaanLaki:
            json["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki"],
        jumlahAnggotaKeluargaSedangMencariPekerjaanPerempuan:
            json["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan"],
        jumlahAnggotaKeluargaSedangTki:
            json["jumlah_anggota_keluarga_sedang_tki"],
        jumlahAnggotaKeluargaSedangTkiLaki:
            json["jumlah_anggota_keluarga_sedang_tki_laki"],
        jumlahAnggotaKeluargaSedangTkiPerempuan:
            json["jumlah_anggota_keluarga_sedang_tki_perempuan"],
        jumlahAnggotaKeluargaIkatanDinas:
            json["jumlah_anggota_keluarga_ikatan_dinas"],
        jumlahAnggotaKeluargaIkatanDinasPns:
            json["jumlah_anggota_keluarga_ikatan_dinas_pns"],
        jumlahAnggotaKeluargaIkatanDinasTniPolri:
            json["jumlah_anggota_keluarga_ikatan_dinas_tni_polri"],
        jumlahAnggotaKeluargaIkatanDinasPensiunan:
            json["jumlah_anggota_keluarga_ikatan_dinas_pensiunan"],
        idPetugas: json["id_petugas"],
        nikKk: json["nik_kk"],
        rt: json["rt"],
        rw: json["rw"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        petugas: Petugas.fromJson(json["petugas"]),
        anak: List<Anak>.from(json["anak"].map((x) => Anak.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kepala_keluarga": namaKepalaKeluarga,
        "jumlah_anggota_keluarga_sesuai_kk": jumlahAnggotaKeluargaSesuaiKk,
        "jumlah_anggota_keluarga_sesuai_kk_laki":
            jumlahAnggotaKeluargaSesuaiKkLaki,
        "jumlah_anggota_keluarga_sesuai_kk_perempuan":
            jumlahAnggotaKeluargaSesuaiKkPerempuan,
        "jumlah_anggota_keluarga_tinggal_dirumah":
            jumlahAnggotaKeluargaTinggalDirumah,
        "jumlah_anggota_keluarga_tinggal_dirumah_laki":
            jumlahAnggotaKeluargaTinggalDirumahLaki,
        "jumlah_anggota_keluarga_tinggal_dirumah_perempuan":
            jumlahAnggotaKeluargaTinggalDirumahPerempuan,
        "jumlah_anggota_keluarga_tidak_tinggal_dirumah":
            jumlahAnggotaKeluargaTidakTinggalDirumah,
        "jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki":
            jumlahAnggotaKeluargaTidakTinggalDirumahLaki,
        "jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan":
            jumlahAnggotaKeluargaTidakTinggalDirumahPerempuan,
        "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah":
            jumlahOrangBukanKeluargaTapiTinggalDirumah,
        "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki":
            jumlahOrangBukanKeluargaTapiTinggalDirumahLaki,
        "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan":
            jumlahOrangBukanKeluargaTapiTinggalDirumahPerempuan,
        "jumlah_orang_tinggal_dirumah": jumlahOrangTinggalDirumah,
        "jumlah_orang_tinggal_dirumah_laki": jumlahOrangTinggalDirumahLaki,
        "jumlah_orang_tinggal_dirumah_perempuan":
            jumlahOrangTinggalDirumahPerempuan,
        "jumlah_anggota_keluarga_menyusui": jumlahAnggotaKeluargaMenyusui,
        "jumlah_anggota_keluarga_jaminan_kesehatan":
            jumlahAnggotaKeluargaJaminanKesehatan,
        "jumlah_anggota_keluarga_jaminan_kesehatan_laki":
            jumlahAnggotaKeluargaJaminanKesehatanLaki,
        "jumlah_anggota_keluarga_jaminan_kesehatan_perempuan":
            jumlahAnggotaKeluargaJaminanKesehatanPerempuan,
        "jumlah_anggota_keluarga_sedang_mencari_pekerjaan":
            jumlahAnggotaKeluargaSedangMencariPekerjaan,
        "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki":
            jumlahAnggotaKeluargaSedangMencariPekerjaanLaki,
        "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan":
            jumlahAnggotaKeluargaSedangMencariPekerjaanPerempuan,
        "jumlah_anggota_keluarga_sedang_tki": jumlahAnggotaKeluargaSedangTki,
        "jumlah_anggota_keluarga_sedang_tki_laki":
            jumlahAnggotaKeluargaSedangTkiLaki,
        "jumlah_anggota_keluarga_sedang_tki_perempuan":
            jumlahAnggotaKeluargaSedangTkiPerempuan,
        "jumlah_anggota_keluarga_ikatan_dinas":
            jumlahAnggotaKeluargaIkatanDinas,
        "jumlah_anggota_keluarga_ikatan_dinas_pns":
            jumlahAnggotaKeluargaIkatanDinasPns,
        "jumlah_anggota_keluarga_ikatan_dinas_tni_polri":
            jumlahAnggotaKeluargaIkatanDinasTniPolri,
        "jumlah_anggota_keluarga_ikatan_dinas_pensiunan":
            jumlahAnggotaKeluargaIkatanDinasPensiunan,
        "id_petugas": idPetugas,
        "nik_kk": nikKk,
        "rt": rt,
        "rw": rw,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "petugas": petugas.toJson(),
        "anak": List<dynamic>.from(anak.map((x) => x.toJson())),
      };
}

class Anak {
  Anak({
    required this.id,
    required this.nikKk,
    required this.rt,
    required this.rw,
    required this.nama,
    required this.nik,
    required this.hubungan,
    required this.tinggal,
    required this.jenisKelamin,
    required this.umur,
    required this.status,
    required this.statusKehamilan,
    required this.partisipasi,
    required this.ijazahTertinggi,
    required this.bekerja,
    required this.lapanganKerja,
    required this.statusKerja,
    required this.idPetugas,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String nikKk;
  final int rt;
  final int rw;
  final String nama;
  final String nik;
  final String hubungan;
  final String tinggal;
  final String jenisKelamin;
  final int umur;
  final String status;
  final String statusKehamilan;
  final String partisipasi;
  final String ijazahTertinggi;
  final String bekerja;
  final String lapanganKerja;
  final String statusKerja;
  final int idPetugas;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Anak.fromJson(Map<String, dynamic> json) => Anak(
        id: json["id"],
        nikKk: json["nik_kk"],
        rt: json["rt"],
        rw: json["rw"],
        nama: json["nama"],
        nik: json["nik"],
        hubungan: json["hubungan"],
        tinggal: json["tinggal"],
        jenisKelamin: json["jenis_kelamin"],
        umur: json["umur"],
        status: json["status"],
        statusKehamilan: json["status_kehamilan"],
        partisipasi: json["partisipasi"],
        ijazahTertinggi: json["ijazah_tertinggi"],
        bekerja: json["bekerja"],
        lapanganKerja: json["lapangan_kerja"],
        statusKerja: json["status_kerja"],
        idPetugas: json["id_petugas"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik_kk": nikKk,
        "rt": rt,
        "rw": rw,
        "nama": nama,
        "nik": nik,
        "hubungan": hubungan,
        "tinggal": tinggal,
        "jenis_kelamin": jenisKelamin,
        "umur": umur,
        "status": status,
        "status_kehamilan": statusKehamilan,
        "partisipasi": partisipasi,
        "ijazah_tertinggi": ijazahTertinggi,
        "bekerja": bekerja,
        "lapangan_kerja": lapanganKerja,
        "status_kerja": statusKerja,
        "id_petugas": idPetugas,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Petugas {
  Petugas({
    required this.id,
    required this.namaPencacah,
    required this.tanggalPencacah,
    required this.tandaTanganPencacah,
    required this.namaPemeriksa,
    required this.tanggalPemeriksaan,
    required this.tandaTanganPemeriksa,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String namaPencacah;
  final DateTime tanggalPencacah;
  final String tandaTanganPencacah;
  final String namaPemeriksa;
  final DateTime tanggalPemeriksaan;
  final String tandaTanganPemeriksa;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
        id: json["id"],
        namaPencacah: json["nama_pencacah"],
        tanggalPencacah: DateTime.parse(json["tanggal_pencacah"]),
        tandaTanganPencacah: json["tanda_tangan_pencacah"],
        namaPemeriksa: json["nama_pemeriksa"],
        tanggalPemeriksaan: DateTime.parse(json["tanggal_pemeriksaan"]),
        tandaTanganPemeriksa: json["tanda_tangan_pemeriksa"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pencacah": namaPencacah,
        "tanggal_pencacah":
            "${tanggalPencacah.year.toString().padLeft(4, '0')}-${tanggalPencacah.month.toString().padLeft(2, '0')}-${tanggalPencacah.day.toString().padLeft(2, '0')}",
        "tanda_tangan_pencacah": tandaTanganPencacah,
        "nama_pemeriksa": namaPemeriksa,
        "tanggal_pemeriksaan":
            "${tanggalPemeriksaan.year.toString().padLeft(4, '0')}-${tanggalPemeriksaan.month.toString().padLeft(2, '0')}-${tanggalPemeriksaan.day.toString().padLeft(2, '0')}",
        "tanda_tangan_pemeriksa": tandaTanganPemeriksa,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
