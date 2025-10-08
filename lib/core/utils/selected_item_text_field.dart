import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'langs_key.dart';

class SelectItemTextField<T> extends StatefulWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;
  final String label;
  final Future<List<T>> Function() fetchItems;
  final String Function(T) itemTitle;
  final IconData Function(T)? itemIcon;
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
      validator: (val) {
        if (val == null || val.trim().isEmpty)
          return LangKeys.nameRequired.tr();
      },
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
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) {
              final searchCtrl = TextEditingController();
              double maxHeight = MediaQuery.of(context).size.height * 0.8;

              return StatefulBuilder(
                builder: (context, setState) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.4,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (context, scrollSheetController) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF004953), Color(0xFF004953)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                          ),
                          child: SingleChildScrollView(
                            controller: scrollSheetController,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 50,
                                  height: 5,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Text(
                                  "اختر ${widget.label}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: searchCtrl,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: LangKeys.search.tr(),
                                    hintStyle:
                                    const TextStyle(color: Colors.white70),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.white70,
                                    ),
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
                                          .where(
                                            (e) => widget
                                            .itemTitle(e)
                                            .toLowerCase()
                                            .contains(query.toLowerCase()),
                                      )
                                          .toList();
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filtered.length,
                                  itemBuilder: (context, index) {
                                    final item = filtered[index];
                                    final isSelected = selectedItems.contains(item);
                                    final icon =
                                        widget.itemIcon?.call(item) ?? Icons.check;

                                    return Card(
                                      elevation: 6,
                                      shadowColor: Colors.black26,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(12),
                                        leading: CircleAvatar(
                                          backgroundColor: isSelected
                                              ? Colors.green
                                              : Colors.grey[400],
                                          child: Icon(icon, color: Colors.white),
                                        ),
                                        title: Text(
                                          widget.itemTitle(item),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: widget.multiSelect
                                            ? Icon(
                                          isSelected
                                              ? Icons.check_circle
                                              : Icons.circle_outlined,
                                          color: isSelected
                                              ? Colors.green
                                              : Colors.grey,
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
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 14),
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
                                      } else if (selectedItems.isNotEmpty) {
                                        Navigator.pop(context, selectedItems.first);
                                      }
                                    },
                                    child: Text(
                                      LangKeys.save.tr(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );

          if (selected != null) {
            if (widget.multiSelect) {
              widget.controller.text = (selected as List<T>)
                  .map((e) => widget.itemTitle(e))
                  .join(", ");
            } else {
              widget.controller.text = widget.itemTitle(selected as T);
            }
            widget.onSelected(selected);
          }
        }

    );
  }
}
