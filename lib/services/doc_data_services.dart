// get user level
import 'package:shared_preferences/shared_preferences.dart';

// JUSTIFICATION

Future<String> getJustfName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfName') ?? '';
}

Future<String> getJustfSubject() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfSubject') ?? '';
}

Future<String> getJustfDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDate') ?? '';
}

Future<int> getJustfID() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('justfID') ?? 0;
}

Future<String> getJustfBI() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfBI') ?? '';
}

Future<String> getJustfDays() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfDays') ?? '';
}

Future<String> getJustfAfter() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('justfAfter') ?? '';
}

// REQUISITIONS

Future<int> getRequisId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('requisId') ?? 0;
}

Future<String> getRequisName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisName') ?? '';
}

Future<String> getRequisAge() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisAge') ?? '';
}

Future<String> getRequisPreD() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisPrediagnosis') ?? '';
}

Future<String> getRequisExams() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisExames') ?? '';
}

Future<String> getRequisDate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('requisDate') ?? '';
}


// HISTORICS

Future<int> getHistPatient() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('id') ?? 0;
}

Future<String> getHistPatientName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('name') ?? '';
}

Future<String> getHistPatientGender() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('gender') ?? '';
}

Future<String> getHistPatientNumber() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('numberphone') ?? '';
}

Future<String> getHistPatientAddress() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('address') ?? '';
}

Future<String> getHistPatientlocal() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('local') ?? '';
}

Future<String> getHistPatientdate() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('date') ?? '';
}

Future<String> getHistPatientstatus() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('staus') ?? '';
}

Future<String> getHistPatientBI() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('bi') ?? '';
}

Future<String> getHistPatientspouse() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('spouse') ?? '';
}

Future<String> getHistPatientparents() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('parents') ?? '';
}

Future<String> getHistPatientprofission() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('profission') ?? '';
}