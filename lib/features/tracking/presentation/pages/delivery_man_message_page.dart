import 'package:flutter/material.dart';

class DeliveryManMessagePage extends StatefulWidget {
  const DeliveryManMessagePage({super.key});

  @override
  State<DeliveryManMessagePage> createState() =>
      _DeliveryManMessagePageState();
}

class _DeliveryManMessagePageState
    extends State<DeliveryManMessagePage> {
  final TextEditingController controller =
  TextEditingController();

  final List<Message> messages = [
    Message(
      text: 'Are you coming?',
      isMine: true,
      time: '8:10 pm',
    ),
    Message(
      text: 'Hey, Congratulations for order',
      isMine: false,
      time: '8:11 pm',
    ),
    Message(
      text: 'Hey Where are you now?',
      isMine: true,
      time: '8:11 pm',
    ),
    Message(
      text: "I'm Coming, just wait ...",
      isMine: false,
      time: '8:12 pm',
    ),
    Message(
      text: 'Hurry Up, Man',
      isMine: true,
      time: '8:12 pm',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      messages.add(
        Message(
          text: text,
          isMine: true,
          time: _getTime(),
        ),
      );

      controller.clear();
    });
  }

  String _getTime() {
    final now = DateTime.now();

    final hour = now.hour > 12
        ? now.hour - 12
        : now.hour == 0
        ? 12
        : now.hour;

    final minute =
    now.minute.toString().padLeft(2, '0');

    final period =
    now.hour >= 12 ? 'pm' : 'am';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _buildMessages(),
              ),
              _buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F3F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 19,
                color: Color(0xFF20242F),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Robert Fox',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF20242F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        12,
      ),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessage(
          messages[index],
        );
      },
    );
  }

  Widget _buildMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment: message.isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: message.isMine ? 0 : 42,
              right: message.isMine ? 42 : 0,
            ),
            child: Text(
              message.time,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF9BA5BC),
              ),
            ),
          ),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: message.isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMine)
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(
                    right: 9,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF9BAFC0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white,
                  ),
                ),

              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 245,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: message.isMine
                        ? const Color(0xFFFF7622)
                        : const Color(0xFFF0F4F8),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMine
                          ? Colors.white
                          : const Color(0xFF555555),
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              if (message.isMine)
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(
                    left: 9,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC5B0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      margin: const EdgeInsets.all(14),
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_emotions_outlined,
            size: 22,
            color: Color(0xFF9BA5BC),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) {
                _sendMessage();
              },
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF20242F),
              ),
              decoration: const InputDecoration(
                hintText: 'Write something',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9BA5BC),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                size: 18,
                color: Color(0xFFFF7622),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMine;
  final String time;

  const Message({
    required this.text,
    required this.isMine,
    required this.time,
  });
}