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
    var has_Casa,
    var has_Carro,
    var has_Moto,
    var has_Bicicleta,
  ) async {
    await transactionCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "idade": idade,
      "rendaMensal": rendaMensal,
      "dependents": dependents,
      "creditCard": creditCard,
      "has_Casa": has_Casa,
      "has_Carro": has_Carro,
      "has_Moto": has_Moto,
      "has_Bicicleta": has_Bicicleta,
    });
  }

  // GET INFORMATIONS LIST
  getUserInformation() async {
    List<dynamic> userInfos = [];
    DocumentSnapshot snapshot = await transactionCollection.doc(uid).get();
    var data = snapshot.data();

    for (var item in data) {
      userInfos.add(item);
      print(item);
    }

    return userInfos;
  }

  // Mapeia os snapshots (documents) em um map
  List _transactionListFromSnapshot(QuerySnapshot snapshots) {
    List<TransactionForm> transactionList = [];
    List<String> idList = [];
    var total = 0.0;

    for (var doc in snapshots.docs) {
      TransactionForm transaction = TransactionForm.fromMap(doc.data());
      if (transaction.category == "income") {
        total += double.tryParse(transaction.value);
      } else {
        total -= double.tryParse(transaction.value);
      }
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

  // UPDATE NOTE
  // Future<void> updateNote(String noteId, TransactionForm transaction) async {
  //   await transactionCollection
  //       .doc(uid)
  //       .collection("my_transactions")
  //       .doc("$noteId")
  //       .update({"title": note.title, "description": note.description});
  // }

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
