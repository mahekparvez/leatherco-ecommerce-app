import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sticky_header.dart';
import '../widgets/footer.dart';
import '../utils/app_theme.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // Sticky header with announcement bar and navigation
              const StickyHeader(),
              
              // Main content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Contact content
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                fontSize: 32,
                                fontWeight: FontWeight.w300,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingL),
                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Contact form
                                Expanded(
                                  flex: 2,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Send us a message',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: AppTheme.spacingL),
                                        
                                        // Name field
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppTheme.spacingM),
                                        
                                        // Email field
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            if (!value.contains('@')) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppTheme.spacingM),
                                        
                                        // Subject field
                                        TextFormField(
                                          controller: _subjectController,
                                          decoration: const InputDecoration(
                                            labelText: 'Subject',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a subject';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppTheme.spacingM),
                                        
                                        // Message field
                                        TextFormField(
                                          controller: _messageController,
                                          decoration: const InputDecoration(
                                            labelText: 'Message',
                                            border: OutlineInputBorder(),
                                          ),
                                          maxLines: 5,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a message';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: AppTheme.spacingL),
                                        
                                        // Submit button
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: _isSubmitting ? null : _submitForm,
                                            child: _isSubmitting
                                                ? const CircularProgressIndicator()
                                                : const Text('Send Message'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(width: AppTheme.spacingXL),
                                
                                // Contact info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Get in touch',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingL),
                                      
                                      const Text(
                                        'We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: AppTheme.textSecondary,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingXL),
                                      
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingS),
                                      const Text(
                                        'hello@leatherology.com',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingL),
                                      
                                      const Text(
                                        'Phone',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingS),
                                      const Text(
                                        '+1 (555) 123-4567',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingL),
                                      
                                      const Text(
                                        'Address',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: AppTheme.spacingS),
                                      const Text(
                                        '123 Leather Street\nSan Francisco, CA 94102',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Footer
                      const CustomFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully! We\'ll get back to you soon.'),
        ),
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending message. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }
}
