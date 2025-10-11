import 'package:flutter/material.dart';
import 'package:ourdeen/features/shared/widgets/arabic_verse_widget.dart';
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

  final ValueNotifier<bool> visibilityBottomNavNotifier = ValueNotifier<bool>(
    true,
  );

  var bodyScrollController = ScrollController();

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
      'arabic': 'إِنَّا فَتَحْنَا لَكَ فَتْحًۭا مُّبِينًۭا',
      'translation': 'Indeed, We have granted you a clear triumph O Prophet',
    },
    {
      'arabic':
          'لِّيَغْفِرَ لَكَ ٱللَّهُ مَا تَقَدَّمَ مِن ذَنۢبِكَ وَمَا تَأَخَّرَ وَيُتِمَّ نِعْمَتَهُۥ عَلَيْكَ وَيَهْدِيَكَ صِرَٰطًۭا مُّسْتَقِيمًۭا',
      'translation':
          'so that Allah may forgive you for your past and future shortcomings,1 perfect His favour upon you, guide you along the Straight Path,',
    },
    {
      'arabic': 'وَيَنصُرَكَ ٱللَّهُ نَصْرًا عَزِيزًا',
      'translation': 'and so that Allah will help you tremendously',
    },
  ];

  double lastOffset = 0.0;
  double sensitivityThreshold = 20.0;

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

  double lastScrollOffset = 0.0;
  bool isScrollingDown = false;
  bool isScrollingUp = false;
  static const double scrollThreshold = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            final currentOffset = notification.metrics.pixels;
            final scrollDirection = currentOffset - lastScrollOffset;

            if (scrollDirection > scrollThreshold) {
              // Scrolling down - hide bottom nav
              showOrHideBottomNav(false);
              isScrollingDown = true;
              isScrollingUp = false;
            } else if (scrollDirection < -scrollThreshold) {
              // Scrolling up - show bottom nav
              showOrHideBottomNav(true);
              isScrollingDown = false;
              isScrollingUp = true;
            }

            lastScrollOffset = currentOffset;
          }
          return true;
        },
        child: CustomScrollView(
          controller: bodyScrollController,
          slivers: [
            SliverAppBar(
              pinned: true,

              /// expandedHeight it is 150
              expandedHeight: 150.0,
              // snap: true,
              // floating: true,
              /// collapsedHeight and add 16 to make space between leading back navigation and progress bar.
              collapsedHeight: kToolbarHeight + 16,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
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
                      // Surah info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Surah ${widget.surahNumber}:${widget.startVerse}-${widget.endVerse} (${_currentStep + 1})',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: TransformByGestured(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Current verse display
                        Expanded(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: ArabicVerseWidget(
                                verseText: _verses[_currentStep],
                                translation: _translations[_currentStep],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24.0,
                                  horizontal: 16.0,
                                ),
                                maxWidth: 700.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigation(
        currentStep: _currentStep,
        previousStep: _previousStep,
        nextStep: _nextStep,
        verses: _verses,
        visibilityNotifier: visibilityBottomNavNotifier,
      ),
    );
  }

  Future<void> showOrHideBottomNav(bool shouldShow) async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (shouldShow) {
      visibilityBottomNavNotifier.value = true;
    } else {
      visibilityBottomNavNotifier.value = false;
    }
  }
}

class TransformByGestured extends StatefulWidget {
  const TransformByGestured({super.key, required this.child});
  final Widget child;

  @override
  State<TransformByGestured> createState() => _State();
}

class _State extends State<TransformByGestured> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  double _dragStartX = 0;
  double _currentPosition = 0;
  double _currentPositionY = 0;
  double _dragStartY = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
    _dragStartY = details.globalPosition.dy;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentPosition = details.globalPosition.dx - _dragStartX;
      _currentPositionY = details.globalPosition.dy - _dragStartY;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Threshold for swipe action
    const threshold = 50.0;

    if (_currentPosition.abs() > threshold) {
      // Swipe detected
      if (_currentPosition > 0) {
        // Swiped right
        _animateToPosition(300); // Move off screen right
        print('Swiped right');
      } else {
        // Swiped left
        _animateToPosition(-300); // Move off screen left
        print('Swiped left');
      }
    } else {
      // Return to original position
      _animateToPosition(0);
    }
  }

  void _animateToPosition(double targetPosition) {
    _animationController.animateTo(
      targetPosition.abs() / 300,
      duration: Duration(milliseconds: 300),
    ).then((_) {
      if (targetPosition != 0) {
        // Card was swiped away, replace with new card
        setState(() {
          _currentPosition = 0;
          _currentPositionY = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(offset: Offset(_currentPosition, _currentPositionY),
      child: widget.child),
    );
  }
}


class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    required this.currentStep,
    required this.previousStep,
    required this.nextStep,
    required this.verses,
    required this.visibilityNotifier,
  });
  final int currentStep;
  final VoidCallback previousStep;
  final VoidCallback nextStep;
  final List<String> verses;
  final ValueNotifier<bool> visibilityNotifier;

  static const double _buttonHeightVisible = 90.0;
  static const double _buttonHeightHidden = 0.0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: visibilityNotifier,
      builder: (context, isVisible, child) {
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          duration: const Duration(milliseconds: 300),
          height: isVisible ? _buttonHeightVisible : _buttonHeightHidden,
          child: child,
        );
      },
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: currentStep > 0 ? previousStep : null,
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
                onPressed: nextStep,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: currentStep < verses.length - 1
                    ? const Text('Next')
                    : const Text('Complete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
