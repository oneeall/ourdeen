import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ourdeen/features/shared/widgets/arabic_verse_widget.dart';
import 'package:ourdeen/features/shared/widgets/floating_bar_action_button.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';


class FullScreenMemorizationWidget extends StatefulWidget {
  final String verse;
  final String translation;
  final int recitationCount;
  final bool showRecitationCounter;
  final VoidCallback onExit;
  final VoidCallback onRecite;
  final Function(DragEndDetails) onSwipe;

  const FullScreenMemorizationWidget({
    super.key,
    required this.verse,
    required this.translation,
    required this.recitationCount,
    required this.showRecitationCounter,
    required this.onExit,
    required this.onRecite,
    required this.onSwipe,
  });

  @override
  State<FullScreenMemorizationWidget> createState() => _FullScreenMemorizationWidgetState();
}

class _FullScreenMemorizationWidgetState extends State<FullScreenMemorizationWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Modern dark blue background
      body: Stack(
        children: [
          // Gradient background overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0F172A).withOpacity(0.8),
                  const Color(0xFF1E293B).withOpacity(0.9),
                  const Color(0xFF0F172A).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Full screen verse display
          GestureDetector(
            onTap: widget.onExit,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Main Arabic verse with modern styling
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Container(
                                  padding: const EdgeInsets.all(28.0),
                                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B).withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFF64748B).withOpacity(0.3),
                                      width: 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF0EA5E9).withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    widget.verse,
                                    style: GoogleFonts.amiri(
                                      fontSize: 36.0,
                                      color: Colors.white,
                                      height: 2.2,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(2.0, 2.0),
                                          blurRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                            // Translation with modern styling
                            if (widget.translation.isNotEmpty)
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Container(
                                    padding: const EdgeInsets.all(20.0),
                                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E293B).withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFF64748B).withOpacity(0.2),
                                        width: 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      widget.translation,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 20.0,
                                        color: const Color(0xFFE2E8F0),
                                        height: 1.7,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Modern recitation counter with enhanced animation
          if (widget.showRecitationCounter)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  top: 70,
                  right: 24,
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                      ),
                    ),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.65, 1.0, curve: Curves.elasticOut),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0EA5E9),
                              Color(0xFF38BDF8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0EA5E9).withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mic_external_on_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${widget.recitationCount}',
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Recitations',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          
          // Animated exit button
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                top: 70,
                left: 24,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF64748B).withOpacity(0.4),
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 28),
                      onPressed: widget.onExit,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Animated recite instruction indicator at bottom
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.tap_and_play_outlined,
                          color: const Color(0xFF94A3B8).withOpacity(0.7),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tap anywhere to recite',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: const Color(0xFF94A3B8).withOpacity(0.7),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Tap to recite overlay with ripple effect
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Trigger ripple animation
                widget.onRecite();
              },
              onPanEnd: widget.onSwipe,
              child: Container(
                color: Colors.transparent, // Makes the overlay clickable
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransformByGestured extends StatefulWidget {
  const TransformByGestured({super.key, required this.child});

  final Widget child;

  @override
  State<TransformByGestured> createState() => _State();
}

class _State extends State<TransformByGestured>
    with SingleTickerProviderStateMixin {
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
    _animationController
        .animateTo(
      targetPosition.abs() / 300,
      duration: Duration(milliseconds: 300),
    )
        .then((_) {
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
      child: Transform.translate(
        offset: Offset(_currentPosition, _currentPositionY),
        child: widget.child,
      ),
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
    this.isFullScreenMode = false,
  });

  final int currentStep;
  final VoidCallback previousStep;
  final VoidCallback nextStep;
  final List<String> verses;
  final ValueNotifier<bool> visibilityNotifier;
  final bool isFullScreenMode;

  static const double _buttonHeightVisible = 90.0;
  static const double _buttonHeightHidden = 0.0;

  @override
  Widget build(BuildContext context) {
    if (isFullScreenMode) {
      // Return an empty container when in full-screen mode
      return Container(height: 0);
    }

    return ValueListenableBuilder<bool>(
      valueListenable: visibilityNotifier,
      builder: (context, isVisible, child) {
        return AnimatedContainer(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
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

  // Full-screen mode state
  bool _isFullScreenMode = false;
  int _recitationCount = 0;
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

  bool _showRecitationCounter = false;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    if (_isFullScreenMode) {
      // Full-screen mode UI
      return FullScreenMemorizationWidget(
        verse: _verses[_currentStep],
        translation: _translations[_currentStep],
        recitationCount: _recitationCount,
        showRecitationCounter: _showRecitationCounter,
        onExit: _exitFullScreenMode,
        onRecite: _incrementRecitationCount,
        onSwipe: _handleSwipeGesture,
      );
    } else {
      // Normal view
      return Scaffold(
        key: _scaffoldKey,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            /// TODO : turns out I think no need auto collapse while scrolling the verse because now there is floating button that can handle it.
            // if (notification is ScrollUpdateNotification) {
            //   final currentOffset = notification.metrics.pixels;
            //   final scrollDirection = currentOffset - lastScrollOffset;
            //
            //   if (scrollDirection > scrollThreshold) {
            //     // Scrolling down - hide bottom nav
            //     showOrHideBottomNav(false);
            //     isScrollingDown = true;
            //     isScrollingUp = false;
            //   } else if (scrollDirection < -scrollThreshold) {
            //     // Scrolling up - show bottom nav
            //     showOrHideBottomNav(true);
            //     isScrollingDown = false;
            //     isScrollingUp = true;
            //   }
            //
            //   lastScrollOffset = currentOffset;
            // }
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
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(_progress * 100).toInt()}%',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ],
                        ),
                        // Surah info
                        GestureDetector(
                          onTap: () {
                            // This function triggers the bottom sheet and our custom scrim
                            _scaffoldKey.currentState?.showBottomSheet((
                                BuildContext context,) {
                              return SizedBox(
                                height: 250,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      const Text(
                                          'This is the bottom sheet!'),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        child: const Text('Close'),
                                        onPressed: () =>
                                            Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(
                                context,
                              )
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Surah ${widget.surahNumber}:${widget
                                  .startVerse}-${widget
                                  .endVerse} (${_currentStep + 1})',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
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
                  child: Visibility(
                    visible: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Current verse display
                        Expanded(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
        ),
        floatingActionButton: Padding( padding:  EdgeInsets.only(bottom: 18.0),child: FloatingBarActionButton()),
        // floatingActionButton: _floatingActionBuild(
        //   context,
        //   visibilityBottomNavNotifier,
        //   isFullScreenMode: _isFullScreenMode,
        //   onPressed: _toggleFullScreenMode,
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: _BottomNavigation(
        //   currentStep: _currentStep,
        //   previousStep: _previousStep,
        //   nextStep: _nextStep,
        //   verses: _verses,
        //   visibilityNotifier: visibilityBottomNavNotifier,
        //   isFullScreenMode: _isFullScreenMode, // Pass full screen mode state
        // ),
      );
    }
  }

  // This is our custom scrim builder function
  Widget _buildScrim(BuildContext context, Animation<double> animation) {
    // We use a FadeTransition to animate the scrim's opacity.
    return ScaleTransition(
      scale: animation,
      // Use a GestureDetector to dismiss the bottom sheet when the scrim is tapped.
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(200, 76, 175, 80), // Opaque Green in the center
                Colors.redAccent, // Transparent on the edges
              ],
              radius: 1.5, // Make the gradient spread out
              center: Alignment(0.0, 0.5), // Center it slightly lower
            ),
          ),
        ),
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

  void _toggleFullScreenMode() {
    setState(() {
      _isFullScreenMode = !_isFullScreenMode;
      if (_isFullScreenMode) {
        // Initialize recitation counter when entering full-screen mode
        _recitationCount = 0;
        _showRecitationCounter = true;
      }
    });
  }

  void _exitFullScreenMode() {
    setState(() {
      _isFullScreenMode = false;
    });
  }

  void _incrementRecitationCount() {
    if (_isFullScreenMode) {
      setState(() {
        _recitationCount++;
        // Show animation feedback
        _showRecitationCounter = true;
      });

      // Hide the counter after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (_isFullScreenMode && mounted) {
          setState(() {
            _showRecitationCounter = false;
          });
        }
      });
    }
  }

  void _handleSwipeGesture(DragEndDetails details) {
    if (_isFullScreenMode) {
      // Check if it's a horizontal swipe
      if (details.velocity.pixelsPerSecond.dx > 300) {
        // Swipe right - go to previous verse
        _previousStep();
      } else if (details.velocity.pixelsPerSecond.dx < -300) {
        // Swipe left - go to next verse
        _nextStep();
      }
      // Check if it's a vertical swipe
      else if (details.velocity.pixelsPerSecond.dy > 300) {
        // Swipe down - exit full screen
        _exitFullScreenMode();
      } else if (details.velocity.pixelsPerSecond.dy < -300) {
        // Swipe up - increment recitation
        _incrementRecitationCount();
      }
    }
  }


  Widget? _floatingActionBuild(BuildContext context,
      ValueNotifier<bool> visibilityBottomNavNotifier, {
        required VoidCallback onPressed,
        bool isFullScreenMode = false,
      }) {
    return AnimatedBuilder(
      animation: Listenable.merge([visibilityBottomNavNotifier]),
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: visibilityBottomNavNotifier.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFullScreenMode ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}