import 'package:chat_flutter/components/chat_bubble.dart'; // Componente da bolha de mensagens
import 'package:chat_flutter/components/my_textfield.dart'; // Campo de texto customizado
import 'package:chat_flutter/services/auth/auth_service.dart'; // Serviço de autenticação (usuário logado)
import 'package:chat_flutter/services/chat/chat_services.dart'; // Serviço responsável por enviar/receber mensagens
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore (armazenamento das mensagens)
import 'package:flutter/material.dart'; // Biblioteca principal do Flutter

// Página de chat entre usuário atual e outro usuário
class ChatPage extends StatefulWidget {
  final String receiverEmail; // E-mail do destinatário
  final String receiverID; // ID do destinatário no Firestore

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController =
      TextEditingController(); // Controla o texto digitado
  final ChatServices _chatService = ChatServices(); // Serviço de chat
  final AuthService _authService = AuthService(); // Serviço de autenticação
  final ScrollController _scrollController =
      ScrollController(); // Controla rolagem da lista

  FocusNode myFocusNode = FocusNode(); // Detecta foco no campo de texto

  @override
  void initState() {
    super.initState();

    // Quando o campo de texto ganhar foco, rola a lista para baixo (última msg)
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    // Quando abrir a tela, já rola pro final da lista
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose(); // Libera recurso do foco
    _messageController.dispose(); // Libera recurso do controller de texto
    super.dispose();
  }

  // Função para rolar a lista até a última mensagem
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Vai pro final da lista
      duration: const Duration(seconds: 1), // Tempo da animação
      curve: Curves.fastOutSlowIn, // Curva da animação
    );
  }

  // Função para enviar mensagem
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // Usa o ChatService para enviar a mensagem
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );

      _messageController.clear(); // Limpa o campo de texto
    }
    scrollDown(); // Sempre desce após enviar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.receiverEmail), // Mostra o email do contato
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()), // Lista de mensagens
          _buildUserInput(), // Campo de digitação
        ],
      ),
    );
  }

  // Constrói a lista de mensagens em tempo real
  Widget _buildMessageList() {
    String senderID = _authService
        .getCurrentUser()!
        .uid; // ID do usuário logado

    return StreamBuilder(
      stream: _chatService.getMessages(
        senderID,
        widget.receiverID,
      ), // Stream de mensagens
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro"); // Se der erro no stream
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando..."); // Enquanto carrega
        }
        // Monta a lista de mensagens com base nos documentos do Firestore
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc)) // Constrói cada mensagem
              .toList(),
        );
      },
    );
  }

  // Constrói uma bolha de mensagem (ChatBubble)
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Verifica se a mensagem foi enviada pelo usuário atual
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    return Column(
      crossAxisAlignment: isCurrentUser
          ? CrossAxisAlignment
                .end // Mensagem do usuário → direita
          : CrossAxisAlignment.start, // Mensagem do outro → esquerda
      children: [
        ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
      ],
    );
  }

  // Constrói o campo de input do usuário (digitar mensagem + botão enviar)
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // Campo de digitação
          Expanded(
            child: MyTextField(
              hintText: "Digite uma mensagem",
              obscureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          // Botão de enviar
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: sendMessage, // Chama função de enviar
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
