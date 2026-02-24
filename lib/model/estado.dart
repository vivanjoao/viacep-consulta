import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Estado {
  String? cep;

  String? logradouro;

  String? complemento;

  String? bairro;

  String? estado;

  Estado({this.cep, this.logradouro, this.complemento, this.bairro, this.estado});

  factory Estado.fromJson(Map<String, dynamic> json) =>
    Estado(
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        bairro: json['bairro'],
        estado: json['estado'],
    );

  Map<String, dynamic> toJson() => {
    'cep': cep,
    'logradouro': logradouro,
    'complemento': complemento,
    'bairro': bairro,
    'estado': estado,
  };

}