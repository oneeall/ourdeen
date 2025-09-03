import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_reader_viewmodel.dart';
import 'package:ourdeen/core/theme/theme.dart';

class QuranReaderView extends StatefulWidget {
  const QuranReaderView({super.key});

  @override
  State<QuranReaderView> createState() => _QuranReaderViewState();
}

class _QuranReaderViewState extends State<QuranReaderView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // Spring-like animation
    );
    
    // Start the animation when the view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuranReaderViewModel>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with title
              ScaleTransition(
                scale: _animation,
                child: Text(
                  'Surah Al-Fatihah',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              
              // Loading indicator or content
              if (viewModel.isLoading) ...[
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ] else ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.verses.length,
                    itemBuilder: (context, index) {
                      final verse = viewModel.verses[index];
                      // Calculate staggered animation delays
                      final totalItems = viewModel.verses.length;
                      final startDelay = totalItems > 1 ? index / (totalItems - 1) * 0.5 : 0.0;
                      final endDelay = startDelay + 0.5 > 1.0 ? 1.0 : startDelay + 0.5;
                      
                      return ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: Interval(
                              startDelay,
                              endDelay,
                              curve: Curves.elasticOut,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Column(
                            children: [
                              // Arabic text with special styling
                              Text(
                                verse.arabicText,
                                style: MaterialTheme.arabicTextStyle.copyWith(
                                  fontSize: 32,
                                  height: 2.2,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(2, 2),
                                      blurRadius: 4.0,
                                      color: Colors.black.withValues(alpha: 0.1,),
                                    ),
                                  ]
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              // Translation text
                              Text(
                                verse.translation,
                                style: MaterialTheme.accessibleBodyStyle.copyWith(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}