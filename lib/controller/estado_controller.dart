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
  RxBool errorEstado = false.obs;

  RxString msgErro = ''.obs;

  Estado? estado;

  final cepController = TextEditingController();

  consultaCep() async {
    isLoading.value = true;
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
        encontrouCep.value = false;
        estado = null;
        throw 'O CEP digitado está inválido!';
      }

    } catch (e) {
      msgErro.value = e.toString();
    } finally {
      isLoading.value = false;
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

  void limparCampos() {
    encontrouCep.value = false;
    isLoading.value = false;
    cepIsEmpty.value = true;
    errorEstado.value = false;

    cepController.text = "";

    estado = null;
  }
}
