import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:survey_stunting/models/nama_survey.dart';
import 'package:survey_stunting/models/responden.dart';
import 'package:survey_stunting/models/survey.dart';
import 'package:survey_stunting/models/survey_parameters.dart';
import 'package:survey_stunting/services/dio_client.dart';
import 'package:survey_stunting/services/handle_errors.dart';

class SurveyController extends GetxController {
  final typeSurveyEditingController = TextEditingController();
  final statusSurveyEditingController = TextEditingController();
  final searchSurveyEditingController = TextEditingController();
  final respondenEditingController = TextEditingController();
  final namaSurveyEditingController = TextEditingController();
  var isLoading = false.obs;
  var isLoadingFilter = false.obs;
  String typeSurvey = "";
  String statusSurvey = "";
  late int idResponden;
  late int idNamaSurvey;
  List<Survey> surveys = [];
  List<Responden> responden = [];
  List<NamaSurvey> namaSurvey = [];
  String token = GetStorage().read("token");

  Future getSurvey({SurveyParameters? queryParameters}) async {
    isLoading.value = true;
    try {
      List<Survey>? response = await DioClient().getSurvey(
        token: token,
        queryParameters: queryParameters,
      );
      surveys = response!;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        surveys = [];
      } else {
        handleError(error: e);
      }
    }
    isLoading.value = false;
  }

  Future getResponden() async {
    try {
      List<Responden>? response = await DioClient().getResponden(
        token: token,
      );
      responden = response!;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        responden = [];
      } else {
        handleError(error: e);
      }
    }
  }

  Future getNamaSurvey() async {
    try {
      List<NamaSurvey>? response = await DioClient().getNamaSurvey(
        token: token,
      );
      namaSurvey = response!;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        namaSurvey = [];
      } else {
        handleError(error: e);
      }
    }
  }

  Future deleteSurvey({required int id}) async {
    isLoading.value = true;
    try {
      await DioClient().deleteSurvey(
        token: token,
        id: id,
      );
      surveys.removeWhere((element) => element.id == id);
    } on DioError catch (e) {
      handleError(error: e);
    }
    isLoading.value = false;
  }

  void _setToEmpty() {
    if (statusSurveyEditingController.text == "") {
      statusSurvey = statusSurveyEditingController.text;
    }
    if (typeSurveyEditingController.text == "") {
      typeSurvey = "";
    }
  }

  @override
  void onInit() async {
    await getSurvey();
    statusSurveyEditingController.addListener(_setToEmpty);
    typeSurveyEditingController.addListener(_setToEmpty);
    super.onInit();
  }

  @override
  void dispose() {
    statusSurveyEditingController.dispose();
    typeSurveyEditingController.dispose();
    respondenEditingController.dispose();
    namaSurveyEditingController.dispose();
    super.dispose();
  }
}
