import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_frist_dapp/utils/globalWidgets.dart';

class ApiConectionProvider extends ChangeNotifier {
  //testNet Info
  final apiUrl = 'https://api-ropsten.etherscan.io';
  final apiKey = 'BEM5BEN6QPNU1BNJZWN7C5JF657NKZ9E6S';

  //Real Info
  // final apiUrl = '';
  // final apiKey = '';

  String currentContranct = '0x6bD86961A80ac6d1D081b66CCAdEE5eb37cf6D61';

  get hasContract => currentContranct != null;

  Future<Map<String, dynamic>> getAbi() async {
    if (hasContract) {
      const action = 'getabi';
      final extencion =
          '/api?module=contract&action=$action&address=$currentContranct&apikey=$apiKey';

      final response = await _getMethod(apiUrl + extencion);

      if (response['status'] == '1') {
        return {
          "status": "1",
          "abi": response['result'],
          "mesage": "No se pudo obtener el abi con exito"
        };
      } else {
        floadMessage(mensaje: "No se pudo obtener el abi con exito");
        return {"status": "2", "mesage": "No se pudo obtener el abi con exito"};
      }
    }
  }

  dynamic _getMethod(url) async {
    try {
      dynamic resp = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      Map<dynamic, dynamic> decodeResp = json.decode(resp.body);

      return decodeResp;
    } catch (e) {
      floadMessage(mensaje: "Error al hacer la peticion");
      // Navigator.pop(context);
      return {"error": "$e"};
    }
  }
}
