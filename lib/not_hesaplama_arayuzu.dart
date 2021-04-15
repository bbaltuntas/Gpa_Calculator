import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Ders {
  String _dersAdi;
  int _kredi;
  double _harfNotu;
  Color color;

  Ders(this._dersAdi, this._kredi, this._harfNotu, this.color);
}

class NotHesaplamaArayuzu extends StatefulWidget {
  @override
  _NotHesaplamaArayuzuState createState() => _NotHesaplamaArayuzuState();
}

class _NotHesaplamaArayuzuState extends State<NotHesaplamaArayuzu> {
  String _dersAdi;
  double _dersHarfDegeri = 4;

  int _kredi = 1;
  List<Ders> tumDersler;
  var globalKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;

  @override
  void initState() {
    tumDersler = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (globalKey.currentState.validate()) {
            globalKey.currentState.save();
          }
        },
      ),
      appBar: AppBar(
        title: Text("Ortalama Hesaplama"),
      ),
      body: landscapeUygulamaGovdesi(),
    );
  }

  Widget landscapeUygulamaGovdesi() {
    return Container(
        child: Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            )),
                            labelText: "Ders Adı",
                            hintText: "Ders Adını Giriniz",
                            border: OutlineInputBorder(),
                          ),
                          validator: (girilenDeger) {
                            if (girilenDeger.length > 0) {
                              return null;
                            } else {
                              return "Bir Ders Giriniz ";
                            }
                          },
                          onSaved: (deger) {
                            setState(() {
                              _dersAdi = deger;
                              tumDersler.add(Ders(_dersAdi, _kredi,
                                  _dersHarfDegeri, rastgeleRenkOlustur()));
                            });
                            ortalamayiHesapla();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: dersKredileriItems(),
                                  value: _kredi,
                                  onChanged: (value) {
                                    setState(() {
                                      _kredi = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: dersHarfDegerleriItems(),
                                  value: _dersHarfDegeri,
                                  onChanged: (value) {
                                    setState(() {
                                      _dersHarfDegeri = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //  color: Colors.blue,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? "Lütfen Ders Ekleyin"
                                  : "Ortalama : ",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: tumDersler.length == 0
                                  ? ""
                                  : "${ortalama.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold)),
                        ])),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 10,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: ListView.builder(
            itemBuilder: _listElemanlariniOlustur,
            itemCount: tumDersler.length,
          ),
        )),
      ],
    ));
  }

  Widget portraitUygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Statik Formu tutan container
          Container(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: globalKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      )),
                      labelText: "Ders Adı",
                      hintText: "Ders Adını Giriniz",
                      border: OutlineInputBorder(),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else {
                        return "Bir Ders Giriniz ";
                      }
                    },
                    onSaved: (deger) {
                      setState(() {
                        _dersAdi = deger;
                        tumDersler.add(Ders(_dersAdi, _kredi, _dersHarfDegeri,
                            rastgeleRenkOlustur()));
                      });
                      ortalamayiHesapla();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileriItems(),
                            value: _kredi,
                            onChanged: (value) {
                              setState(() {
                                _kredi = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: _dersHarfDegeri,
                            onChanged: (value) {
                              setState(() {
                                _dersHarfDegeri = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //  color: Colors.blue,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: tumDersler.length == 0
                            ? "Lütfen Ders Ekleyin"
                            : "Ortalama : ",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: tumDersler.length == 0
                            ? ""
                            : "${ortalama.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                  ])),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10,
          ),
          // dinamik listeyi tutan container
          Expanded(
              child: Container(
            child: ListView.builder(
              itemBuilder: _listElemanlariniOlustur,
              itemCount: tumDersler.length,
            ),
          )),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> kredilerList = [];
    for (int i = 1; i <= 10; i++) {
      kredilerList.add(DropdownMenuItem(
        child: Text("$i kredi"),
        value: i,
      ));
    }

    return kredilerList;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> dersHarfleri = [];
    dersHarfleri.add(DropdownMenuItem(
        value: 4,
        child: Text(
          "AA",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 3.5,
        child: Text(
          "BA",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 3,
        child: Text(
          "BB",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 2.5,
        child: Text(
          "CB",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 2,
        child: Text(
          "CC",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 1.5,
        child: Text(
          "DC",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 1,
        child: Text(
          "DD",
          style: TextStyle(fontSize: 20),
        )));
    dersHarfleri.add(DropdownMenuItem(
        value: 0,
        child: Text(
          "FF",
          style: TextStyle(fontSize: 20),
        )));

    return dersHarfleri;
  }

  Widget _listElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      direction: DismissDirection.startToEnd,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(color: tumDersler[index].color)),
          child: ListTile(
            title: Text(tumDersler[index]._dersAdi),
            subtitle: Text(tumDersler[index]._kredi.toString() +
                " kredi Harf Notu ${tumDersler[index]._harfNotu}"),
          ),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    int toplamKredi = 0;

    for (var oankiDers in tumDersler) {
      var kredi = oankiDers._kredi;
      var harfNotu = oankiDers._harfNotu;

      toplamNot += harfNotu * kredi;
      toplamKredi += kredi;
    }

    ortalama = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {
    Random random = new Random();

    return Color.fromARGB(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }
}
