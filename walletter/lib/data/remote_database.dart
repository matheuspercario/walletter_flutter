import 'dart:async';
import 'dart:convert';

import 'package:walletter/model/transactionModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart';

class DatabaseRemoteServer {
  /*
   * Criando Singleton
   */
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();

  DatabaseRemoteServer._createInstance();

  // String databaseUrl = "http://192.168.1.6:3000/transactions/";
  String databaseUrl =
      "https://walletter-nodejs-server.herokuapp.com/transactions/";

  Dio _dio = Dio();

  // GET TRANSACTIONS LIST
  Future<List<dynamic>> getTransactionList() async {
    Response response = await _dio.request(
      this.databaseUrl,
      options: Options(
        method: "GET",
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    List<TransactionForm> transactionList = [];
    List<int> idList = [];

    response.data.forEach(
      (element) {
        //element["dataLocation"] = 2;
        TransactionForm transaction = TransactionForm.fromMap(element);
        transactionList.add(transaction);
        idList.add(element["id"]);
      },
    );

    return [transactionList, idList];
  }

  // INSERT TRANSACTION
  Future<int> insertTransaction(TransactionForm transaction) async {
    await _dio.post(
      this.databaseUrl,
      options: Options(
        headers: {"Accept": "application/json"},
      ),
      data: jsonEncode(
        {
          "value": transaction.value,
          "date": transaction.date,
          "description": transaction.description,
          "category": transaction.category,
        },
      ),
    );
    return 1;
  }

  // DELETE TRANSACTION
  Future<int> deleteTransaction(int transactionId) async {
    await _dio.delete(
      this.databaseUrl + "$transactionId",
      options: Options(
        method: "GET",
        headers: {
          "Accept": "application/json",
        },
      ),
    );
    return 1;
  }

  /*
   * STREAM -> Notifica quem quiser ouvir
   */

  notify() async {
    if (_controller != null) {
      var response = await getTransactionList();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();

      Socket socket = io(
        'https://walletter-nodejs-server.herokuapp.com/',
        OptionBuilder().setTransports(['websocket']).build(),
      );
      socket.on('invalidate', (_) => notify());
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}

void main() async {
  // DatabaseRemoteServer transactionService = DatabaseRemoteServer.helper;

  // TransactionForm transaction = TransactionForm();
  // transaction.value = "R\$ 9999.99";
  // transaction.date = "99/99/9999";
  // transaction.description = "Teste via linha de comando";
  // transaction.category = "income";

  //transactionService.insertTransaction(transaction);
  //transactionService.deleteTransaction(3);
}
