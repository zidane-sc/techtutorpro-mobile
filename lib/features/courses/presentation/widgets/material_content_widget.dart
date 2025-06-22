import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/core/theme/app_theme.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_material_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MaterialContentWidget extends StatelessWidget {
  final CourseEntity course;
  final CourseMaterialEntity? currentMaterial;
  final bool isLastMaterial;

  const MaterialContentWidget({
    super.key,
    required this.course,
    required this.currentMaterial,
    required this.isLastMaterial,
  });

  @override
  Widget build(BuildContext context) {
    if (currentMaterial == null) {
      return Center(
        child: Text(
          'Select a material to start learning',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildMaterialContent(context),
            const SizedBox(height: 32),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentMaterial!.type.name.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currentMaterial!.title,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(
              Icons.timer_outlined,
              color: Colors.grey[600],
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              '${currentMaterial!.durationInMinutes} minutes',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildMaterialContent(BuildContext context) {
    // Video content
    if (currentMaterial!.type == CourseMaterialType.video) {
      if (currentMaterial!.videoUrl != null &&
          currentMaterial!.videoUrl!.isNotEmpty) {
        return VideoContentWidget(videoUrl: currentMaterial!.videoUrl!);
      } else {
        return Center(
          child: Text(
            'Video for this material is not available yet.',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      }
    }

    // Text content
    if (currentMaterial!.content != null &&
        currentMaterial!.content!.isNotEmpty) {
      return MarkdownContentWidget(content: currentMaterial!.content!);
    } else {
      return Center(
        child: Text(
          'Content for this material is not available yet.',
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget _buildActionButton(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (isLastMaterial) {
            context.pushNamed(
              'courseFeedback',
              pathParameters: {'id': course.id},
              extra: course,
            );
          } else {
            context.read<CourseMaterialBloc>().add(const NextMaterial());
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isLastMaterial ? Colors.green : primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          shadowColor: primaryColor.withOpacity(0.4),
        ),
        icon: Icon(
          isLastMaterial
              ? Icons.rate_review_rounded
              : Icons.check_circle_outline_rounded,
        ),
        label: Text(
          isLastMaterial ? 'Give Feedback' : 'Mark as Complete & Continue',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class VideoContentWidget extends StatefulWidget {
  final String videoUrl;

  const VideoContentWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoContentWidget> createState() => _VideoContentWidgetState();
}

class _VideoContentWidgetState extends State<VideoContentWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).primaryColor,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
        ),
        onReady: () {
          // Add any on-ready logic here
        },
      ),
    );
  }
}

class MarkdownContentWidget extends StatelessWidget {
  final String content;

  const MarkdownContentWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: content,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        h1: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displaySmall?.color),
        h2: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color),
        h3: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineSmall?.color),
        p: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).textTheme.bodyMedium?.color),
        code: GoogleFonts.firaCode(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.5),
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!.withOpacity(0.2)),
        ),
        listBullet: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).textTheme.bodyMedium?.color),
        blockquoteDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 4,
            ),
          ),
        ),
      ),
    );
  }
}
