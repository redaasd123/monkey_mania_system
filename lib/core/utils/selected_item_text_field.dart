import 'package:flutter/material.dart';

class SelectItemTextField<T> extends StatefulWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String label;
  final Future<List<T>> Function() fetchItems;
  final String Function(T) itemTitle;
  final IconData Function(T)? itemIcon; // أيقونة لكل عنصر
  final void Function(dynamic) onSelected;
  final bool multiSelect;

  const SelectItemTextField({
    super.key,
    required this.controller,
    required this.colorScheme,
    required this.label,
    required this.fetchItems,
    required this.itemTitle,
    required this.onSelected,
    this.itemIcon,
    this.multiSelect = false,
  });

  @override
  State<SelectItemTextField<T>> createState() => _SelectItemTextFieldState<T>();
}

class _SelectItemTextFieldState<T> extends State<SelectItemTextField<T>> {
  bool hasFetched = false;
  List<T> items = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      maxLines: 1,
      style: TextStyle(color: widget.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: widget.colorScheme.onSurface),
        prefixIcon: Icon(Icons.school, color: widget.colorScheme.onSurface),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
        ),
      ),
      onTap: () async {
        if (!hasFetched) {
          items = await widget.fetchItems();
          hasFetched = true;
        }

        final scrollController = ScrollController();
        List<T> filtered = List.from(items);
        List<T> selectedItems = [];

        final selected = await showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) {
            final searchCtrl = TextEditingController();

            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5A55CA), Color(0xFF9D84FF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // 🔘 Drag Handle
                      Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // 📝 العنوان
                      Text(
                        "اختر ${widget.label}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 🔍 البحث
                      TextField(
                        controller: searchCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "ابحث...",
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(Icons.search, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            filtered = items
                                .where((e) => widget.itemTitle(e)
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // 📋 القائمة
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            final isSelected = selectedItems.contains(item);
                            final icon = widget.itemIcon?.call(item) ?? Icons.check;

                            return Card(
                              elevation: 6,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: CircleAvatar(
                                  backgroundColor: isSelected
                                      ? Colors.green
                                      : Colors.purple.shade200,
                                  child: Icon(icon, color: Colors.white),
                                ),
                                title: Text(
                                  widget.itemTitle(item),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                trailing: widget.multiSelect
                                    ? Icon(
                                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                                  color: isSelected ? Colors.green : Colors.grey,
                                )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    if (widget.multiSelect) {
                                      if (isSelected) {
                                        selectedItems.remove(item);
                                      } else {
                                        selectedItems.add(item);
                                      }
                                    } else {
                                      selectedItems = [item];
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      // ✅ زر التأكيد
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 8,
                          ),
                          onPressed: () {
                            if (widget.multiSelect) {
                              Navigator.pop(context, selectedItems);
                            } else {
                              Navigator.pop(context, selectedItems.first);
                            }
                          },
                          child: const Text(
                            'تأكيد الاختيار',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );

        // بعد الاختيار
        if (selected != null) {
          if (widget.multiSelect) {
            widget.controller.text =
                (selected as List<T>).map((e) => widget.itemTitle(e)).join(", ");
          } else {
            widget.controller.text = widget.itemTitle(selected as T);
          }
          widget.onSelected(selected);
        }
      },
    );
  }
}
