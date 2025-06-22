import 'package:injectable/injectable.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_material_entity.dart';
import 'package:techtutorpro/features/courses/domain/entities/course_review_entity.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseEntity>> getCourses();
  Future<CourseEntity> getCourseDetail(String courseId);
}

@LazySingleton(as: CourseRemoteDataSource)
class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final List<CourseEntity> _courses = [
    CourseEntity(
        id: '1',
        title: 'Flutter for Beginners: From Zero to Hero',
        thumbnail: 'https://picsum.photos/400/250?random=1',
        description:
            'Learn the fundamentals of Flutter and Dart to build beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
        price: 200000,
        discountedPrice: 100000,
        level: 'Pemula',
        studentCount: 3000,
        materialCount: 50,
        durationInMinutes: 600,
        rating: 4.7,
        reviewCount: 312,
        tags: ['flutter', 'mobile-dev', 'dart'],
        method: 'Video',
        materialSections: [
          const CourseMaterialSectionEntity(
              id: 's1',
              title: 'Introduction to Flutter',
              materials: [
                CourseMaterialEntity(
                    id: 'm1',
                    title: 'What is Flutter?',
                    type: CourseMaterialType.text,
                    durationInMinutes: 10,
                    content: '''
# What is Flutter?

Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

## Key Features

• **Single Codebase**: Write once, run anywhere
• **Hot Reload**: See changes instantly during development
• **Rich Widget Library**: Pre-built widgets for common UI patterns
• **Native Performance**: Compiles to native code for optimal performance

## Why Choose Flutter?

Flutter provides a complete solution for building apps across multiple platforms while maintaining high performance and beautiful user interfaces.

### Benefits:
- **Fast Development**: Hot reload feature speeds up development
- **Consistent UI**: Same look and feel across platforms
- **Rich Ecosystem**: Extensive package ecosystem
- **Strong Community**: Active developer community
                    '''),
                CourseMaterialEntity(
                    id: 'm2',
                    title: 'Setting up your environment',
                    type: CourseMaterialType.video,
                    durationInMinutes: 20,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
                CourseMaterialEntity(
                    id: 'm3',
                    title: 'Your First Flutter App',
                    type: CourseMaterialType.text,
                    durationInMinutes: 15,
                    content: '''
# Your First Flutter App

Let's create a simple "Hello World" Flutter application to get you started.

## Step 1: Create a New Project

```bash
flutter create my_first_app
cd my_first_app
```

## Step 2: Understanding the Structure

A Flutter project contains:
- `lib/main.dart` - Entry point of your app
- `pubspec.yaml` - Dependencies and project configuration
- `android/` and `ios/` - Platform-specific code

## Step 3: Run Your App

```bash
flutter run
```

Your app should now be running on your device or emulator!
                    '''),
              ]),
          const CourseMaterialSectionEntity(
              id: 's2',
              title: 'Dart Fundamentals',
              materials: [
                CourseMaterialEntity(
                    id: 'm4',
                    title: 'Variables and Data Types',
                    type: CourseMaterialType.video,
                    durationInMinutes: 25,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
                CourseMaterialEntity(
                    id: 'm5',
                    title: 'Functions and Classes',
                    type: CourseMaterialType.text,
                    durationInMinutes: 20,
                    content: '''
# Functions and Classes in Dart

## Functions

Functions are blocks of code that perform specific tasks.

```dart
void greet(String name) {
  print('Hello, \$name!');
}

int add(int a, int b) {
  return a + b;
}
```

## Classes

Classes are blueprints for creating objects.

```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print('Hi, I\\'m \$name and I\\'m \$age years old.');
  }
}
```

## Key Concepts

• **Encapsulation**: Bundling data and methods together
• **Inheritance**: Creating new classes from existing ones
• **Polymorphism**: Using objects of different types through a common interface
                    '''),
              ]),
        ],
        reviews: [
          CourseReviewEntity(
              id: 'r1',
              studentName: 'Alice',
              review: 'Great introductory course!',
              rating: 5,
              date: DateTime(2024, 6, 1)),
        ]),
    CourseEntity(
        id: '2',
        title: 'Belajar Python: Dari Dasar hingga Mahir',
        thumbnail: 'https://picsum.photos/400/250?random=2',
        description:
            'Python adalah bahasa pemrograman interpretatif multiguna. Tidak seperti bahasa lain yang lebih sulit untuk dibaca dan dipahami, python lebih menekankan pada keterbacaan kode agar lebih mudah untuk memahami sintaks. Hal ini membuat Python sangat mudah dipelajari baik untuk pemula maupun untuk yang sudah menguasai bahasa pemrograman lain.',
        price: 150000,
        discountedPrice: 75000,
        level: 'Menengah',
        studentCount: 876,
        materialCount: 40,
        durationInMinutes: 480,
        rating: 4.8,
        reviewCount: 250,
        tags: ['python', 'backend', 'data-science'],
        method: 'Video',
        materialSections: [
          CourseMaterialSectionEntity(
              id: 's1',
              title: 'Kenalan dengan Python',
              materials: [
                const CourseMaterialEntity(
                    id: 'm1',
                    title: 'Apa itu Python',
                    type: CourseMaterialType.text,
                    durationInMinutes: 10,
                    content: '''
# Apa itu Python?

Python adalah bahasa pemrograman tingkat tinggi yang diciptakan oleh Guido van Rossum pada tahun 1991.

## Karakteristik Python

• **Mudah Dipelajari**: Sintaks yang sederhana dan mudah dibaca
• **Multi-platform**: Berjalan di berbagai sistem operasi
• **Open Source**: Gratis dan dapat dimodifikasi
• **Rich Library**: Memiliki library yang sangat banyak

## Keunggulan Python

Python sangat populer karena:
- Kemudahan dalam belajar dan menggunakan
- Fleksibilitas dalam pengembangan
- Komunitas yang besar dan aktif
- Dukungan library yang lengkap
                    '''),
                const CourseMaterialEntity(
                    id: 'm2',
                    title: 'Instalasi Python',
                    type: CourseMaterialType.video,
                    durationInMinutes: 15,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
              ]),
          CourseMaterialSectionEntity(
              id: 's2',
              title: 'Dasar Python',
              materials: [
                const CourseMaterialEntity(
                    id: 'm3',
                    title: 'Variables & Tipe Data',
                    type: CourseMaterialType.video,
                    durationInMinutes: 20,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
                const CourseMaterialEntity(
                    id: 'm4',
                    title: 'Struktur Data Python',
                    type: CourseMaterialType.text,
                    durationInMinutes: 25,
                    content: '''
# Struktur Data Python

Python memiliki beberapa struktur data bawaan yang sangat berguna.

## List (Daftar)

List adalah struktur data yang dapat menyimpan berbagai tipe data.

```python
# Membuat list
buah = ['apel', 'jeruk', 'pisang']
angka = [1, 2, 3, 4, 5]

# Mengakses elemen
print(buah[0])  # Output: apel

# Menambah elemen
buah.append('mangga')
```

## Dictionary (Kamus)

Dictionary menyimpan data dalam bentuk key-value pair.

```python
# Membuat dictionary
mahasiswa = {
    'nama': 'Budi',
    'umur': 20,
    'jurusan': 'Informatika'
}

# Mengakses nilai
print(mahasiswa['nama'])  # Output: Budi
```

## Tuple

Tuple mirip dengan list tapi tidak dapat diubah (immutable).

```python
koordinat = (10, 20)
print(koordinat[0])  # Output: 10
```
                    '''),
              ]),
          const CourseMaterialSectionEntity(
              id: 's3',
              title: 'Operator',
              materials: [
                CourseMaterialEntity(
                    id: 'm5',
                    title: 'Operator Aritmatika',
                    type: CourseMaterialType.text,
                    durationInMinutes: 15,
                    content: '''
# Operator Aritmatika

Python mendukung berbagai operator aritmatika untuk perhitungan matematika.

## Operator Dasar

```python
a = 10
b = 3

# Penjumlahan
hasil = a + b  # 13

# Pengurangan
hasil = a - b  # 7

# Perkalian
hasil = a * b  # 30

# Pembagian
hasil = a / b  # 3.333...

# Modulo (sisa bagi)
hasil = a % b  # 1

# Pangkat
hasil = a ** b  # 1000
```

## Operator Assignment

```python
x = 5
x += 3  # Sama dengan x = x + 3
x -= 2  # Sama dengan x = x - 2
x *= 4  # Sama dengan x = x * 4
```
                    '''),
              ]),
          const CourseMaterialSectionEntity(
              id: 's4',
              title: 'Kontrol Flow',
              materials: [
                CourseMaterialEntity(
                    id: 'm6',
                    title: 'Kondisi if-else',
                    type: CourseMaterialType.text,
                    durationInMinutes: 20,
                    content: '''
# Kontrol Flow dengan if-else

Kontrol flow memungkinkan program mengambil keputusan berdasarkan kondisi tertentu.

## Statement if

```python
umur = 18

if umur >= 18:
    print("Anda sudah dewasa")
```

## Statement if-else

```python
nilai = 85

if nilai >= 80:
    print("Nilai A")
else:
    print("Nilai B")
```

## Statement if-elif-else

```python
nilai = 75

if nilai >= 90:
    print("Nilai A")
elif nilai >= 80:
    print("Nilai B")
elif nilai >= 70:
    print("Nilai C")
else:
    print("Nilai D")
```

## Nested if

```python
umur = 20
pendapatan = 5000000

if umur >= 18:
    if pendapatan >= 3000000:
        print("Eligible untuk kredit")
    else:
        print("Pendapatan tidak mencukupi")
else:
    print("Belum cukup umur")
```
                    '''),
                CourseMaterialEntity(
                    id: 'm7',
                    title: 'Loop dan Iterasi',
                    type: CourseMaterialType.video,
                    durationInMinutes: 25,
                    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
              ]),
        ],
        reviews: [
          CourseReviewEntity(
              id: 'r1',
              studentName: 'Student',
              review: 'kerennn cuy',
              rating: 5,
              date: DateTime(2024, 6, 13)),
          CourseReviewEntity(
              id: 'r2',
              studentName: 'Muhammad Zidane Sc',
              review: 'Anjay mantap sesuai pesanan, menyala 🔥🔥',
              rating: 5,
              date: DateTime(2024, 6, 13)),
        ]),
    CourseEntity(
        id: '3',
        title: 'Advanced JavaScript Concepts',
        thumbnail: 'https://picsum.photos/400/250?random=3',
        description:
            'Dive deep into the advanced concepts of JavaScript including closures, prototypes, async/await, and more. Perfect for developers looking to master the language.',
        price: 250000,
        discountedPrice: 175000,
        level: 'Lanjutan',
        studentCount: 500,
        materialCount: 65,
        durationInMinutes: 720,
        rating: 4.9,
        reviewCount: 560,
        tags: ['javascript', 'frontend', 'web-dev'],
        method: 'Video',
        materialSections: [],
        reviews: []),
    CourseEntity(
        id: '4',
        title: 'Complete Web Development Bootcamp',
        thumbnail: 'https://picsum.photos/400/250?random=4',
        description:
            'Master the complete web development stack from HTML/CSS to JavaScript, React, Node.js, and databases. Build real-world projects and become a full-stack developer.',
        price: 300000,
        discountedPrice: 200000,
        level: 'Pemula',
        studentCount: 3500,
        materialCount: 120,
        durationInMinutes: 900,
        rating: 4.5,
        reviewCount: 890,
        tags: ['web-dev', 'fullstack', 'html', 'css', 'javascript', 'react'],
        method: 'Video',
        materialSections: [
          const CourseMaterialSectionEntity(
              id: 's1',
              title: 'HTML & CSS Fundamentals',
              materials: [
                CourseMaterialEntity(
                    id: 'm1',
                    title: 'Introduction to HTML',
                    type: CourseMaterialType.video,
                    durationInMinutes: 25),
                CourseMaterialEntity(
                    id: 'm2',
                    title: 'CSS Styling Basics',
                    type: CourseMaterialType.video,
                    durationInMinutes: 30),
              ]),
        ],
        reviews: [
          CourseReviewEntity(
              id: 'r1',
              studentName: 'Sarah Johnson',
              review:
                  'Amazing course! I went from zero to building real websites.',
              rating: 5,
              date: DateTime(2024, 5, 15)),
          CourseReviewEntity(
              id: 'r2',
              studentName: 'Mike Chen',
              review: 'Comprehensive and well-structured. Highly recommended!',
              rating: 5,
              date: DateTime(2024, 5, 20)),
        ]),
    CourseEntity(
        id: '5',
        title: 'UI/UX Design with Figma',
        thumbnail: 'https://picsum.photos/400/250?random=5',
        description:
            'Learn modern UI/UX design principles and master Figma to create stunning user interfaces. From wireframes to prototypes, this course covers everything you need.',
        price: 180000,
        discountedPrice: 90000,
        level: 'Menengah',
        studentCount: 1200,
        materialCount: 45,
        durationInMinutes: 540,
        rating: 4.8,
        reviewCount: 320,
        tags: ['ui-ux', 'figma', 'design', 'prototyping'],
        method: 'Video',
        materialSections: [],
        reviews: []),
    CourseEntity(
        id: '6',
        title: 'Data Science with Python',
        thumbnail: 'https://picsum.photos/400/250?random=6',
        description:
            'Explore the world of data science using Python. Learn pandas, numpy, matplotlib, and machine learning algorithms to analyze and visualize data effectively.',
        price: 280000,
        discountedPrice: 210000,
        level: 'Lanjutan',
        studentCount: 950,
        materialCount: 80,
        durationInMinutes: 780,
        rating: 4.9,
        reviewCount: 420,
        tags: ['data-science', 'python', 'machine-learning', 'pandas'],
        method: 'Video',
        materialSections: [],
        reviews: []),
    CourseEntity(
        id: '7',
        title: 'Mobile App Development with React Native',
        thumbnail: 'https://picsum.photos/400/250?random=7',
        description:
            'Build cross-platform mobile applications using React Native. Learn to create apps that work on both iOS and Android with a single codebase.',
        price: 220000,
        level: 'Menengah',
        studentCount: 1800,
        materialCount: 60,
        durationInMinutes: 660,
        rating: 4.6,
        reviewCount: 380,
        tags: ['react-native', 'mobile-dev', 'javascript', 'cross-platform'],
        method: 'Video',
        materialSections: [],
        reviews: []),
    CourseEntity(
        id: '8',
        title: 'Backend Development with Node.js',
        thumbnail: 'https://picsum.photos/400/250?random=8',
        description:
            'Master server-side development with Node.js and Express. Build RESTful APIs, work with databases, and deploy your applications to production.',
        price: 200000,
        discountedPrice: 120000,
        level: 'Menengah',
        studentCount: 1400,
        materialCount: 55,
        durationInMinutes: 600,
        rating: 4.8,
        reviewCount: 290,
        tags: ['nodejs', 'express', 'backend', 'api', 'javascript'],
        method: 'Video',
        materialSections: [],
        reviews: []),
    CourseEntity(
      id: '9',
      title: 'Cyber Security Essentials for Beginners',
      thumbnail: 'https://picsum.photos/400/250?random=9',
      description:
          'Learn the fundamentals of cyber security to protect your systems and data from cyber attacks. Covers basics of network security, cryptography, and ethical hacking.',
      price: 220000,
      discountedPrice: 150000,
      level: 'Pemula',
      studentCount: 1100,
      materialCount: 40,
      durationInMinutes: 500,
      rating: 4.7,
      reviewCount: 280,
      tags: ['cyber-security', 'networking', 'ethical-hacking'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'Introduction to Cyber Security',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'What is Cyber Security?',
              type: CourseMaterialType.text,
              durationInMinutes: 15,
              content:
                  '# What is Cyber Security?\n\nA brief overview of the field of cyber security.',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'Common Threats',
              type: CourseMaterialType.video,
              durationInMinutes: 20,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'John Doe',
          review: 'Very insightful for beginners!',
          rating: 5,
          date: DateTime(2024, 6, 10),
        ),
        CourseReviewEntity(
          id: 'r2',
          studentName: 'Jane Smith',
          review: 'Good starting point.',
          rating: 4,
          date: DateTime(2024, 6, 11),
        ),
      ],
    ),
    CourseEntity(
      id: '10',
      title: 'DevOps from Scratch: CI/CD with Jenkins and Docker',
      thumbnail: 'https://picsum.photos/400/250?random=10',
      description:
          'Master DevOps principles and tools like Jenkins, Docker, and Kubernetes. Learn to automate your build, test, and deployment pipelines for faster delivery.',
      price: 320000,
      level: 'Lanjutan',
      studentCount: 600,
      materialCount: 70,
      durationInMinutes: 800,
      rating: 4.9,
      reviewCount: 410,
      tags: ['devops', 'ci-cd', 'jenkins', 'docker', 'kubernetes'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'Introduction to DevOps',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'DevOps Principles',
              type: CourseMaterialType.text,
              durationInMinutes: 20,
              content:
                  '# DevOps Principles\n\nUnderstanding the core concepts of DevOps.',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'CI/CD Pipeline Overview',
              type: CourseMaterialType.video,
              durationInMinutes: 25,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
          ],
        ),
        const CourseMaterialSectionEntity(
          id: 's2',
          title: 'Hands-on with Docker',
          materials: [
            CourseMaterialEntity(
              id: 'm3',
              title: 'Creating Dockerfiles',
              type: CourseMaterialType.text,
              durationInMinutes: 30,
              content:
                  '# Creating Dockerfiles\n\nLearn to write effective Dockerfiles for your applications.',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'Chris Green',
          review: 'This course is a game-changer!',
          rating: 5,
          date: DateTime(2024, 6, 1),
        ),
        CourseReviewEntity(
          id: 'r2',
          studentName: 'Patricia White',
          review: 'Excellent content and great instructor.',
          rating: 5,
          date: DateTime(2024, 6, 5),
        ),
      ],
    ),
    CourseEntity(
      id: '11',
      title: 'AI for Everyone: Understanding Artificial Intelligence',
      thumbnail: 'https://picsum.photos/400/250?random=11',
      description:
          'A non-technical introduction to Artificial Intelligence. Understand what AI is, what it can and cannot do, and how it impacts society. No prior experience required.',
      price: 100000,
      level: 'Pemula',
      studentCount: 4500,
      materialCount: 20,
      durationInMinutes: 240,
      rating: 4.6,
      reviewCount: 1200,
      tags: ['ai', 'machine-learning', 'non-technical'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'What is AI?',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'Defining Artificial Intelligence',
              type: CourseMaterialType.text,
              durationInMinutes: 10,
              content:
                  '# Defining AI\n\nA simple explanation of what AI is and its history.',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'Alex Ray',
          review: 'Finally, an AI course I can understand!',
          rating: 5,
          date: DateTime(2024, 5, 28),
        ),
      ],
    ),
    CourseEntity(
      id: '12',
      title: 'SQL for Data Analysis: From Beginner to Pro',
      thumbnail: 'https://picsum.photos/400/250?random=12',
      description:
          'Master SQL for data analysis. Learn to write complex queries, join tables, and extract valuable insights from databases. Covers PostgreSQL and MySQL.',
      price: 180000,
      level: 'Menengah',
      studentCount: 2200,
      materialCount: 50,
      durationInMinutes: 550,
      rating: 4.8,
      reviewCount: 650,
      tags: ['sql', 'data-analysis', 'database', 'postgresql', 'mysql'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'SQL Fundamentals',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'SELECT statements',
              type: CourseMaterialType.video,
              durationInMinutes: 20,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'Filtering with WHERE',
              type: CourseMaterialType.text,
              durationInMinutes: 15,
              content:
                  '# Filtering Data\n\nLearn to use the WHERE clause to filter your data.',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'Sam Brown',
          review: 'The best SQL course I have ever taken.',
          rating: 5,
          date: DateTime(2024, 6, 2),
        ),
      ],
    ),
    CourseEntity(
      id: '13',
      title: 'Game Development with Unity',
      thumbnail: 'https://picsum.photos/400/250?random=13',
      description:
          'Learn to build 2D and 3D games with Unity. This course covers C# scripting, physics, animation, and UI development for games.',
      price: 350000,
      discountedPrice: 250000,
      level: 'Menengah',
      studentCount: 1700,
      materialCount: 80,
      durationInMinutes: 950,
      rating: 4.8,
      reviewCount: 550,
      tags: ['gamedev', 'unity', 'c#', '3d'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'Introduction to Unity',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'Unity Interface',
              type: CourseMaterialType.video,
              durationInMinutes: 20,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'Basic C# Scripting',
              type: CourseMaterialType.text,
              durationInMinutes: 25,
              content:
                  '# Basic C# Scripting\n\nAn introduction to scripting in Unity with C#.',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'GamingPro',
          review: 'Awesome course for aspiring game devs!',
          rating: 5,
          date: DateTime(2024, 5, 25),
        ),
        CourseReviewEntity(
          id: 'r2',
          studentName: 'PixelArt',
          review: 'Very detailed and easy to follow.',
          rating: 4,
          date: DateTime(2024, 5, 26),
        ),
      ],
    ),
    CourseEntity(
      id: '14',
      title: 'Cloud Computing with AWS',
      thumbnail: 'https://picsum.photos/400/250?random=14',
      description:
          'Become an AWS expert. Learn about core AWS services like EC2, S3, RDS, and Lambda. Prepare for AWS certification exams.',
      price: 400000,
      level: 'Lanjutan',
      studentCount: 700,
      materialCount: 90,
      durationInMinutes: 1000,
      rating: 4.9,
      reviewCount: 720,
      tags: ['aws', 'cloud', 'devops', 'iaas'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'AWS Fundamentals',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'What is Cloud Computing?',
              type: CourseMaterialType.text,
              durationInMinutes: 15,
              content:
                  '# What is Cloud Computing?\n\nLearn the fundamentals of cloud computing and its benefits.',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'Tour of AWS Console',
              type: CourseMaterialType.video,
              durationInMinutes: 15,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'CloudArchitect',
          review: 'Best AWS course out there!',
          rating: 5,
          date: DateTime(2024, 6, 8),
        ),
      ],
    ),
    CourseEntity(
      id: '15',
      title: 'Digital Marketing Fundamentals',
      thumbnail: 'https://picsum.photos/400/250?random=15',
      description:
          'Master digital marketing with this comprehensive course. Learn SEO, SEM, social media marketing, email marketing, and content strategy.',
      price: 150000,
      level: 'Pemula',
      studentCount: 5200,
      materialCount: 50,
      durationInMinutes: 450,
      rating: 4.5,
      reviewCount: 1500,
      tags: ['marketing', 'seo', 'social-media', 'business'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'Introduction to Digital Marketing',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'The Marketing Funnel',
              type: CourseMaterialType.text,
              durationInMinutes: 20,
              content:
                  '# The Marketing Funnel\n\nUnderstand the journey of a customer.',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'Understanding SEO',
              type: CourseMaterialType.video,
              durationInMinutes: 25,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'Marketer101',
          review: 'Great overview of the digital marketing landscape.',
          rating: 5,
          date: DateTime(2024, 6, 12),
        ),
      ],
    ),
    CourseEntity(
      id: '16',
      title: 'Blockchain and Cryptocurrency Basics',
      thumbnail: 'https://picsum.photos/400/250?random=16',
      description:
          'Understand the technology behind Bitcoin and other cryptocurrencies. Learn about blockchain, smart contracts, and the future of decentralized finance (DeFi).',
      price: 250000,
      level: 'Pemula',
      studentCount: 1900,
      materialCount: 35,
      durationInMinutes: 380,
      rating: 4.6,
      reviewCount: 450,
      tags: ['blockchain', 'crypto', 'bitcoin', 'ethereum', 'web3'],
      method: 'Video',
      materialSections: [
        const CourseMaterialSectionEntity(
          id: 's1',
          title: 'What is Blockchain?',
          materials: [
            CourseMaterialEntity(
              id: 'm1',
              title: 'Decentralization Explained',
              type: CourseMaterialType.text,
              durationInMinutes: 20,
              content:
                  '# Decentralization Explained\n\nLearn what it means to be decentralized.',
            ),
            CourseMaterialEntity(
              id: 'm2',
              title: 'How Bitcoin Works',
              type: CourseMaterialType.video,
              durationInMinutes: 30,
              videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            ),
          ],
        ),
      ],
      reviews: [
        CourseReviewEntity(
          id: 'r1',
          studentName: 'CryptoKing',
          review: 'Demystified blockchain for me.',
          rating: 5,
          date: DateTime(2024, 6, 14),
        ),
      ],
    ),
  ];

  @override
  Future<List<CourseEntity>> getCourses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _courses;
  }

  @override
  Future<CourseEntity> getCourseDetail(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Course with id $courseId not found'),
    );
  }
}
