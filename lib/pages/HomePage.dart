import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:my_frist_dapp/utils/ApiConectionProvider.dart';
import 'package:my_frist_dapp/utils/globalWidgets.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiConectionProvider apiConectionProvider;

  Client httpClient;
  Web3Client web3Client;
  String texto;
  String textDescentralizado = "Vacio";

  var myAddress = "0x486eaF674c195C7e9d509876B99a639e2B556a9c";
  var urlInfura =
      "https://ropsten.infura.io/v3/eb2ccf22b9b44488aded42d52a59a1ca";

  var privateKey =
      "6ca596b6be8b2f2876e1ee61ca64b4a2034170d9a164e5548a8676734b9865b4";
  var chainId = 3;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    web3Client = Web3Client(urlInfura, httpClient);
    getTexto(myAddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "0x6bD86961A80ac6d1D081b66CCAdEE5eb37cf6D61";

    var contract = DeployedContract(ContractAbi.fromJson(abi, "Escribir"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> query(String funtionName, List<dynamic> agrs) async {
    var contract = await loadContract();
    var ethFunction = contract.function(funtionName);
    var result = await web3Client.call(
        contract: contract, function: ethFunction, params: agrs);

    return result;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    var contract = await loadContract();
    var ethFunction = contract.function(functionName);

    var result = await web3Client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: chainId,
        fetchChainIdFromNetworkId: true);

    return result;
  }

  Future<void> getTexto(String targetAddress) async {
    textDescentralizado = null;
    setState(() {});
    EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query('getTexto', []);
    textDescentralizado = result[0];
    // print(result[0]);
    setState(() {});
  }

  Future<void> setTexto(String texto) async {
    textDescentralizado = null;
    setState(() {});

    await submit("setTexto", [texto]);

    textDescentralizado = " - Pulsa Refrehs";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    apiConectionProvider = Provider.of<ApiConectionProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const Text(
            'DAPP',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textDescentralizado != null
                  ? SelectableText("Texto Descentralizado: " +
                      textDescentralizado.toString())
                  : Stack(
                      children: [
                        Image.asset(
                          'assets/loading.gif',
                          width: 120,
                          filterQuality: FilterQuality.high,
                          repeat: ImageRepeat.noRepeat,
                        ),
                        Image.asset(
                          'assets/loading.gif',
                          width: 120,
                          filterQuality: FilterQuality.high,
                          color: Color.fromRGBO(255, 194, 5, .7),
                          repeat: ImageRepeat.noRepeat,
                        ),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: TextFormField(
                  onChanged: (value) {
                    texto = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.amber,
                        child: FlatButton(
                            onPressed: () async {
                              await setTexto(texto);
                              setState(() {});
                            },
                            child: const Text("Set Valor")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.amber,
                        child: FlatButton(
                            onPressed: () {
                              getTexto(myAddress);
                              // setState(() {});
                            },
                            child: const Text("Refrehs")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.amber,
                        child: FlatButton(
                            onPressed: () {
                              floadMessage(
                                  mensaje:jsonEncode(apiConectionProvider.getAbi()));
                            },
                            child: const Text("Get Abi Actual")),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
