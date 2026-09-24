import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/address.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() =>
      _AddAddressPageState();
}

class _AddAddressPageState
    extends State<AddAddressPage> {
  final addressController = TextEditingController();
  final streetController = TextEditingController();
  final postCodeController = TextEditingController();
  final apartmentController = TextEditingController();

  String selectedLabel = 'HOME';

  @override
  void dispose() {
    addressController.dispose();
    streetController.dispose();
    postCodeController.dispose();
    apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildMapHeader(context),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        _field(
                          'ADDRESS',
                          addressController,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _field(
                                'STREET',
                                streetController,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _field(
                                'POST CODE',
                                postCodeController,
                              ),
                            ),
                          ],
                        ),

                        _field(
                          'APARTMENT',
                          apartmentController,
                        ),

                        const Text(
                          'LABEL AS',
                          style: TextStyle(
                            fontSize: 6,
                            color: Color(0xFF555B68),
                          ),
                        ),

                        const SizedBox(height: 7),

                        Row(
                          children: [
                            _labelButton('HOME'),
                            _labelButton('WORK'),
                            _labelButton('OTHER'),
                          ],
                        ),

                        const SizedBox(height: 25),

                        _saveButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapHeader(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFD5DEE6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            color: Color(0xFF29293B),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 9,
          ),
        ),
      ),
    );
  }

  Widget _field(
      String title,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 6,
              color: Color(0xFF555B68),
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            style: const TextStyle(fontSize: 8),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0F4F8),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelButton(String label) {
    final selected = selectedLabel == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF7622)
              : const Color(0xFFF0F4F8),
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? Colors.white
                : const Color(0xFF555B68),
            fontSize: 7,
          ),
        ),
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          final address = Address(
            id: DateTime.now()
                .millisecondsSinceEpoch,
            label: selectedLabel,
            address:
            addressController.text.trim(),
            street: streetController.text.trim(),
            postCode:
            postCodeController.text.trim(),
            apartment:
            apartmentController.text.trim(),
          );

          context.read<ProfileBloc>().add(
            AddAddressEvent(address),
          );

          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7622),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(7),
          ),
        ),
        child: const Text(
          'SAVE LOCATION',
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}