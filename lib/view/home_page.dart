import 'package:apk_investimento/view/por_extenso_page.dart';
import 'package:apk_investimento/view/busca_cep_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/logo.jpg',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.edit,
                color: Colors.white, size: 50.0),
                SizedBox(width: 30),
                Text("Por Extenso",
                style: TextStyle(
                  color: Colors.white, fontSize: 20.0),)
              ],
            ),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: ((context) => PorExtenso())
              ));
            },
          ),

           GestureDetector(
            child: Row(
              children: [
                Icon(Icons.home,
                color: Colors.white, size: 50.0),
                SizedBox(width: 30),
                Text("Busca CEP",
                style: TextStyle(
                  color: Colors.white, fontSize: 20.0),)
              ],
            ),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: ((context) => BuscaCep())
              ));
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.edit,
                color: Colors.white, size: 50.0),
                SizedBox(width: 30),
                Text("CNPJ",
                style: TextStyle(
                  color: Colors.white, fontSize: 20.0),)
              ],
            ),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: ((context) => PorExtenso())
              ));
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.edit,
                color: Colors.white, size: 50.0),
                SizedBox(width: 30),
                Text("GEOIP",
                style: TextStyle(
                  color: Colors.white, fontSize: 20.0),)
              ],
            ),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: ((context) => PorExtenso())
              ));
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.edit,
                color: Colors.white, size: 50.0),
                SizedBox(width: 30),
                Text("Validação de E-mail",
                style: TextStyle(
                  color: Colors.white, fontSize: 20.0),)
              ],
            ),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: ((context) => PorExtenso())
              ));
            },
          ),
        ]),
      ),
    );
  }
} 