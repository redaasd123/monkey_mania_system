import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/langs_key.dart';
import '../../../../domain/entity/get_all_layers_entity.dart';

class OrderBottomSheet extends StatefulWidget {
  final GetAllLayerEntity item;
  final String imagePath;
  final void Function(
    int quantity,
    String notes,
    GetAllLayerEntity item,
    String imagePath,
  )
  onAdd;

  final int? initialQuantity;
  final String? initialNotes;

  const OrderBottomSheet({
    super.key,
    required this.item,
    required this.imagePath,
    required this.onAdd,
    this.initialQuantity,
    this.initialNotes,
  });

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  late int counter;
  late TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    counter = widget.initialQuantity ?? 1;
    notesController.text = widget.initialNotes ?? '';
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                // Handle
                Container(
                  width: 60,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: Image.asset(
                      widget.imagePath,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  widget.item.product ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoChip(
                      icon: FontAwesomeIcons.tag,
                      text: "${widget.item.price ?? 0} ج.م",
                      colors: [Color(0xFF1B5E20), Color(0xFF1B5E20)],
                    ),
                    _infoChip(
                      icon: FontAwesomeIcons.boxOpen,
                      text: "المتاح: ${widget.item.availableUnits}",
                      colors: [Colors.blue, Color(0xFF004953)],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  LangKeys.quantity.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() => counter++),
                      icon: const Icon(
                        FontAwesomeIcons.plusCircle,
                        color: Colors.greenAccent,
                        size: 34,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Text(
                        '$counter',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (counter > 1) counter--;
                        });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.minusCircle,
                        color: Colors.redAccent,
                        size: 34,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                TextField(
                  controller: notesController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: LangKeys.notes.tr(),
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.noteSticky,
                      color: Colors.amber,
                    ),
                  ),
                  maxLines: 3,
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: const Icon(FontAwesomeIcons.xmark),
                        label: Text(LangKeys.cansel.tr()),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: const Icon(FontAwesomeIcons.cartPlus),
                        label: Text(
                          widget.initialQuantity == null
                              ? LangKeys.save.tr()
                              : LangKeys.edit.tr(),
                        ),
                        onPressed: () {
                          if (counter >= 1) {
                            widget.onAdd(
                              counter,
                              notesController.text,
                              widget.item,
                              widget.imagePath,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String text,
    required List<Color> colors,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
