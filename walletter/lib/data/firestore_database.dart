import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:walletter/model/transactionModel.dart';

class FirestoreRemoteServer {
  static String uid;

  ///
  /// Criando Singlton
  ///
  static FirestoreRemoteServer helper = FirestoreRemoteServer._createInstance();

  FirestoreRemoteServer._createInstance();

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("transactions");

  /// Metodos dados usuario
  includeUserData(
    String uid,
    String fullName,
    String email,
    var dependents,
    var creditCard,
    var idade,
    var rendaMensal,
    var hasCasa,
    var hasCarro,
    var hasMoto,
    var hasBicicleta,
  ) async {
    await transactionCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "idade": idade,
      "rendaMensal": rendaMensal,
      "dependents": dependents,
      "creditCard": creditCard,
      "has_Casa": hasCasa,
      "has_Carro": hasCarro,
      "has_Moto": hasMoto,
      "has_Bicicleta": hasBicicleta,
    });
  }

  Future<double> getCurrentMoney() async {
    QuerySnapshot snapshots = await transactionCollection
        .doc(uid)
        .collection("my_transactions")
        .get();

    double total = 0.0;

    for (var doc in snapshots.docs) {
      TransactionForm transaction = TransactionForm.fromMap(doc.data());

      if (transaction.category == "income") {
        total += double.tryParse(transaction.value);
      } else {
        total -= double.tryParse(transaction.value);
      }
    }
    return total;
  }

  // GET INFORMATIONS LIST
  Future<DocumentSnapshot> getUserInformation() async {
    DocumentSnapshot document = await transactionCollection.doc(uid).get();
    return document;
  }

  // Mapeia os snapshots (documents) em um map
  List _transactionListFromSnapshot(QuerySnapshot snapshots) {
    List<TransactionForm> transactionList = [];
    List<String> idList = [];

    for (var doc in snapshots.docs) {
      TransactionForm transaction = TransactionForm.fromMap(doc.data());
      transactionList.add(transaction);
      idList.add(doc.id);
    }

    return [transactionList, idList];
  }

  // GET TRANSACTION LIST
  Future<List<dynamic>> getTransactionList() async {
    QuerySnapshot snapshot = await transactionCollection
        .doc(uid)
        .collection("my_transactions")
        .orderBy("date", descending: true)
        .get();

    // Invocar método auxilar
    return _transactionListFromSnapshot(snapshot);
  }

  // INSERT TRANSACTION
  Future<void> insertTransaction(TransactionForm transaction) async {
    // .add() -> cria o hash_ID automaticamente
    await transactionCollection.doc(uid).collection("my_transactions").add({
      "value": transaction.value,
      "date": transaction.date,
      "description": transaction.description,
      "category": transaction.category,
    });
  }

  // UPDATE TRANSACTION
  Future<void> updateTransaction(
      String transactionId, TransactionForm transaction) async {
    await transactionCollection
        .doc(uid)
        .collection("my_transactions")
        .doc("$transactionId")
        .update(
      {
        "value": transaction.value,
        "date": transaction.date,
        "description": transaction.description,
        "category": transaction.category,
      },
    );
  }

  // DELETE TRANSACTION
  Future<void> deleteTransaction(String transactionId) async {
    await transactionCollection
        .doc(uid)
        .collection("my_transactions")
        .doc("$transactionId")
        .delete();
  }

  ///
  /// STREAM
  ///
  Stream get stream {
    // Snapshots -> conjuntos de ducomentos
    return transactionCollection
        .doc(uid)
        .collection("my_transactions")
        .snapshots()
        .map(_transactionListFromSnapshot);
  }
}
