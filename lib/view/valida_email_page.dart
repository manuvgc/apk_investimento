import 'package:apk_investimento/service/invertexto_service.dart';
import 'package:flutter/material.dart';

class ValidaEmail extends StatefulWidget {
  const ValidaEmail({super.key});
  @override
  _ValidaEmail createState() => _ValidaEmail();
}

class _ValidaEmail extends State<ValidaEmail> {
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
                labelText: "Digite o email",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            if (campo != null)
              FutureBuilder(
                future: apiService.validaEmail(campo!),
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
                            'Erro ao validar email.',
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
      final bool valido = dados["valid"] ?? false;
      final bool mx = dados["mx"] ?? false;
      final bool descartavel = dados["disposable"] ?? false;

      resultado += "Email válido: ";
      resultado += valido ? "Sim" : "Não";
      resultado += "\n";
      resultado += "Possui registro MX: ";
      resultado += mx ? "Sim" : "Não";
      resultado += "\n";
      resultado += "Email descartável (temporário): ";
      resultado += descartavel ? "Sim" : "Não";
      resultado += "\n";
      resultado += "Domínio: ";
      resultado += dados["domain"] ?? "Não disponível";
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