import 'package:flutter/material.dart';

Widget buildSelectableExpansionTile<T>({
  required String label,
  required TextEditingController controller,
  required bool isLoading,
  required List<T> items,
  required String Function(T) getItemName,
  required Function(T) onSelect,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: ExpansionTile(
      title: Text(label),
      children: isLoading
          ? [Center(child: CircularProgressIndicator())]
          : items.map((item) {
        return ListTile(
          title: Text(getItemName(item)),
          onTap: () {
            controller.text = getItemName(item);
            onSelect(item);
          },
          selected: controller.text == getItemName(item),
          selectedTileColor: Colors.deepPurpleAccent.withOpacity(0.2),
        );
      }).toList(),
    ),
  );
}
