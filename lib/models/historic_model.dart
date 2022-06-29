import 'user_model.dart';

class HistoricModel {
  int? id;
  String? namePatients;
  String? genderPatients;
  String? biPatients;
  String? numberPatients;
  String? addressPatients;
  String? birthdatePatients;
  String? localPatients;
  String? civilstatusPatients;
  String? spousePatients;
  String? parentsPatients;
  String? profissionPatients;
  User? user;

  HistoricModel({
    this.id,
    this.user,
    this.namePatients,
    this.genderPatients,
    this.biPatients,
    this.numberPatients,
    this.addressPatients,
    this.birthdatePatients,
    this.localPatients,
    this.civilstatusPatients,
    this.spousePatients,
    this.parentsPatients,
    this.profissionPatients,
  });

    factory HistoricModel.fromJson(Map<String, dynamic> json) {
    return HistoricModel(
      id: json['id'],
      namePatients: json['name_patients'],
      genderPatients: json['gender_patients'],
      numberPatients: json['number_patients'],
      biPatients: json['bi_patients'],
      addressPatients: json['address_patients'],
      localPatients: json['local_patients'],
      birthdatePatients: json['birth_date_patients'],
      civilstatusPatients: json['civil_status_patients'],
      spousePatients: json['spouse_patients'],
      parentsPatients: json['parents_patients'],
      profissionPatients: json['profission_patients'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
      ),
    );
  }


}