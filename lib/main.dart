import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesocontroller = TextEditingController();
  TextEditingController alturacontroller = TextEditingController();
  String _infotext = "Informe seus dados!!!";
  String? errorText;
  String? errorTextPeso;
  String? errorTextAltura;

  void _resetFields(){

    pesocontroller.text = "";

    alturacontroller.text = "";
    setState(() {

      _infotext = "Informe seus dados!!!";

    });

  }

  void _calculate(){

    String textpeso = pesocontroller.text;
    String textaltura = alturacontroller.text;

    if(textpeso.isEmpty && textaltura.isEmpty) {
      setState(() {
        errorTextAltura = "A altura não pode estar vazia!!!";
        errorTextPeso = "O peso não pode estar vazio!!!";
      });
      return;
    }
    else{

      setState(() {
        errorTextAltura = null;
        errorTextPeso = null;

      });

    }
    if(textpeso.isEmpty) {
      setState(() {
        errorTextPeso = "O peso não pode estar vazio!!!";

      });
      return;
    }
    else{

      setState(() {
        errorTextPeso = null;
      });

    };


    if(textaltura.isEmpty) {
      setState(() {
        errorTextAltura = "A altura não pode estar vazia!!!";

      });
      return;
    }
    else{

      setState(() {
        errorTextAltura = null;
      });

    }



    setState(() {



      double peso = double.parse(pesocontroller.text);
      double altura = double.parse(alturacontroller.text) / 100;

      double imc = peso / (altura * altura);

      if(imc < 18.6){

        _infotext = "Abaixo do peso ideal (${imc.toStringAsPrecision(4)})";

      }
      else if (imc >= 18.6 && imc < 24.9){

        _infotext = "Peso ideal (${imc.toStringAsPrecision(4)})";

      }
      else if (imc >= 24.9 && imc < 29.9){

        _infotext = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";

      }
      else if (imc >= 29.9 && imc < 34.9){

        _infotext = "Obesidade grau I (${imc.toStringAsPrecision(4)})";

      }
      else if (imc >= 34.9 && imc <= 39.9){

        _infotext = "Obesidade grau II (${imc.toStringAsPrecision(4)})";

      }
      else if (imc >= 40){

        _infotext = "Obesidade grau III (${imc.toStringAsPrecision(4)})";

      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh_outlined)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            SizedBox(height: 10),
            Icon(
              Icons.person,
              size: 140.0,
              color: Colors.teal,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.teal, fontSize: 22),
                hintText: "90 kg",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                ),
                errorText: errorTextPeso,
              ),
              controller: pesocontroller,
            ),
            SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.teal, fontSize: 22),
                hintText: "180 cm",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                ),
                errorText: errorTextAltura,
              ),
              controller: alturacontroller,
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: _calculate,
              child: Text("Calcular", style: TextStyle(fontSize: 20),),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                padding: EdgeInsets.all(15),

              ),
            ),
            SizedBox(height: 20),
            Text(_infotext, textAlign: TextAlign.center, style: TextStyle(color: Colors.teal, fontSize: 25),),
          ],
        ),
      ),
    );
  }
}