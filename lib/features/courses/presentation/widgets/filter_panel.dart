import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_bloc.dart';

class FilterPanel extends StatefulWidget {
  final CourseBloc courseBloc;

  const FilterPanel({super.key, required this.courseBloc});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  final List<String> _allTeknologi = [
    'web',
    'frontend',
    'html',
    'css',
    'javascript',
    'python',
    'backend',
    'data-science',
    'flutter',
    'mobile',
    'dart',
    'jaringan',
    'security',
    'it-support',
    'ui-ux',
    'figma',
    'design',
    'machine-learning',
  ];

  final List<String> _allLevels = ['Pemula', 'Menengah', 'Lanjutan'];
  final List<String> _allMetode = ['Video', 'Text'];

  List<String> _selectedTeknologi = [];
  List<String> _selectedLevels = [];
  List<String> _selectedMetode = [];
  String _searchQuery = '';
  bool _isDropdownVisible = false;
  final FocusNode _searchFocusNode = FocusNode();

  List<String> get _filteredTeknologi {
    if (_searchQuery.isEmpty) {
      return _allTeknologi;
    }
    return _allTeknologi
        .where(
            (tech) => tech.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    // Initialize with current filter state from CourseBloc
    _selectedTeknologi = List.from(widget.courseBloc.selectedTeknologi);
    _selectedLevels = List.from(widget.courseBloc.selectedLevels);
    _selectedMetode = List.from(widget.courseBloc.selectedMetode);

    _searchFocusNode.addListener(() {
      // Only show dropdown when gaining focus, don't hide when losing focus
      if (_searchFocusNode.hasFocus) {
        setState(() {
          _isDropdownVisible = true;
        });
      }
    });
  }

  void _closeDropdown() {
    setState(() {
      _isDropdownVisible = false;
    });
    _searchFocusNode.unfocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(
                    context,
                    'Metode',
                    _buildCheckboxGroup(
                      items: _allMetode,
                      selectedItems: _selectedMetode,
                      onChanged: (selected) {
                        setState(() => _selectedMetode = selected);
                        _updateBlocFilterState();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection(
                    context,
                    'Teknologi',
                    _buildDropdownWithSearch(),
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection(
                    context,
                    'Level',
                    _buildChipGroup(
                      items: _allLevels,
                      selectedItems: _selectedLevels,
                      onChanged: (selected) {
                        setState(() => _selectedLevels = selected);
                        _updateBlocFilterState();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTeknologi.clear();
                      _selectedLevels.clear();
                      _selectedMetode.clear();
                      _searchQuery = '';
                    });
                    _updateBlocFilterState();
                    widget.courseBloc.add(FetchCourses());
                    Navigator.pop(context);
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.courseBloc.add(ApplyFilters(
                      selectedTeknologi: _selectedTeknologi,
                      selectedLevels: _selectedLevels,
                      selectedMetode: _selectedMetode,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text('Terapkan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildCheckboxGroup({
    required List<String> items,
    required List<String> selectedItems,
    required ValueChanged<List<String>> onChanged,
  }) {
    return Column(
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return CheckboxListTile(
          title: Text(item),
          value: isSelected,
          onChanged: (selected) {
            final newSelection = List<String>.from(selectedItems);
            if (selected!) {
              newSelection.add(item);
            } else {
              newSelection.remove(item);
            }
            onChanged(newSelection);
          },
        );
      }).toList(),
    );
  }

  Widget _buildDropdownWithSearch() {
    return GestureDetector(
      onTap: () {
        // Close dropdown when clicking outside
        if (_isDropdownVisible) {
          _closeDropdown();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown list - positioned above input when keyboard is shown
          if (_isDropdownVisible)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredTeknologi.length,
                itemBuilder: (context, index) {
                  final tech = _filteredTeknologi[index];
                  final isSelected = _selectedTeknologi.contains(tech);

                  return ListTile(
                    dense: true,
                    title: Text(tech),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTeknologi.remove(tech);
                        } else {
                          _selectedTeknologi.add(tech);
                        }
                      });
                      _updateBlocFilterState();
                      // Close dropdown after selection
                      _closeDropdown();
                    },
                  );
                },
              ),
            ),
          if (_isDropdownVisible) const SizedBox(height: 8),
          // Search TextField
          GestureDetector(
            onTap: () {
              // Prevent closing when clicking on the TextField
            },
            child: TextField(
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Cari teknologi...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          // Selected items display
          if (_selectedTeknologi.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _selectedTeknologi.map((tech) {
                return Chip(
                  label: Text(tech),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () {
                    setState(() {
                      _selectedTeknologi.remove(tech);
                    });
                    _updateBlocFilterState();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildChipGroup({
    required List<String> items,
    required List<String> selectedItems,
    required ValueChanged<List<String>> onChanged,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return FilterChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) {
            final newSelection = List<String>.from(selectedItems);
            if (selected) {
              newSelection.add(item);
            } else {
              newSelection.remove(item);
            }
            onChanged(newSelection);
          },
        );
      }).toList(),
    );
  }

  void _updateBlocFilterState() {
    widget.courseBloc.add(UpdateFilterState(
      selectedTeknologi: _selectedTeknologi,
      selectedLevels: _selectedLevels,
      selectedMetode: _selectedMetode,
    ));
  }
}
