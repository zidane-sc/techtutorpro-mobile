import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionSearchBar extends StatefulWidget {
  final Function(String query) onSearch;
  final String initialQuery;

  const TransactionSearchBar({
    super.key,
    required this.onSearch,
    this.initialQuery = '',
  });

  @override
  State<TransactionSearchBar> createState() => _TransactionSearchBarState();
}

class _TransactionSearchBarState extends State<TransactionSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: _controller,
      onChanged: widget.onSearch,
      decoration: InputDecoration(
        hintText: 'Search by course name...',
        hintStyle: GoogleFonts.poppins(
            color: isDark ? Colors.grey[500] : Colors.grey[600]),
        prefixIcon: Icon(Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[700]),
        filled: true,
        fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
