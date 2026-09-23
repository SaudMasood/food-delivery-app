import 'package:flutter/material.dart';

class DeliveryManMessagePage
    extends StatefulWidget {
  const DeliveryManMessagePage({
    super.key,
  });

  @override
  State<DeliveryManMessagePage>
  createState() =>
      _DeliveryManMessagePageState();
}

class _DeliveryManMessagePageState
    extends State<
        DeliveryManMessagePage> {
  final controller =
  TextEditingController();

  final List<String> messages = [
    'Hey, Congratulations for order',
    "I'm Coming, just wait ...",
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
            decoration:
            BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context),

                Expanded(
                  child: ListView.builder(
                    padding:
                    const EdgeInsets
                        .fromLTRB(
                      12,
                      20,
                      12,
                      10,
                    ),
                    itemCount:
                    messages.length,
                    itemBuilder:
                        (context, index) {
                      return _message(
                        messages[index],
                        index.isEven,
                      );
                    },
                  ),
                ),

                _buildInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context,
      ) {
    return Padding(
      padding:
      const EdgeInsets.all(12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 25,
              height: 25,
              decoration:
              const BoxDecoration(
                color:
                Color(0xFFF0F3F6),
                shape:
                BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Robert Fox',
            style: TextStyle(
              fontSize: 8,
              fontWeight:
              FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _message(
      String text,
      bool mine,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 18,
      ),
      child: Row(
        mainAxisAlignment: mine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!mine)
            Container(
              width: 20,
              height: 20,
              margin:
              const EdgeInsets.only(
                right: 7,
              ),
              decoration:
              const BoxDecoration(
                color:
                Color(0xFF9BAFC0),
                shape:
                BoxShape.circle,
              ),
            ),
          Container(
            constraints:
            const BoxConstraints(
              maxWidth: 145,
            ),
            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration:
            BoxDecoration(
              color: mine
                  ? const Color(
                0xFFFF7622,
              )
                  : const Color(
                0xFFF0F4F8,
              ),
              borderRadius:
              BorderRadius.circular(
                6,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: mine
                    ? Colors.white
                    : const Color(
                  0xFF555555,
                ),
                fontSize: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      margin:
      const EdgeInsets.all(10),
      height: 35,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration:
      BoxDecoration(
        color:
        const Color(0xFFF0F4F8),
        borderRadius:
        BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_emotions_outlined,
            size: 13,
            color:
            Color(0xFF9BA5BC),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontSize: 8,
              ),
              decoration:
              const InputDecoration(
                hintText:
                'Write something',
                hintStyle:
                TextStyle(
                  fontSize: 8,
                  color:
                  Color(0xFF9BA5BC),
                ),
                border:
                InputBorder.none,
              ),
            ),
          ),
          const Icon(
            Icons.send,
            size: 14,
            color:
            Color(0xFFFF7622),
          ),
        ],
      ),
    );
  }
}