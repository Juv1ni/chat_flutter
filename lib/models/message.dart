import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o Timestamp do Firestore

// Classe que representa uma mensagem no chat
class Message {
  final String senderID; // ID do usuário que enviou a mensagem
  final String senderEmail; // E-mail do remetente
  final String receiverID; // ID do usuário que vai receber a mensagem
  final String message; // Texto da mensagem
  final Timestamp
  timestamp; // Data e hora em que a mensagem foi enviada (Firestore)

  // Construtor da classe
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // Converte o objeto Message em um Map<String, dynamic>
  // -> usado para salvar a mensagem no Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
