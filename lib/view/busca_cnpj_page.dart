import 'package:apk_investimento/service/invertexto_service.dart';
import 'package:flutter/material.dart';

class BuscaCnpj extends StatefulWidget {
  const BuscaCnpj({super.key});
  @override
  _BuscaCnpj createState() => _BuscaCnpj();
}

class _BuscaCnpj extends State<BuscaCnpj> {
  String? campo;
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o CNPJ",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            if (campo != null)
              FutureBuilder(
                future: apiService.BuscaCnpj(campo!),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erro ao buscar dados.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return exibeResultado(context, snapshot);
                      }
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
    String dadosEmpresa = '';
    if (snapshot.data != null) {
      final dados = snapshot.data;
      dadosEmpresa += "Razão Social: ";
      dadosEmpresa += dados["razao_social"] ?? "Não disponível";
      dadosEmpresa += "\n";
      dadosEmpresa += "Nome Fantasia: ";
      dadosEmpresa += dados["nome_fantasia"] ?? "Não disponível";
      dadosEmpresa += "\n";
      dadosEmpresa += "Situação: ";
      dadosEmpresa += dados["situacao"] ?? "Não disponível";
      dadosEmpresa += "\n";
      dadosEmpresa += "Endereço: ";
      dadosEmpresa += dados["address"] ?? "Não disponível";
      dadosEmpresa += "\n";
      dadosEmpresa += "Cidade/UF: ";
      dadosEmpresa += "${dados["city"] ?? "Não disponível"} - "
          "${dados["state"] ?? ""}";
    }

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        dadosEmpresa,
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}