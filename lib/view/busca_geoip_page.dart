import 'package:apk_investimento/service/invertexto_service.dart';
import 'package:flutter/material.dart';

class BuscaCep extends StatefulWidget {
  const BuscaCep({super.key});
  @override
  _BuscaCep createState() => _BuscaCep();
}

class _BuscaCep extends State<BuscaCep> {
  String? campo;
  String? resultado;
  final apiService = InverTextoApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/icon2.jpg',
            fit: BoxFit.contain, height: 40),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Digite o CEP",
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              }
            ),
            FutureBuilder(
              future: apiService.buscaCEP(campo),
              builder: (context, snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white),
                      strokeWidth: 5.0,
                  );
                  default:
                  if (snapshot.hasError){
                    return Center(child: Text(
                      'Erro ao buscar dados.',
                      style: TextStyle(color: Colors.white)));
                  }else{
                    return exibeResultado(context, snapshot);
                }
              }
            })
        ],),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot){
      String enderecoCompleto = '';
      if (snapshot.data != null){
        enderecoCompleto +=
        snapshot.data["street"] ?? "Rua não Disponivel";
        enderecoCompleto += "\n";
        enderecoCompleto +=
        snapshot.data["neighborhood"] ?? "Bairro não disponível";
        enderecoCompleto += "\n";
        enderecoCompleto +=
        snapshot.data["city"] ?? "Cidade não disponível";
        enderecoCompleto += "\n";
        enderecoCompleto +=
        snapshot.data["state"] ?? "Cidade não disponível";
      }

      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(enderecoCompleto,
          style: TextStyle(
            color: Colors.white, fontSize: 18),
            softWrap: true,
          ),
        );
    }
  }