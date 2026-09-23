import 'package:apk_investimento/service/invertexto_service.dart';
import 'package:flutter/material.dart';

class BuscaGeoIp extends StatefulWidget {
  const BuscaGeoIp({super.key});
  @override
  _BuscaGeoIp createState() => _BuscaGeoIp();
}

class _BuscaGeoIp extends State<BuscaGeoIp> {
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
                labelText: "Digite o IP",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            if (campo != null)
              FutureBuilder(
                future: apiService.buscaGeoIP(campo!),
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
    String resultado = '';
    if (snapshot.data != null) {
      final dados = snapshot.data;
      resultado += "País: ";
      resultado += dados["country"] ?? "Não disponível";
      resultado += "\n";
      resultado += "Estado/Região: ";
      resultado += dados["region"] ?? "Não disponível";
      resultado += "\n";
      resultado += "Cidade: ";
      resultado += dados["city"] ?? "Não disponível";
      resultado += "\n";
      resultado += "CEP: ";
      resultado += dados["cep"] ?? "Não disponível";
      resultado += "\n";
      resultado += "Latitude/Longitude: ";
      resultado += "${dados["ll"] ?? "Não disponível"}";
    }

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        resultado,
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}