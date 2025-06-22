# Contributing to TechTutor Pro

Thank you for your interest in contributing to TechTutor Pro! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- **Clear and descriptive title**
- **Detailed description** of the problem
- **Steps to reproduce** the issue
- **Expected behavior** vs **actual behavior**
- **Screenshots** if applicable
- **Device/OS information** (Android version, iOS version, etc.)
- **Flutter version** (`flutter --version`)

### Suggesting Enhancements

When suggesting new features or enhancements:

- **Clear and descriptive title**
- **Detailed description** of the proposed feature
- **Use case** and why it would be useful
- **Mockups or wireframes** if applicable
- **Alternative solutions** you've considered

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Make your changes** following the coding standards below
4. **Test your changes** thoroughly
5. **Commit your changes** with clear commit messages
6. **Push to your branch** (`git push origin feature/AmazingFeature`)
7. **Open a Pull Request** with a detailed description

## 📋 Development Setup

### Prerequisites

- Flutter SDK (>=3.3.1)
- Dart SDK (>=3.3.1)
- Android Studio / VS Code
- Git

### Local Development

1. **Fork and clone the repository**
   ```bash
   git clone https://github.com/yourusername/techtutorpro.git
   cd techtutorpro
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (if needed)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗 Architecture Guidelines

### Code Organization

Follow the existing clean architecture structure:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App-wide constants
│   ├── services/           # Core services
│   ├── theme/              # App theming
│   ├── utils/              # Utility functions
│   └── widgets/            # Shared widgets
├── features/               # Feature modules
│   ├── feature_name/
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Domain layer
│   │   └── presentation/  # Presentation layer
```

### State Management

- Use **BLoC pattern** for complex state management
- Use **Cubit** for simpler state
- Keep state classes immutable
- Use `equatable` for state comparison

### Dependency Injection

- Use **GetIt** for dependency injection
- Register dependencies in `lib/injection.dart`
- Use `@injectable` annotation for automatic registration

## 📝 Coding Standards

### Dart/Flutter Conventions

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use **snake_case** for files and directories
- Use **PascalCase** for classes and enums
- Use **camelCase** for variables and functions
- Use **SCREAMING_SNAKE_CASE** for constants

### Code Style

```dart
// ✅ Good
class UserRepository {
  final ApiClient _apiClient;
  
  UserRepository(this._apiClient);
  
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final user = await _apiClient.getUser(id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

// ❌ Bad
class userRepository {
  final ApiClient apiClient;
  
  userRepository(this.apiClient);
  
  Future getUser(String id) async {
    return await apiClient.getUser(id);
  }
}
```

### Widget Guidelines

- Keep widgets small and focused
- Use `const` constructors when possible
- Provide keys for widgets in lists
- Handle loading, error, and empty states

```dart
// ✅ Good
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  final Course course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CourseImage(imageUrl: course.imageUrl),
            CourseInfo(course: course),
          ],
        ),
      ),
    );
  }
}
```

### Error Handling

- Use `Either<L, R>` from `dartz` for error handling
- Create specific failure classes
- Handle errors gracefully in UI

```dart
// ✅ Good
class CourseFailure extends Equatable {
  final String message;
  
  const CourseFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

// In repository
Future<Either<CourseFailure, List<Course>>> getCourses() async {
  try {
    final courses = await _apiClient.getCourses();
    return Right(courses);
  } catch (e) {
    return Left(CourseFailure(e.toString()));
  }
}
```

## 🧪 Testing Guidelines

### Unit Tests

- Test all business logic in use cases
- Test repository implementations
- Mock external dependencies

```dart
// Example unit test
group('GetCoursesUseCase', () {
  late MockCourseRepository mockRepository;
  late GetCoursesUseCase useCase;

  setUp(() {
    mockRepository = MockCourseRepository();
    useCase = GetCoursesUseCase(mockRepository);
  });

  test('should return courses when repository call is successful', () async {
    // Arrange
    final courses = [Course(id: '1', title: 'Test Course')];
    when(mockRepository.getCourses()).thenAnswer((_) async => Right(courses));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(courses));
    verify(mockRepository.getCourses()).called(1);
  });
});
```

### Widget Tests

- Test widget behavior and interactions
- Test loading, error, and success states
- Mock BLoC/Cubit for state testing

### Integration Tests

- Test complete user flows
- Test navigation between screens
- Test real API interactions (in test environment)

## 🔄 Git Workflow

### Commit Messages

Use conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(courses): add course search functionality
fix(auth): resolve login validation issue
docs(readme): update installation instructions
```

### Branch Naming

- `feature/feature-name`: New features
- `fix/bug-description`: Bug fixes
- `docs/documentation-update`: Documentation changes
- `refactor/component-name`: Code refactoring

## 📋 Pull Request Checklist

Before submitting a PR, ensure:

- [ ] Code follows the project's style guidelines
- [ ] All tests pass (`flutter test`)
- [ ] Code is properly documented
- [ ] No console errors or warnings
- [ ] UI changes are tested on different screen sizes
- [ ] Accessibility guidelines are followed
- [ ] Performance impact is considered
- [ ] Security implications are reviewed

## 🐛 Bug Fix Process

1. **Reproduce the bug** locally
2. **Create a test** that fails due to the bug
3. **Fix the bug** and ensure the test passes
4. **Add additional tests** to prevent regression
5. **Update documentation** if needed

## 🚀 Release Process

1. **Create a release branch** from main
2. **Update version** in `pubspec.yaml`
3. **Update changelog** with new features/fixes
4. **Run full test suite**
5. **Create release notes**
6. **Tag the release**

## 📞 Getting Help

- **GitHub Issues**: For bug reports and feature requests
- **Discussions**: For questions and general discussion
- **Email**: support@techtutorpro.com

## 🙏 Recognition

Contributors will be recognized in:
- Project README
- Release notes
- Contributor hall of fame

Thank you for contributing to TechTutor Pro! 🚀 