import 'package:objectbox/objectbox.dart';
import 'package:survey_stunting/models/localDb/soal_model.dart';

import 'jawaban_soal_model.dart';
import 'kategori_soal_model.dart';
import 'survey_model.dart';

@Entity()
class JawabanSurveyModel {
  @Id(assignable: true)
  int? id = 0;
  String? jawabanLainnya;
  int? soalId;
  int? kodeUnikSurveyId;
  int? kategoriSoalId;
  int? jawabanSoalId;
  String lastModified;

  JawabanSurveyModel({
    this.id,
    this.jawabanLainnya,
    this.soalId,
    this.kodeUnikSurveyId,
    this.kategoriSoalId,
    this.jawabanSoalId,
    required this.lastModified,
  });

  final soal = ToOne<SoalModel>();
  final kodeUnikSurvey = ToOne<SurveyModel>();
  final kategoriSoal = ToOne<KategoriSoalModel>();

  // @Backlink()
  final jawabanSoal = ToMany<JawabanSoalModel>();

  Map<String, dynamic> toJson() => {
        "id": id,
        "soal_id": soalId.toString(),
        "kode_unik_survey": kodeUnikSurveyId.toString(),
        "kategori_soal_id": kategoriSoalId.toString(),
        "jawaban_soal_id": jawabanSoalId.toString(),
        "jawaban_lainnya": jawabanLainnya.toString(),
        "updated_at": lastModified.toString(),
      };
}
