import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/core/theme/app_theme.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_material_bloc.dart';

class MaterialSidebarWidget extends StatelessWidget {
  final CourseEntity course;
  final CourseMaterialEntity? currentMaterial;
  final Map<String, bool> sectionStates;

  const MaterialSidebarWidget({
    super.key,
    required this.course,
    required this.currentMaterial,
    required this.sectionStates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar Materi',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Material List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: course.materialSections.length,
              itemBuilder: (context, index) {
                final section = course.materialSections[index];
                final isExpanded = sectionStates[section.id] ?? false;

                return MaterialSectionCard(
                  section: section,
                  isExpanded: isExpanded,
                  currentMaterial: currentMaterial,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialSectionCard extends StatelessWidget {
  final CourseMaterialSectionEntity section;
  final bool isExpanded;
  final CourseMaterialEntity? currentMaterial;

  const MaterialSectionCard({
    super.key,
    required this.section,
    required this.isExpanded,
    required this.currentMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        key: PageStorageKey(section.id),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          context.read<CourseMaterialBloc>().add(ToggleSection(section.id));
        },
        title: Text(
          section.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Theme.of(context).primaryColor,
        ),
        children: section.materials.map((material) {
          final isActive = currentMaterial?.id == material.id;

          return MaterialListItem(
            material: material,
            isActive: isActive,
          );
        }).toList(),
      ),
    );
  }
}

class MaterialListItem extends StatelessWidget {
  final CourseMaterialEntity material;
  final bool isActive;

  const MaterialListItem({
    super.key,
    required this.material,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<CourseMaterialBloc>().add(SelectMaterial(material.id));
        Navigator.pop(context); // Close drawer on selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive
              ? Border(left: BorderSide(color: primaryColor, width: 4))
              : null,
        ),
        child: Row(
          children: [
            // Material Type Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: material.type == CourseMaterialType.video
                    ? Colors.red.withOpacity(0.1)
                    : primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                material.type == CourseMaterialType.video
                    ? Icons.play_circle_filled_rounded
                    : Icons.article_rounded,
                size: 20,
                color: material.type == CourseMaterialType.video
                    ? Colors.red
                    : primaryColor,
              ),
            ),

            const SizedBox(width: 12),

            // Material Title
            Expanded(
              child: Text(
                material.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive
                      ? primaryColor
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Duration
            Text(
              '${material.durationInMinutes}m',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
