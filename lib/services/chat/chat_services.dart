import 'package:chat_flutter/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Serviço que gerencia o chat entre usuários
/// Inclui envio de mensagens, recebimento de mensagens e listagem de usuários
class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retorna um stream de todos os usuários cadastrados
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data(); // pega os dados de cada usuário
        return user;
      }).toList();
    });
  }

  /// Envia uma mensagem para outro usuário
  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _auth.currentUser!.uid; // ID do remetente
    final String currentUserEmail =
        _auth.currentUser!.email!; // email do remetente
    final Timestamp timestamp = Timestamp.now(); // timestamp atual

    // Cria objeto Message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Gera um ID único para a sala de chat
    // Ordena os IDs para garantir que ambos os usuários compartilhem a mesma sala
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // Salva a mensagem no Firestore
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  /// Retorna um stream das mensagens entre dois usuários
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // Gera o mesmo chatRoomID para ambos os usuários
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // Retorna as mensagens ordenadas pelo timestamp (do mais antigo para o mais novo)
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
