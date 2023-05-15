import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:sokaweramobile/Network/api.dart';
import 'package:sokaweramobile/Pages/InputScreen/DetailKeteranganKesehatan.dart';
import 'package:sokaweramobile/Pages/InputScreen/DetailKuisionerPembangunan.dart';
import 'package:sokaweramobile/Pages/InputScreen/KepemilikanAsetController.dart';
import 'package:sokaweramobile/Pages/InputScreen/KeteranganKesehatanController.dart';
import 'package:sokaweramobile/Pages/InputScreen/KeteranganKhususPendidikanController.dart';
import 'package:sokaweramobile/Pages/InputScreen/KeteranganPerumahanController.dart';
import 'package:sokaweramobile/Pages/InputScreen/KeteranganUsahaController.dart';
import 'package:sokaweramobile/Pages/InputScreen/LuasPanenController.dart';
import 'package:sokaweramobile/Pages/InputScreen/PenguasaanHewanTernakController.dart';
import 'package:sokaweramobile/Pages/InputScreen/PenguasaanTanahController.dart';
import 'InputScreen/KeteranganSosialAnggotaKeluargaController.dart';
import 'InputScreen/KeteranganTempatController.dart';
import 'InputScreen/KeteranganRespondenController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String name = "";
  String initial = "";
  var total_data;
  bool _isFilled1 = false;
  bool _isFilled2 = false;
  bool _isFilled3 = false;
  bool _isFilled4 = false;
  var _isFilled5 = false;
  var _isFilled6 = false;
  bool _isFilled7 = false;
  bool _isFilled8 = false;
  bool _isFilled9 = false;
  bool _isFilled10 = false;
  bool _isFilled11 = false;
  bool _isFilled = false;
  bool isLoading = false;
  void initState() {
    _getKeteranganTempatFromLocal();
    _getKeteranganRespondenFromLocal();
    _loadUserData();
    _loadKeteranganTotalData();
    _loadAllDatafromLocal();
    _loadDataKeteranganKhususPendidikan();
    _getKeteranganKesehatanFromLocal();
    _getStatusUsaha();
    _getKeteranganUsahaFromLocal();
    _loadPenguasaanTanahLocal();
    _laodDataLuasPanen();
    _loadKeteranganPerumahanData();
    _loadKepemilikanAsetData();
    _loadPenguasaanHewanTernak();
    _loadKuisioner();
    super.initState();
  }

  _getKeteranganTempatFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_tempat');

    if (data != null) {
      setState(() {
        _isFilled1 = true;
      });
    } else {
      return null;
    }
  }

  _postAllData() async {
    await _postKeteranganTempatData();
    await _postKeteranganRespondenData();
    await _postKeteranganSosialData();
    await _postKeteranganKhususPendidikanData();
    await _postKeteranganKhususKesehatanData();
    await _postKeteranganUsahaData();
    await _postPenguasanTanahData();
    await _postLuasPanenData();
    await _postKeteranganPerumahanData();
    await _postKepemilikanAsetData();
    await _postKepemilikanHewanTernak();
    await _postKuisioner();
    setState(() {
      isLoading = false;
    });
  }

  _loadKeteranganTotalData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getInt('total_keluarga_full');
    if (user != null) {
      setState(() {
        total_data = user;
      });
    } else {
      return null;
    }
  }

  _loadPenguasaanHewanTernak() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("penguasaan_hewan_ternak");
    if (user != null) {
      setState(() {
        _isFilled11 = true;
      });
    } else {
      return null;
    }
  }

  _loadKeteranganPerumahanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("keterangan_perumahan");
    if (user != null) {
      setState(() {
        _isFilled9 = true;
      });
    } else {
      setState(() {
        _isFilled9 = false;
      });
    }
  }

  bool _isFilled12 = false;

  _loadKuisioner() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("eval_pembangunan");
    if (user != null) {
      setState(() {
        _isFilled12 = true;
      });
    } else {
      setState(() {
        _isFilled12 = false;
      });
    }
  }

  _loadKepemilikanAsetData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("kepemilikan_aset");
    if (user != null) {
      setState(() {
        _isFilled10 = true;
      });
    } else {
      setState(() {
        _isFilled10 = false;
      });
    }
  }

  _postKuisioner() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var eval_pembangunan = localStorage.getString("eval_pembangunan");
    var parsing = jsonDecode(eval_pembangunan!);
    var data = {
      'nomor_kk': parsing['nomor_kk'],
      'mengetahui_rpjm_desa': parsing['mengetahui_rpjm_desa'],
      'mengetahui_rkp_desa': parsing['mengetahui_rkp_desa'],
      'mengetahui_musrenbangdes': parsing['mengetahui_musrenbangdes'],
      'manfaat_bltdd': parsing['manfaat_bltdd'],
      'keluarga_penerima_bltdd': parsing['keluarga_penerima_bltdd'],
      'pembangunan_tahun_anggaran': parsing['pembangunan_tahun_anggaran'],
      'pelayanan_administrasi': parsing['pelayanan_administrasi'],
      'penyebab_point_7': parsing['penyebab_point_7'],
      'kepuasan_pelayanan_umum': parsing['kepuasan_pelayanan_umum'],
      'penyebab_point_10': parsing['penyebab_point_10'],
      'kegiatan_pemerintah_desa': parsing['kegiatan_pemerintah_desa'],
      'perbaikan_mendasar_pemerintah_desa':
          parsing['perbaikan_mendasar_pemerintah_desa'],
      'penyebab_point_14': parsing['penyebab_point_14'],
      'jml_anggota_keluarga_mengikuti':
          parsing['jml_anggota_keluarga_mengikuti'],
      'prioritas_pembangunan': parsing['prioritas_pembangunan'],
      'alasan_memilih_prioritas_itu': parsing['alasan_memilih_prioritas_itu'],
      'jml_anggota_keluarga_korban_kejahatan':
          parsing['jml_anggota_keluarga_korban_kejahatan'],
      'jenis_korban_kejahatan': parsing['jenis_korban_kejahatan'],
      'jml_anggota_keluarga_korban_bencana':
          parsing['jml_anggota_keluarga_korban_bencana'],
      'jenis_bencana_alam': parsing['jenis_bencana_alam'],
    };
    var res = await Network().store(data, 'eval_pembangunan');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert kuisioner");
    } else {
      print(body);
    }
  }

  _postPenguasanTanahData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var penguasaan_tanah = localStorage.getString('penguasaan_tanah');
    var parsing = jsonDecode(penguasaan_tanah!);
    var data = {
      'jenis_lahan': parsing['jenis_lahan'],
      'nomor_urut_bidang': parsing['nomor_urut_bidang'],
      'lokasi_lahan': parsing['lokasi_lahan'],
      'nomor_blok_tanah': parsing['nomor_blok_tanah'],
      'tanah_bersertifikat': parsing['tanah_bersertifikat'],
      'nama_sppt_sesuai': parsing['nama_sppt_sesuai'],
      'lahan_dimiliki': parsing['lahan_dimiliki'],
      'lahan_pihak_lain': parsing['lahan_pihak_lain'],
      'lahan_berada_pihak_lain': parsing['lahan_berada_pihak_lain'],
      'lahan_dikuasai': parsing['lahan_dikuasai'],
      'nomor_kk': parsing['nomor_kk'],
    };
    var res = await Network().store(data, 'penguasaan_tanah');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert penguasaan tanah");
    } else {
      print("error penguasaan tanah");
    }
  }

  _postKepemilikanHewanTernak() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var penguasaan_ternak = localStorage.getStringList("detail_hewan_ternak");
    for (var element in penguasaan_ternak!) {
      var parsing = jsonDecode(element);
      var data = {
        'jenis_ternak': parsing['jenis_ternak'],
        'jumlah_ternak_dimiliki': parsing['jumlah_ternak_dimiliki'],
        'jumlah_ternak_dimiliki_jantan':
            parsing['jumlah_ternak_dimiliki_jantan'],
        'jumlah_ternak_dimiliki_betina':
            parsing['jumlah_ternak_dimiliki_betina'],
        'jumlah_ternak_pihak_lain': parsing['jumlah_ternak_pihak_lain'],
        'jumlah_ternak_pihak_lain_jantan':
            parsing['jumlah_ternak_pihak_lain_jantan'],
        'jumlah_ternak_pihak_lain_betina':
            parsing['jumlah_ternak_pihak_lain_betina'],
        'jumlah_ternak_berada_dipihak_lain':
            parsing['jumlah_ternak_berada_dipihak_lain'],
        'jumlah_ternak_berada_dipihak_lain_jantan':
            parsing['jumlah_ternak_berada_dipihak_lain_jantan'],
        'jumlah_ternak_berada_dipihak_lain_betina':
            parsing['jumlah_ternak_berada_dipihak_lain_betina'],
        'jumlah_ternak_dikuasai': parsing['jumlah_ternak_dikuasai'],
        'nomor_kk': parsing['nomor_kk'],
      };
      var res = await Network().store(data, 'kepemilikan_hewan');
      var body = json.decode(res.body);
      if (body["status"] == 200) {
        print("sukses insert kepemilikan hewan");
      } else {
        print("error kepemilikan hewan");
      }
    }
  }

  _postKepemilikanAsetData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var kepemilikan_aset = localStorage.getString("kepemilikan_aset");
    var parsing = jsonDecode(kepemilikan_aset!);
    var data = {
      'ac': parsing['ac'],
      'kulkas': parsing['kulkas'],
      'mesin_cuci': parsing['mesin_cuci'],
      'televisi': parsing['televisi'],
      'komputer_laptop': parsing['komputer_laptop'],
      'mobil': parsing['mobil'],
      'motor': parsing['motor'],
      'sepeda': parsing['sepeda'],
      'nomor_kk': parsing['nomor_kk'],
    };
    var res = await Network().store(data, 'kepemilikan_aset');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert kepemilikan aset");
    } else {
      print("error insert kepemilikan aset");
    }
  }

  _postKeteranganPerumahanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_perumahan = localStorage.getString("keterangan_perumahan");
    var parsing = jsonDecode(keterangan_perumahan!);
    var data = {
      'status_penggunaan_bangunan_tempat_tinggal':
          parsing['status_penggunaan_bangunan_tempat_tinggal'],
      'status_lahan_bangunan_tempat_tinggal':
          parsing['status_lahan_bangunan_tempat_tinggal'],
      'jumlah_kk_tinggal_dibangunan': parsing['jumlah_kk_tinggal_dibangunan'],
      'luas_lantai': parsing['luas_lantai'],
      'jenis_lantai_terluas': parsing['jenis_lantai_terluas'],
      'jenis_dinding_terluas': parsing['jenis_dinding_terluas'],
      'jumlah_ruangan_seluruhnya': parsing['jumlah_ruangan_seluruhnya'],
      'sumber_air_minum': parsing['sumber_air_minum'],
      'sumber_penerangan_utama': parsing['sumber_penerangan_utama'],
      'daya_terpasang': parsing['daya_terpasang'],
      'bahan_bakar_utama_memasak': parsing['bahan_bakar_utama_memasak'],
      'penggunaan_fasilitas_tempat_bab':
          parsing['penggunaan_fasilitas_tempat_bab'],
      'jenis_kloset': parsing['jenis_kloset'],
      'tempat_pembuangan_akhir_tinja': parsing['tempat_pembuangan_akhir_tinja'],
      'jumlah_fasilitas_cuci_tangan': parsing['jumlah_fasilitas_cuci_tangan'],
      'nomor_kk': parsing['nomor_kk'],
    };
    var res = await Network().store(data, 'keterangan_perumahan');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert keterangan perumahan");
    } else {
      print("error keterangan_perumahan");
    }
  }

  _postKeteranganTempatData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_tempat = localStorage.getString('keterangan_tempat');
    var parsing = jsonDecode(keterangan_tempat!);
    var data = {
      "provinsi": parsing["provinsi"],
      "kabupaten": parsing["kabupaten"],
      "kecamatan": parsing["kecamatan"],
      "desa": parsing["desa"],
      "dusun": parsing["dusun"],
      "nama_jalan": parsing["nama_jalan"],
      "rt": parsing["rt"],
      "rw": parsing["rw"],
      "nomor_kk": parsing["nomor_kk"],
      "nomor_urut_rumah": parsing["nomor_urut_rumah"],
      "nomor_urut_keluarga": parsing["nomor_urut_keluarga"],
    };
    var res = await Network().store(data, 'keterangan_tempat');
    var body = json.decode(res.body);
    if (body["status"] == 200) {
      print("sukses insert keterangan tempat");
    } else {
      print("error tempat");
    }
  }

  _postKeteranganRespondenData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_responden = localStorage.getString("keterangan_responden");
    var parsing = jsonDecode(keterangan_responden!);
    var nik_kk = localStorage.getInt("nik_kk");
    var data = {
      "nama_kepala_keluarga": parsing["nama_kepala_keluarga"],
      "jumlah_anggota_keluarga_sesuai_kk":
          parsing["jumlah_anggota_keluarga_sesuai_kk"],
      "jumlah_anggota_keluarga_sesuai_kk_laki":
          parsing["jumlah_anggota_keluarga_sesuai_kk_laki"],
      "jumlah_anggota_keluarga_sesuai_kk_perempuan":
          parsing["jumlah_anggota_keluarga_sesuai_kk_perempuan"],
      "jumlah_anggota_keluarga_tinggal_dirumah":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah"],
      "jumlah_anggota_keluarga_tinggal_dirumah_laki":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah_laki"],
      "jumlah_anggota_keluarga_tinggal_dirumah_perempuan":
          parsing["jumlah_anggota_keluarga_tinggal_dirumah_perempuan"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah_laki"],
      "jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan":
          parsing["jumlah_anggota_keluarga_tidak_tinggal_dirumah_perempuan"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_laki"],
      "jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan":
          parsing["jumlah_orang_bukan_keluarga_tapi_tinggal_dirumah_perempuan"],
      "jumlah_orang_tinggal_dirumah": parsing["jumlah_orang_tinggal_dirumah"],
      "jumlah_orang_tinggal_dirumah_laki":
          parsing["jumlah_orang_tinggal_dirumah_laki"],
      "jumlah_orang_tinggal_dirumah_perempuan":
          parsing["jumlah_orang_tinggal_dirumah_perempuan"],
      "jumlah_anggota_keluarga_menyusui":
          parsing["jumlah_anggota_keluarga_menyusui"],
      "jumlah_anggota_keluarga_jaminan_kesehatan":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan"],
      "jumlah_anggota_keluarga_jaminan_kesehatan_laki":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan_laki"],
      "jumlah_anggota_keluarga_jaminan_kesehatan_perempuan":
          parsing["jumlah_anggota_keluarga_jaminan_kesehatan_perempuan"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_laki"],
      "jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan":
          parsing["jumlah_anggota_keluarga_sedang_mencari_pekerjaan_perempuan"],
      "jumlah_anggota_keluarga_sedang_tki":
          parsing["jumlah_anggota_keluarga_sedang_tki"],
      "jumlah_anggota_keluarga_sedang_tki_laki":
          parsing["jumlah_anggota_keluarga_sedang_tki_laki"],
      "jumlah_anggota_keluarga_sedang_tki_perempuan":
          parsing["jumlah_anggota_keluarga_sedang_tki_perempuan"],
      "jumlah_anggota_keluarga_ikatan_dinas":
          parsing["jumlah_anggota_keluarga_ikatan_dinas"],
      "jumlah_anggota_keluarga_ikatan_dinas_pns":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_pns"],
      "jumlah_anggota_keluarga_ikatan_dinas_tni_polri":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_tni_polri"],
      "jumlah_anggota_keluarga_ikatan_dinas_pensiunan":
          parsing["jumlah_anggota_keluarga_ikatan_dinas_pensiunan"],
      "id_petugas": parsing["id_petugas"],
      "nik_kk": "${nik_kk}",
      "rt": parsing["rt"],
      "rw": parsing["rw"],
    };

    var res = await Network().store(data, 'keterangan_responden');
    var body = json.decode(res.body);
    // print(parsing["id_petugas"]);
    if (body["status"] == 200) {
      print("sukses insert keterangan responden");
    } else {
      print("error responden");
    }
  }

  _postKeteranganSosialData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_sosial = localStorage.getStringList("nama_anggota") ?? [];
    if (keterangan_sosial != null) {
      for (var element in keterangan_sosial) {
        var parsing = jsonDecode(element);
        var data = {
          "nik_kk": parsing["nik_kk"],
          "rt": parsing["rt"],
          "rw": parsing["rw"],
          "nama": parsing["nama"],
          "nik": parsing["nik"],
          "hubungan": parsing["hubungan"],
          "tinggal": parsing["tinggal"],
          "jenis_kelamin": parsing["jenis_kelamin"],
          "umur": parsing["umur"],
          "status": parsing["status"],
          "status_kehamilan": parsing["status_kehamilan"],
          "partisipasi": parsing["partisipasi"],
          "ijazah_tertinggi": parsing["ijazah_tertinggi"],
          "bekerja": parsing["bekerja"],
          "lapangan_kerja": parsing["lapangan_kerja"],
          "status_kerja": parsing["status_kerja"],
          "id_petugas": parsing["id_petugas"],
        };
        var res = await Network().store(data, 'keterangan_sosial');
        var body = json.decode(res.body);
        if (body["status"] == 200) {
          print("sukses insert keterangan sosial");
        } else {
          print("error sosial");
        }
      }
    }
  }

  _postKeteranganKhususPendidikanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_pendidikan =
        localStorage.getStringList('detail_keterangan_pendidikan');
    if (keterangan_pendidikan != null) {
      for (var element in keterangan_pendidikan) {
        var parsing = jsonDecode(element);
        var data = {
          'nama_anggota_keluarga_masih_sekolah':
              parsing['nama_anggota_keluarga_masih_sekolah'],
          'jenjang_pendidikan_ditempuh': parsing['jenjang_pendidikan_ditempuh'],
          'nama_sekolah': parsing['nama_sekolah'],
          'kelas': parsing['kelas'],
          'kost_tidak': parsing['kost_tidak'],
          'beasiswa_tidak': parsing['beasiswa_tidak'],
          'melanjutkan_sekolah_tidak': parsing['melanjutkan_sekolah_tidak'],
          'nama_sekolah_tujuan': parsing['nama_sekolah_tujuan'],
          'jumlah_biaya_sekolah': parsing['jumlah_biaya_sekolah'],
          'nik_kk': parsing['nik_kk'],
        };
        var res = await Network().store(data, 'keterangan_khusus_pendidikan');
        var body = json.decode(res.body);
        if (body['status'] == 200) {
          print("sukses insert keterangan khusus pendidikan");
        } else {
          print("error pendidikan");
        }
      }
    }
  }

  _postKeteranganUsahaData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_usaha =
        localStorage.getStringList('detail_keterangan_usaha') ?? [];
    // var parsing = jsonDecode(keterangan_usaha!);
    for (var element in keterangan_usaha) {
      var parsing = jsonDecode(element);
      var data = {
        'nama': parsing['nama'],
        'nik': parsing['nik'],
        'nomor_kk': parsing['nomor_kk'],
        'lokasi_usaha': parsing['lokasi_usaha'],
        'tempat_usaha': parsing['tempat_usaha'],
        'jumlah_karyawan': parsing['jumlah_karyawan'],
        'pekerja_tetap_dibayar': parsing['pekerja_tetap_dibayar'],
        'pekerja_keluarga_tdk_dibayar': parsing['pekerja_keluarga_tdk_dibayar'],
        'komoditas': parsing['komoditas'],
        'memiliki_IUMK': parsing['memiliki_IUMK'],
        'omset_penjualan': parsing['omset_penjualan'],
      };
      var res = await Network().store(data, 'keterangan_usaha');
      var body = json.decode(res.body);
      if (body["status"] == 200) {
        print("sukses insert keterangan usaha");
      } else {
        print("error usaha");
      }
    }
  }

  _postLuasPanenData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var luas_panen = localStorage.getStringList("detail_luas_panen") ?? [];
    for (var element in luas_panen) {
      var parsing = jsonDecode(element);
      var data = {
        'jenis_tanaman': parsing['jenis_tanaman'],
        'frekuensi_panen': parsing['frekuensi_panen'],
        'luas_panen': parsing['luas_panen'],
        'produksi': parsing['produksi'],
        'nomor_kk': parsing['nomor_kk'],
      };
      var res = await Network().store(data, "luas_panen");
      var body = json.decode(res.body);
      if (body["status"] == 200) {
        print("sukses insert luas panen");
      } else {
        print("error luas panen");
      }
    }
  }

  _postKeteranganKhususKesehatanData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var keterangan_kesehatan =
        localStorage.getStringList('detail_keterangan_khusus_kesehatan') ?? [];
    if (keterangan_kesehatan != null) {
      for (var element in keterangan_kesehatan) {
        var parsing = jsonDecode(element);
        var data = {
          'nama': parsing["nama"],
          'penyakit': parsing["penyakit"],
          'jenis_cacat': parsing['jenis_cacat'],
          'jumlah_hari_opname': parsing['jumlah_hari_opname'],
          'keluhan_kesehatan': parsing['keluhan_kesehatan'],
          'pernah_terpapar_covid': parsing['pernah_terpapar_covid'],
          'tempat_karantina_covid': parsing['tempat_karantina_covid'],
          'jenis_keluhan_covid': parsing['jenis_keluhan_covid'],
          'sudah_vaksin_covid': parsing['sudah_vaksin_covid'],
          'biaya_kesehatan': parsing['biaya_kesehatan'],
          'nik': parsing['nik'],
          'nomor_kk': parsing['nomor_kk'],
        };
        var res = await Network().store(data, 'keterangan_kesehatan');
        var body = json.decode(res.body);
        if (body['status'] == 200) {
          print("sukses insert keterangan khusus kesehatan");
        } else {
          print("error khusus kesehatan");
        }
      }
    }
  }

  var list_nama = [];

  _getKeteranganRespondenFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('keterangan_responden');

    if (data != null) {
      setState(() {
        _isFilled2 = true;
      });
    } else {
      return null;
    }
  }

  _getKeteranganKesehatanFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data =
        localStorage.getStringList("detail_keterangan_khusus_kesehatan") ?? [];
    if (data.length == total_data) {
      setState(() {
        _isFilled5 = true;
      });
    } else {
      setState(() {
        _isFilled5 = false;
      });
    }
  }

  _getKeteranganUsahaFromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getStringList("detail_keterangan_usaha");
    if (data != null) {
      setState(() {
        _isFilled6 = true;
      });
    }
  }

  var isHaveUsaha = false;

  _loadAllDatafromLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("nama_anggota");
    if (user != null) {
      for (var element in user) {
        var parsing = jsonDecode(element);
        if (parsing["usaha"] == "Ya") {
          var data = {
            'nama': parsing['nama'],
            'nik': parsing['nik'],
            'nomor_kk': parsing['nik_kk']
          };
          list_nama.add(data);
        }
        if (user.length == total_data) {
          setState(() {
            _isFilled3 = true;
          });
        } else {
          setState(() {
            _isFilled3 = false;
          });
        }
      }
    }
  }

  var _isHaveLuasPanen = false;

  _loadPenguasaanTanahLocal() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('penguasaan_tanah');
    var parsing = jsonDecode(user!);
    if (user != null) {
      if (parsing["jenis_lahan"] != "Lahan tempat tinggal") {
        setState(() {
          _isHaveLuasPanen = true;
        });
      } else {
        setState(() {
          _isHaveLuasPanen = false;
        });
      }
      setState(() {
        _isFilled7 = true;
      });
    } else {
      setState(() {
        _isFilled7 = false;
      });
    }
  }

  _loadDataKeteranganKhususPendidikan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList('detail_keterangan_pendidikan');
    if (user != null) {
      setState(() {
        _isFilled4 = true;
      });
    }
  }

  _laodDataLuasPanen() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getStringList("detail_luas_panen");
    if (user != null) {
      setState(() {
        _isFilled8 = true;
      });
    }
  }

  _getStatusUsaha() async {
    if (list_nama.isNotEmpty) {
      setState(() {
        isHaveUsaha = true;
      });
    } else {
      setState(() {
        isHaveUsaha = false;
      });
    }
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      var inisial = localStorage.getString('username');
      setState(() {
        name = user;
        initial = inisial!;
      });
    } else {
      setState(() {
        name = "null";
      });
    }
  }

  _getStatusIsFilled() async {
    if (_isFilled1 == true &&
        _isFilled2 == true &&
        _isFilled3 == true &&
        _isFilled4 == true &&
        _isFilled5 == true &&
        _isFilled6 == true &&
        _isFilled7 == true) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getKeteranganUsahaFromLocal();
    _getStatusIsFilled();
    // _postKepemilikanHewanTernak();
    return Scaffold(
      backgroundColor: Color(0xFF68b7d8),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/image-input.png"),
                ),
                color: Color(0xFF68b7d8),
              ),
            ),
            Container(
              height: size.height * 5,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 24, top: 40),
                                child: Container(
                                  child: Text(
                                    "Input data",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 24),
                                child: Container(
                                  child: Text(
                                    "All you need to do is follow these steps",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 24, top: 50),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Wrap(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(KeteranganTempatController());
                                      },
                                      child: Container(
                                        height: size.height * 0.06,
                                        margin: EdgeInsets.only(
                                          left: 24,
                                          right: 24,
                                          top: 24,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        alignment: Alignment.center,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0.3,
                                              color: Colors.grey,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                // Text(
                                                //   "Step 1:",
                                                //   style: GoogleFonts.poppins(
                                                //     fontSize: 14,
                                                //     fontWeight: FontWeight.w400,
                                                //   ),
                                                // ),
                                                Spacer(),
                                                Text(
                                                  "Keterangan Tempat",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  _isFilled1
                                                      ? Icons.check_box_outlined
                                                      : Icons
                                                          .check_box_outline_blank,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled1 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganRespondenController(
                                                name: name,
                                                inisial: initial,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 2:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Responden",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled2
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled2 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            const KeteranganSosial(),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 3:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Sosial Anggota Keluarga",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled3
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganKhususPendidikanController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 4:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Khusus Pendidikan",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled4
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganKhususPendidikanController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 5:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Kejadian Kelahiran",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled4
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganKhususPendidikanController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 6:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Kejadian Kematian",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled4
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganKesehatanController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Khusus Kesehatan",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled5
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isHaveUsaha ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganUsahaController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 8:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Usaha",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled6
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PenguasaanTanahController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Penguasaan Tanah / Lahan Keluarga",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled7
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isHaveLuasPanen ? true : false,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LuasPanenController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 8:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Luas Panen",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled8
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KeteranganPerumahanController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Keterangan Perumahan",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled9
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KepemilikanAsetController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Kepemilikan Aset",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled10
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PenguasaanHewanTernakController(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Penguasaan Hewan Ternak",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled11
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: _isFilled3 ? false : true,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailKuisionerPembangunan(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          margin: EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top: 24,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          alignment: Alignment.center,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.3,
                                                color: Colors.grey,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Step 7:",
                                                  //   style: GoogleFonts.poppins(
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Spacer(),
                                                  Text(
                                                    "Kuisioner",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    _isFilled11
                                                        ? Icons
                                                            .check_box_outlined
                                                        : Icons
                                                            .check_box_outline_blank,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.2,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.11,
                                      width: size.width,
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await _postAllData();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              left: 24, right: 24, top: 40),
                                          padding: EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: 14,
                                              bottom: 14),
                                          decoration: BoxDecoration(
                                            color: _isFilled
                                                ? Color(0xFF68b7d8)
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
