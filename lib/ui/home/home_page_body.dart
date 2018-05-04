import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';


import 'package:cryptoshadow/model/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:cryptoshadow/ui/detai/crypto_summary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cryptoshadow/theme.dart' as Theme;

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List data;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.Colors2.appBarGradientStart,
                  Theme.Colors2.appBarGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ),
          ),
          child: RefreshIndicator(
            onRefresh: refresh,//这里的返回类型是Future<Null>
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              slivers: <Widget>[
                new SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                          CryptoSummary(crypto: getCoin(index),),
                      childCount: data == null ? 100 : data.length,
                    ),
                  ),),

              ],
            ),
          ),

        ));
  }

  Future<Null> refresh() async {
    await getDataFromAPI();
  }

  Future<bool> getDataFromAPI() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://api.coinmarketcap.com/v1/ticker/?convert=" + "EUR" +
                "&limit=100"),
        headers: {
          "Accept": "application/json"
        }
    );
    setState(() {
      data = json.decode(response.body);
      isLoading = false;
    });
    String content = response.body;
    (await getLocalFile()).writeAsString('$content');
    return true;
  }

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/coin_list.txt');
  }

  void loadData() async {
    await getDataFromAPI();
    await getData();
  }

  Future<bool> getData() async {
    if (!(await getDataFromLocal())) {
      await getDataFromAPI();
    }
    return true;
  }

  Future<bool> getDataFromLocal() async {
    try {
      File file = await getLocalFile();
      String content = await file.readAsString();
      setState(() {
        data = json.decode(content);
        isLoading = false;
      });
      return true;
    } on FileSystemException {
      return false;
    }
  }

  Crypto getCoin(int index) {
    return new Crypto(
      data[index]["id"],
      data[index]["name"],
      data[index]["symbol"],
      data[index]["rank"],
      data[index]["price_usd"],
      data[index]["price_btc"],
      data[index]["24h_volume_usd"],
      data[index]["market_cap_usd"],
      data[index]["available_supply"],
      data[index]["total_supply"],
      data[index]["percent_change_1h"],
      data[index]["percent_change_24h"],
      data[index]["percent_change_7d"],
      data[index]["last_updated"],
      data[index]["price_eur"],
      data[index]["24h_volume_eur"],
      data[index]["market_cap_eur"],
    );
  }
}
































