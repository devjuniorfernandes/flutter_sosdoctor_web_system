import 'dart:convert';
import 'package:sosdoctorsystem/models/historic_model.dart';
import '../constant.dart';
import '../models/api_response.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

// get all Justifications
Future<ApiResponse> getHistorics() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse("$baseURL/historics"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['historics']
            .map((o) => HistoricModel.fromJson(o))
            .toList();
        // we get list of Justifications, so we need to map each item to post model
        apiResponse.data as List<dynamic>;

        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> createHistoric(
  nameController,
  valueGender,
  numberPhoneController,
  addressController,
  localBronController,
  dateController,
  statusCivil,
  biController,
  spouseController,
  parentsController,
  professionController
) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse("$baseURL/historics"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name_patients': nameController,
      'gender_patients': valueGender,
      'number_patients': numberPhoneController,
      'address_patients': addressController,
      'bi_patients': biController,
      'local_patients': localBronController,
      'birth_date_patients': dateController,
      'civil_status_patients': statusCivil,
      'spouse_patients': spouseController,
      'parents_patients': parentsController,
      'profission_patients': professionController,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Delete post
Future<ApiResponse> deleteHistoric(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$baseURL/historics/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}




