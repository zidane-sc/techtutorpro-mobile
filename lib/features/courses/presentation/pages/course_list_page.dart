import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/presentation/bloc/course_bloc.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/banner_carousel.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/category_chips.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/course_card.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/filter_panel.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/horizontal_course_list.dart';
import 'package:techtutorpro/features/courses/presentation/widgets/section_title.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<CategoryItem> _categories = [
    const CategoryItem(id: 'all', name: 'All', icon: Icons.grid_view),
    const CategoryItem(
        id: 'flutter', name: 'Flutter', icon: Icons.flutter_dash),
    const CategoryItem(id: 'backend', name: 'Backend', icon: Icons.storage),
    const CategoryItem(id: 'ai', name: 'AI/ML', icon: Icons.psychology),
    const CategoryItem(id: 'web', name: 'Web Dev', icon: Icons.web),
    const CategoryItem(id: 'mobile', name: 'Mobile', icon: Icons.phone_android),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();

    context.read<CourseBloc>().add(FetchCourses());
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String categoryId) {
    context.read<CourseBloc>().add(SelectCategory(categoryId));
  }

  List<CourseEntity> _getRecommendedCourses(List<CourseEntity> courses) {
    // Sort by rating and return top 5
    final sorted = List<CourseEntity>.from(courses);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(5).toList();
  }

  List<CourseEntity> _getPopularCourses(List<CourseEntity> courses) {
    // Sort by student count and return top 5
    final sorted = List<CourseEntity>.from(courses);
    sorted.sort((a, b) => b.studentCount.compareTo(a.studentCount));
    return sorted.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading || state is CourseInitial) {
            return _buildLoadingState();
          }
          if (state is CourseError) {
            return _buildErrorState(state.message);
          }
          if (state is CourseLoaded) {
            return _buildContent(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading courses',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(CourseLoaded state) {
    final recommendedCourses = _getRecommendedCourses(state.courses);
    final popularCourses = _getPopularCourses(state.courses);

    final bool isFiltered = state.isFiltered;

    String subtitle = 'Explore our complete course catalog';
    if (isFiltered) {
      if (state.selectedCategory != 'all') {
        subtitle = 'Showing courses in "${state.selectedCategory}"';
      } else {
        subtitle = 'Showing filtered results';
      }
    }

    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          expandedHeight: 0,
          floating: true,
          pinned: true,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 1.0,
          title: Text(
            'TechTutor Pro',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                final courseBloc = context.read<CourseBloc>();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => FilterPanel(
                    courseBloc: courseBloc,
                  ),
                );
              },
            ),
          ],
        ),
        // Banner Carousel
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: const BannerCarousel(),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        // Category Chips
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CategoryChips(
                categories: _categories,
                onCategorySelected: _onCategorySelected,
                selectedCategory: state.selectedCategory,
              ),
            ),
          ),
        ),
        // Recommended Courses
        if (!isFiltered)
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    SectionTitle(
                      title: 'Recommended Courses',
                      subtitle: 'Handpicked courses for you',
                      onSeeAllPressed: () {
                        // TODO: Navigate to recommended courses page
                      },
                    ),
                    HorizontalCourseList(
                      courses: recommendedCourses,
                      height: 230,
                    ),
                  ],
                ),
              ),
            ),
          ),
        // Popular Courses
        if (!isFiltered)
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    SectionTitle(
                      title: 'Popular Courses',
                      subtitle: 'Most enrolled courses',
                      onSeeAllPressed: () {
                        // TODO: Navigate to popular courses page
                      },
                    ),
                    HorizontalCourseList(
                      courses: popularCourses,
                      height: 230,
                    ),
                  ],
                ),
              ),
            ),
          ),
        // All Courses Section
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SectionTitle(
                title: isFiltered ? 'Filtered Results' : 'All Courses',
                subtitle: subtitle,
                showSeeAll: false,
              ),
            ),
          ),
        ),
        // All Courses List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final course = state.courses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CourseCard(course: course),
                );
              },
              childCount: state.courses.length,
            ),
          ),
        ),
        // Bottom padding
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}
