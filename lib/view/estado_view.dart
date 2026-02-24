import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_estado/controller/estado_controller.dart';
import 'package:teste_estado/model/estado.dart';

class EstadoView extends StatelessWidget {
  EstadoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: corpo(context));
  }

  Widget corpo(context) {
    final estadoController = Get.put(EstadoController());

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bem Vindo ao Busca por CEP',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),

              Obx(
                () => Visibility(
                  visible: estadoController.isLoading.value ? true : false,
                  child: Container(child: CircularProgressIndicator()),
                ),
              ),

              SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.6,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 20),
                          ),
                          //controller
                        ),
                        controller: estadoController.cepController,
                        onChanged: (value) => estadoController.campoVazio(),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(4)),

                    Obx(
                      () => Opacity(
                        opacity:
                            estadoController.cepIsEmpty.value
                                ? 0.4
                                : 1,
                        child: GestureDetector(
                          onTap: () async {
                            await estadoController.consultaCep();

                            // estadoController.encontrouCep.value =
                            //     !estadoController.encontrouCep.value;
                          },
                          child: Container(
                              color: Colors.blueGrey[300],
                              child: Icon(Icons.search, size: 36,)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(8)),

              // Resultado
              Obx(
                () => AnimatedOpacity(
                  opacity: estadoController.encontrouCep.value ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Visibility(
                    visible: estadoController.encontrouCep.value ? true : false,
                    child: Container(
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxHeight * 0.7,
                      color: Colors.blueGrey[300],
                      child: Column(
                        spacing: 12,
                        children: [
                          Text(
                            'Informações da Busca',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'CEP: ${estadoController.estado?.cep ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Logradouro: ${estadoController.estado?.logradouro ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Complemento: ${estadoController.estado?.complemento ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Bairro: ${estadoController.estado?.bairro ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Estado: ${estadoController.estado?.estado ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),

                          // Text(estado.)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
