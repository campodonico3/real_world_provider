import 'package:flutter/material.dart';

class SearchBarWithFilterWidget extends StatelessWidget {
  final TextEditingController editingController;
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onChanged;

  const SearchBarWithFilterWidget({
    super.key,
    required this.editingController,
    required this.onFilterTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: editingController,
              onChanged: onChanged,
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.grey[400]),
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: onFilterTap,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(0xFFF28482), borderRadius: BorderRadius.circular(16)),
            child: Icon(Icons.tune, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
