import 'package:dartz/dartz.dart';
import 'package:siakad_app/common/constants/variables.dart';
import 'package:siakad_app/data/datasources/local_remote_datasource.dart';
import 'package:siakad_app/data/models/auth_request_model.dart';
import 'package:siakad_app/data/models/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(AuthRequestModel requestModel) async {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/login"),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left("Server Eror\nerr : ${response.statusCode}");
    }
  }

  Future<Either<String, String>> logout() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}',
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return const Right("Logout Successfully");
    } else {
      return Left("Server Eror\nerr : ${response.statusCode}");
    }
  }
}
