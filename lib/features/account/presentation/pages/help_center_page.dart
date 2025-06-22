import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techtutorpro/router/app_router.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'How do I purchase a course?',
      answer:
          'To purchase a course, browse the course catalog, select your desired course, and tap the "Buy Now" button. You can pay using various payment methods including credit cards, digital wallets, and bank transfers.',
    ),
    FAQItem(
      question: 'Can I download courses for offline viewing?',
      answer:
          'Yes! You can download course materials for offline viewing. Simply tap the download icon on any course material. Downloads are available in the "My Courses" section.',
    ),
    FAQItem(
      question: 'How do I track my learning progress?',
      answer:
          'Your learning progress is automatically tracked as you complete course materials. You can view your progress in the "My Courses" section, where each course shows completion percentage and remaining materials.',
    ),
    FAQItem(
      question: 'What if I forget my password?',
      answer:
          'If you forget your password, tap "Forgot Password" on the login screen. Enter your email address and we\'ll send you a password reset link.',
    ),
    FAQItem(
      question: 'Can I get a refund for a course?',
      answer:
          'We offer a 30-day money-back guarantee for all courses. If you\'re not satisfied with your purchase, contact our support team within 30 days of purchase.',
    ),
    FAQItem(
      question: 'How do I update my profile information?',
      answer:
          'Go to the Account tab, tap "Edit Profile", and you can update your name, username, email, and profile photo.',
    ),
    FAQItem(
      question: 'Are the courses available on all devices?',
      answer:
          'Yes! TechTutor Pro works on Android and iOS devices. Your progress syncs across all your devices when you sign in with the same account.',
    ),
    FAQItem(
      question: 'How do I contact customer support?',
      answer:
          'You can contact our support team through email at support@techtutorpro.com, through the in-app chat, or by calling our support hotline.',
    ),
  ];

  final List<ContactOption> _contactOptions = [
    ContactOption(
      icon: Icons.email_outlined,
      title: 'Email Support',
      subtitle: 'Get help via email',
      action: 'support@techtutorpro.com',
      color: Colors.blue,
    ),
    ContactOption(
      icon: Icons.chat_outlined,
      title: 'Live Chat',
      subtitle: 'Chat with our support team',
      action: 'Start Chat',
      color: Colors.green,
    ),
    ContactOption(
      icon: Icons.phone_outlined,
      title: 'Phone Support',
      subtitle: 'Call us directly',
      action: '+62 895-1234-5678',
      color: Colors.orange,
    ),
    ContactOption(
      icon: Icons.schedule_outlined,
      title: 'Support Hours',
      subtitle: 'When we\'re available',
      action: 'Mon-Fri 9AM-6PM WIB',
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.pop();
          return false;
        },
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Search Section
            _buildSearchSection(),
            const SizedBox(height: 32),

            // Quick Actions
            _buildQuickActions(),
            const SizedBox(height: 32),

            // Contact Options
            _buildContactSection(),
            const SizedBox(height: 32),

            // FAQ Section
            _buildFAQSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How can we help you?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search our knowledge base or browse common questions below',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for help articles...',
              hintStyle: GoogleFonts.poppins(),
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            style: GoogleFonts.poppins(),
            onChanged: (value) {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.school_outlined,
                title: 'Course Issues',
                color: Colors.blue,
                onTap: () => _showCourseIssuesDialog(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.payment_outlined,
                title: 'Payment Help',
                color: Colors.green,
                onTap: () => _showPaymentHelpDialog(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.account_circle_outlined,
                title: 'Account Issues',
                color: Colors.orange,
                onTap: () => _showAccountIssuesDialog(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.bug_report_outlined,
                title: 'Report Bug',
                color: Colors.red,
                onTap: () => _showReportBugDialog(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Support',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._contactOptions.map((option) => _buildContactOption(option)),
      ],
    );
  }

  Widget _buildContactOption(ContactOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _handleContactOption(option),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: option.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    option.icon,
                    color: option.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        option.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 4,
                  child: Text(
                    option.action,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: option.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Asked Questions',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._faqItems.map((faq) => _buildFAQItem(faq)),
      ],
    );
  }

  Widget _buildFAQItem(FAQItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq.answer,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContactOption(ContactOption option) {
    switch (option.title) {
      case 'Email Support':
        // TODO: Open email app
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening email to ${option.action}',
                style: GoogleFonts.poppins()),
            backgroundColor: Colors.blue[400],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        break;
      case 'Live Chat':
        _showLiveChatDialog();
        break;
      case 'Phone Support':
        // TODO: Open phone app
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Calling ${option.action}', style: GoogleFonts.poppins()),
            backgroundColor: Colors.orange[400],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        break;
      case 'Support Hours':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Support hours: ${option.action}',
                style: GoogleFonts.poppins()),
            backgroundColor: Colors.purple[400],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        break;
    }
  }

  void _showLiveChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Live Chat',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Our live chat feature is currently being developed. Please use email support for immediate assistance.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showCourseIssuesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Course Issues',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Common course issues:\n\n• Videos not playing\n• Download problems\n• Progress not saving\n• Course access denied\n\nPlease contact support with specific details.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Payment Help',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Payment assistance:\n\n• Refund requests\n• Payment method issues\n• Billing questions\n• Subscription management\n\nContact our billing team for payment-related issues.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showAccountIssuesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Account Issues',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'Account-related problems:\n\n• Login issues\n• Password reset\n• Profile updates\n• Account deletion\n• Privacy concerns\n\nWe\'re here to help with any account issues.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showReportBugDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Report Bug',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
            'To report a bug, please include:\n\n• Device model and OS version\n• App version\n• Steps to reproduce\n• Screenshots if possible\n• Expected vs actual behavior\n\nEmail us at bugs@techtutorpro.com',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class ContactOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final String action;
  final Color color;

  ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.action,
    required this.color,
  });
}
