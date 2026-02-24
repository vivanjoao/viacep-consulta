import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_super_snackbar/getx_super_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:teste_estado/model/estado.dart';

class EstadoController extends GetxController {
  RxBool encontrouCep = false.obs;
  RxBool isLoading = false.obs;
  RxBool cepIsEmpty = true.obs;

  Estado? estado;

  final cepController = TextEditingController();

  consultaCep() async {
    isLoading = true.obs;
    encontrouCep.value = false;
    estado = null;

    try {
      String cep = cepController.value.text;
      String url = "https://viacep.com.br/ws/$cep/json/";


      http.Response response;

      response = await http.get(Uri.parse(url));



      if(response.statusCode == 200) {
        Map<String, dynamic> retorno = json.decode(response.body);

        estado = Estado.fromJson(retorno);

        encontrouCep.value = true;
      }

      if(response.statusCode == 400) {
        print('Cep Invalido');
        estado = null;
        throw 'CEP inválido!';
      }

    } catch (e) {
      print('catch ${e.toString()}');
    } finally {
      isLoading = false.obs;
    }
  }

  void campoVazio() {

    if(!cepIsEmpty.value && cepController.text.isEmpty) {
      cepIsEmpty.value = true;
      return;
    }

    cepIsEmpty.value = false;
    return;
  }
}
