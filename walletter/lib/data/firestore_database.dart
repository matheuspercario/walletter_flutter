import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:walletter/model/transactionModel.dart';

class FirestoreRemoteServer {
  static String uid;

  ///
  ///Criando Singlton
  ///
  static FirestoreRemoteServer helper = FirestoreRemoteServer._createInstance();
  FirestoreRemoteServer._createInstance();

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("transactions");

  /// Metodo inserir dados usuario
  // includeUserData(String uid, String email, int idade, int ra) async {
  //   await transactionCollection.doc(uid).set({
  //     "email": email,
  //     "idade": idade,
  //     "ra": ra,
  //   });
  // }

  // Mapeia os snapshots (documents) em um map
  List _transactionListFromSnapshot(QuerySnapshot snapshots) {
    List<TransactionForm> transactionList = [];
    List<String> idList = [];

    for (var doc in snapshots.docs) {
      TransactionForm transaction = TransactionForm.fromMap(doc.data());
      //transaction.dataLocation = 3;
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
