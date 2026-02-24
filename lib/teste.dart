import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Teste extends StatelessWidget {


  Teste({super.key});

  RxBool isApertado = false.obs;
  RxInt contador = 0.obs;
  RxList<bool> indexApertado = [false, false].obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: corpo());
  }

  Widget corpo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 150,
      children: List.generate(
        2,
        (index) => Container(
          child: Column(
            spacing: 40,
            children: [
              GestureDetector(
                onTap: () => acaoBotao(index),
                child: Container(
                  color: Colors.amber,
                  width: 150,
                  height: 100,
                  child: Text('BOTÃOOO'),
                ),
              ),

              Center(
                child: Obx(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                    width: 250,
                    height: indexApertado[index] ? 400 : 250,
                    color: indexApertado[index] ? Colors.red : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void acaoBotao(int index) {
    print(index);
    indexApertado[index] = !indexApertado[index];

  }
}
