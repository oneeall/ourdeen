import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';

class MemorizationSessionView extends StatefulWidget {
  final int sessionId;
  final int surahNumber;
  final int startVerse;
  final int endVerse;

  const MemorizationSessionView({
    super.key,
    required this.sessionId,
    required this.surahNumber,
    required this.startVerse,
    required this.endVerse,
  });

  @override
  State<MemorizationSessionView> createState() =>
      _MemorizationSessionViewState();
}

class _MemorizationSessionViewState extends State<MemorizationSessionView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  double _progress = 0.0;
  int _currentStep = 0;
  List<String> _verses = [];
  List<String> _translations = [];

  final List<Map<String, String>> _surahData = [
    // Surah Al-Fatihah (QS 1:1-7)
    {
      'arabic': 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      'translation':
          'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
    },
    {
      'arabic': 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
      'translation': '[All] praise is [due] to Allah, Lord of the worlds -',
    },
    {
      'arabic': 'الرَّحْمَٰنِ الرَّحِيمِ',
      'translation': 'The Entirely Merciful, the Especially Merciful,',
    },
    {
      'arabic': 'مَالِكِ يَوْمِ الدِّينِ',
      'translation': 'Sovereign of the Day of Recompense.',
    },
    {
      'arabic': 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
      'translation': 'It is You we worship and You we ask for help.',
    },
    {
      'arabic': 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      'translation': 'Guide us to the straight path -',
    },
    {
      'arabic':
          'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
      'translation':
          'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.',
    },
    // Surah Al-Ikhlas (QS 112:1-4)
    {
      'arabic': 'قُلْ هُوَ اللَّهُ أَحَدٌ',
      'translation': 'Say, "He is Allah, [who is] One,',
    },
    {
      'arabic': 'اللَّهُ الصَّمَدُ',
      'translation': 'Allah, the Eternal Refuge.',
    },
    {
      'arabic': 'لَمْ يَلِدْ وَلَمْ يُولَدْ',
      'translation': 'He neither begets nor is born,',
    },
    {
      'arabic': 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
      'translation': 'Nor is there to Him any equivalent."',
    },
    // Surat Al-Fath (QS 48 : 1-3)
    {
      'arabic': 'إِنَّا فَتَحْنَا لَكَ فَتْحًۭا مُّبِينًۭا',
      'translation': 'Indeed, We have granted you a clear triumph O Prophet',
    },
    {
      'arabic':
          'لِّيَغْفِرَ لَكَ ٱللَّهُ مَا تَقَدَّمَ مِن ذَنۢبِكَ وَمَا تَأَخَّرَ وَيُتِمَّ نِعْمَتَهُۥ عَلَيْكَ وَيَهْدِيَكَ صِرَٰطًۭا مُّسْتَقِيمًۭا',
      'translation':
          'so that Allah may forgive you for your past and future shortcomings,1 perfect His favour upon you, guide you along the Straight Path,',
    },
    {
      'arabic': 'وَيَنصُرَكَ ٱللَّهُ نَصْرًا عَزِيزًا',
      'translation': 'and so that Allah will help you tremendously',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _loadVerses();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadVerses() {
    // Determine which surah and verses to load
    if (widget.surahNumber == 1 &&
        widget.startVerse == 1 &&
        widget.endVerse == 7) {
      // Surah Al-Fatihah
      _verses = _surahData.sublist(0, 7).map((v) => v['arabic']!).toList();
      _translations = _surahData
          .sublist(0, 7)
          .map((v) => v['translation']!)
          .toList();
    } else if (widget.surahNumber == 112 &&
        widget.startVerse == 1 &&
        widget.endVerse == 4) {
      // Surah Al-Ikhlas
      _verses = _surahData.sublist(7, 11).map((v) => v['arabic']!).toList();
      _translations = _surahData
          .sublist(7, 11)
          .map((v) => v['translation']!)
          .toList();
    } else {
      // Default to Al-Fatihah if not found
      _verses = _surahData.sublist(11, 14).map((v) => v['arabic']!).toList();
      _translations = _surahData
          .sublist(11, 14)
          .map((v) => v['translation']!)
          .toList();
    }

    _progress = 1.0 / _verses.length;
    _controller.forward();
  }

  void _nextStep() {
    if (_currentStep < _verses.length - 1) {
      setState(() {
        _currentStep++;
        _progress = (_currentStep + 1) / _verses.length;
        _controller.reset();
        _controller.forward();
      });
    } else {
      // Session completed
      _showCompletionDialog();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _progress = (_currentStep + 1) / _verses.length;
        _controller.reset();
        _controller.forward();
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Congratulations!'),
          content: const Text('You have completed memorizing this section.'),
          actions: [
            TextButton(
              onPressed: () {
                /// TODO : set proper navigation rather than double call navigator pop
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to memorizing view
              },
              child: const Text('Return to Sessions'),
            ),
          ],
        );
      },
    );

    // Update progress in viewmodel
    final viewModel = Provider.of<MemorizingViewModel>(context, listen: false);
    viewModel.updateProgress(widget.sessionId, 1.0);
    viewModel.incrementStreak(widget.sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with back button and progress
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey[300],
                      color: Theme.of(context).colorScheme.primary,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Surah info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Surah ${widget.surahNumber}:${widget.startVerse}-${widget.endVerse} (${_currentStep + 1})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // Current verse display
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Arabic verse
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          _verses[_currentStep],
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'Amiri',
                            height: 2.2,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black87,
                            shadows:
                                Theme.of(context).brightness ==
                                    Brightness.dark
                                ? [
                                    Shadow(
                                      color: Colors.black54,
                                      offset: Offset(1.5, 1.5),
                                      blurRadius: 3,
                                    ),
                                    Shadow(
                                      color: Colors.white24,
                                      offset: Offset(0, 0),
                                      blurRadius: 4,
                                    ),
                                  ]
                                : [
                                    Shadow(
                                      color: Colors.black26,
                                      offset: Offset(1.5, 1.5),
                                      blurRadius: 3,
                                    ),
                                    Shadow(
                                      color: Colors.white70,
                                      offset: Offset(0, 0),
                                      blurRadius: 4,
                                    ),
                                  ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Divider for cognitive separation
                      Container(
                        width: 60,
                        height: 2,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.white24
                            : Colors.black26,
                      ),

                      const SizedBox(height: 20),

                      // Translation
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(
                          _translations[_currentStep],
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                height: 1.6,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Navigation buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _currentStep < _verses.length - 1
                          ? const Text('Next')
                          : const Text('Complete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
