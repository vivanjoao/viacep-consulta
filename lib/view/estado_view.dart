import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_estado/controller/estado_controller.dart';


class EstadoView extends StatelessWidget {
  const EstadoView({super.key});

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
                  child: CircularProgressIndicator(),
                ),
              ),

              SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.6,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 24),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //controller
                        ),
                        controller: estadoController.cepController,
                        onChanged: (value) => estadoController.campoVazio(),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(6)),

                    Obx(
                      () => Opacity(
                        opacity: estadoController.cepIsEmpty.value ? 0.4 : 1,
                        child: GestureDetector(
                          onTap: () async {
                            await estadoController.consultaCep();

                            if (!estadoController.encontrouCep.value) {
                              Get.dialog(
                                barrierDismissible: false,
                                AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    "Ocorreu um erro",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                  content: Text(
                                    estadoController.msgErro.value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    FilledButton(
                                      onPressed: () {
                                        estadoController.limparCampos;
                                        Get.back();
                                      },
                                      child: const Text("Fechar"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Container(
                            color: Colors.blueGrey[300],
                            child: Icon(Icons.search, size: 36),
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
                      padding: const EdgeInsets.fromLTRB(10,8,10,8),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Center(
                            child: Text(
                              'Informações da Busca',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Divider(
                            color: Colors.black,
                            height: 2,
                            thickness: 4,
                          ),

                          Text(
                            'CEP: ${estadoController.estado?.cep ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),

                          Divider(
                            color: Colors.black,
                            height: 1,
                            thickness: 3,
                          ),

                          Text(
                            'Logradouro: ${estadoController.estado?.logradouro ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),

                          Divider(
                            color: Colors.black,
                            height: 1,
                            thickness: 3,
                          ),


                          Text(
                            'Complemento: ${estadoController.estado?.complemento ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),

                          Divider(
                            color: Colors.black,
                            height: 1,
                            thickness: 3,
                          ),


                          Text(
                            'Bairro: ${estadoController.estado?.bairro ?? ''}',
                            style: TextStyle(fontSize: 24),
                          ),

                          Divider(
                            color: Colors.black,
                            height: 1,
                            thickness: 3,
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
