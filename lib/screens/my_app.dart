/pubspec.yaml
```yaml
name: figma_generated_app
description: A new Flutter project generated from Figma.
publish_to: 'none' 
version: 1.0.0+1

environment:
  sdk: '>=2.19.0 <3.0.0'

dependencies:
  flutter:
    sdk: flutter
  go_router: ^12.1.1
  google_fonts: ^4.0.4
  provider: ^6.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```
/analysis_options.yaml
```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - avoid_print
    - camel_case_types
    - library_private_types_in_public_api
    - no_logic_in_create_state
    - prefer_final_fields
    - prefer_single_quotes
    - slash_for_doc_comments
    - sort_child_properties_last
    - unnecessary_new
    - use_key_in_widget_constructors

```
/architecture.md
```markdown
This project follows a clean, layered architecture designed for scalability and maintainability.

- **Models (`/lib/models`)**: Defines the core data structures of the application. This decouples the data representation from the UI and business logic.

- **Services (`/lib/services`)**: Contains the business logic, such as fetching data from an API. Services are designed as abstract classes or with mock data, allowing the UI to be developed independently of the backend.

- **Widgets (`/lib/widgets`)**: Following an atomic design approach, this directory holds small, reusable UI components. This promotes consistency and reduces code duplication.

- **Screens (`/lib/screens`)**: These are the top-level UI components that represent a full page in the app. They are composed of smaller, reusable widgets.

- **Theme (`/lib/theme.dart`)**: A centralized file for all theme-related information, including colors, typography, and spacing. This ensures a consistent look and feel across the application.

- **Main (`/lib/main.dart`)**: The entry point of the application, responsible for initializing the app, setting up the theme, and defining navigation routes.

This separation of concerns makes the codebase easier to understand, test, and scale.
```
/lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:figma_generated_app/services/course_service.dart';
import 'package:figma_generated_app/screens/my_course_screen.dart';
import 'package:figma_generated_app/theme.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: MyCourseScreen.routeName,
  routes: <RouteBase>[
    GoRoute(
      path: MyCourseScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const MyCourseScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CourseService>(
          create: (_) => CourseService(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Figma Flutter App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
```
/lib/theme.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand & Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF1F1F39);
  static const Color secondaryText = Color(0xFF858597);

  // Card Backgrounds
  static const Color cardPink = Color(0xFFFFE7EE);
  static const Color cardGreen = Color(0xFFBAE0DB);
  static const Color cardBlue = Color(0xFFBAE0FF);

  // Play Button Colors
  static const Color playButtonPink = Color(0xFFEC7B9C);
  static const Color playButtonGreen = Color(0xFF398A80);
  static const Color playButtonBlue = Color(0xFF3D5CFF);

  // Progress Bar Colors
  static const Color progressBarBackground = Color(0xFFF4F3FD);
  static const Color learnedTodayProgressEnd = Color(0xFFFF5106);
  static const LinearGradient progressBarPink = LinearGradient(
    colors: [Color(0xFFEC7B9C), Color(0x80EC7B9C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient progressBarGreen = LinearGradient(
    colors: [Color(0xFF398A80), Color(0x80398A80)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient progressBarBlue = LinearGradient(
    colors: [Color(0xFF3D5CFF), Color(0x803D5CFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTheme {
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryText,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.secondaryText,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryText,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: AppColors.secondaryText,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primaryText,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryText,
      secondary: AppColors.secondaryText,
      background: AppColors.background,
    ),
    textTheme: _lightTextTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.background,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.primaryText),
      titleTextStyle: _lightTextTheme.displayMedium,
    ),
  );
}
```
/lib/models/course_model.dart
```dart
import 'package:flutter/material.dart';

/// Represents a course with its properties for display.
class Course {
  final String title;
  final int completedLessons;
  final int totalLessons;
  final Color backgroundColor;
  final Color playButtonColor;
  final LinearGradient progressBarGradient;

  const Course({
    required this.title,
    required this.completedLessons,
    required this.totalLessons,
    required this.backgroundColor,
    required this.playButtonColor,
    required this.progressBarGradient,
  });

  /// Calculates the progress of the course as a value between 0.0 and 1.0.
  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0.0;
  
  /// Formats the lesson progress as a string, e.g., "14/24".
  String get progressText => '$completedLessons/$totalLessons';
}
```
/lib/widgets/custom_app_bar.dart
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 22),
        onPressed: () => context.pop(),
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
```
/lib/widgets/learned_today_card.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_generated_app/theme.dart';

class LearnedTodayCard extends StatelessWidget {
  const LearnedTodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8B8D2).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learned today',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '46min',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(width: 5),
              Text(
                '/ 60min',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: const LinearProgressIndicator(
              value: 46 / 60,
              minHeight: 6,
              backgroundColor: AppColors.progressBarBackground,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.learnedTodayProgressEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```
/lib/widgets/course_card.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_generated_app/models/course_model.dart';
import 'package:figma_generated_app/theme.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: course.backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8B8D2).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              course.title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Spacer(),
            // Progress bar
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.progressBarBackground,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: course.progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: course.progressBarGradient,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completed',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  course.progressText,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle play button tap
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: course.playButtonColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
/lib/services/course_service.dart
```dart
import 'package:figma_generated_app/models/course_model.dart';
import 'package:figma_generated_app/theme.dart';

/// A mock service to fetch course data.
class CourseService {
  List<Course> getCourses() {
    // This returns mock data that matches the Figma design.
    // In a real application, this would fetch data from an API.
    return const [
      Course(
        title: 'Product\nDesign v1.0',
        completedLessons: 14,
        totalLessons: 24,
        backgroundColor: AppColors.cardPink,
        playButtonColor: AppColors.playButtonPink,
        progressBarGradient: AppColors.progressBarPink,
      ),
      Course(
        title: 'Java\nDevelopment',
        completedLessons: 12,
        totalLessons: 18,
        backgroundColor: AppColors.cardBlue,
        playButtonColor: AppColors.playButtonBlue,
        progressBarGradient: AppColors.progressBarBlue,
      ),
      Course(
        title: 'Visual Design',
        completedLessons: 10,
        totalLessons: 16,
        backgroundColor: AppColors.cardGreen,
        playButtonColor: AppColors.playButtonGreen,
        progressBarGradient: AppColors.progressBarGreen,
      ),
      // Add more courses here if needed for scrolling demonstration
    ];
  }
}
```
/lib/screens/my_course_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:figma_generated_app/models/course_model.dart';
import 'package:figma_generated_app/services/course_service.dart';
import 'package:figma_generated_app/widgets/course_card.dart';
import 'package:figma_generated_app/widgets/custom_app_bar.dart';
import 'package:figma_generated_app/widgets/learned_today_card.dart';

class MyCourseScreen extends StatelessWidget {
  static const String routeName = '/my-course';

  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch course data from the service using Provider
    final courseService = Provider.of<CourseService>(context, listen: false);
    final List<Course> courses = courseService.getCourses();

    return Scaffold(
      appBar: const CustomAppBar(title: 'My courses'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LearnedTodayCard(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Disable grid's own scrolling
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 160 / 183, // Aspect ratio from Figma design
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: courses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
/lib/utils/constants.dart
```dart
// This file can be used for application-wide constants.
// For example:
// const String kApiKey = 'YOUR_API_KEY';
