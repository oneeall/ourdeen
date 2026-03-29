import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Represents the calculated metrics for memorization progress
/// This is a value object that holds all progress-related calculations
class MemorizationMetrics extends Equatable {
  final double weightedProgress;
  final int totalVerses;
  final int totalStreak;
  final String estimatedDays;
  final ProgressLevel progressLevel;
  final int percentage;

  const MemorizationMetrics({
    required this.weightedProgress,
    required this.totalVerses,
    required this.totalStreak,
    required this.estimatedDays,
    required this.progressLevel,
    required this.percentage,
  });

  @override
  List<Object?> get props => [
        weightedProgress,
        totalVerses,
        totalStreak,
        estimatedDays,
        progressLevel,
        percentage,
      ];

  /// Creates a copy with updated values
  MemorizationMetrics copyWith({
    double? weightedProgress,
    int? totalVerses,
    int? totalStreak,
    String? estimatedDays,
    ProgressLevel? progressLevel,
    int? percentage,
  }) {
    return MemorizationMetrics(
      weightedProgress: weightedProgress ?? this.weightedProgress,
      totalVerses: totalVerses ?? this.totalVerses,
      totalStreak: totalStreak ?? this.totalStreak,
      estimatedDays: estimatedDays ?? this.estimatedDays,
      progressLevel: progressLevel ?? this.progressLevel,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  String toString() {
    return 'MemorizationMetrics('
        'weightedProgress: $weightedProgress, '
        'totalVerses: $totalVerses, '
        'totalStreak: $totalStreak, '
        'estimatedDays: $estimatedDays, '
        'progressLevel: $progressLevel, '
        'percentage: $percentage'
        ')';
  }
}

/// Represents the different levels of memorization progress
enum ProgressLevel {
  justStarted,
  buildingFoundation,
  makingProgress,
  halfwayThere,
  almostThere,
  nearlyMastered,
  memorizationMaster;

  /// Gets the progress level based on percentage
  static ProgressLevel fromPercentage(int percentage) {
    if (percentage <= 15) return ProgressLevel.justStarted;
    if (percentage <= 30) return ProgressLevel.buildingFoundation;
    if (percentage <= 50) return ProgressLevel.makingProgress;
    if (percentage <= 70) return ProgressLevel.halfwayThere;
    if (percentage <= 85) return ProgressLevel.almostThere;
    if (percentage <= 95) return ProgressLevel.nearlyMastered;
    return ProgressLevel.memorizationMaster;
  }

  /// Gets the visual representation data for this level
  ProgressLevelData get data {
    switch (this) {
      case ProgressLevel.justStarted:
        return ProgressLevelData(
          emoji: '🌱',
          title: 'Just Started',
          subtitle: 'Every verse counts',
          color: Colors.green,
          startColor: Colors.green.withValues(alpha: 0.6),
          endColor: Colors.green,
        );
      case ProgressLevel.buildingFoundation:
        return ProgressLevelData(
          emoji: '📚',
          title: 'Building Foundation',
          subtitle: 'Consistency is key',
          color: Colors.blue,
          startColor: Colors.blue.withValues(alpha: 0.6),
          endColor: Colors.blue,
        );
      case ProgressLevel.makingProgress:
        return ProgressLevelData(
          emoji: '📈',
          title: 'Making Progress',
          subtitle: 'Keep up the great work!',
          color: Colors.orange,
          startColor: Colors.orange.withValues(alpha: 0.6),
          endColor: Colors.orange,
        );
      case ProgressLevel.halfwayThere:
        return ProgressLevelData(
          emoji: '⭐',
          title: 'Halfway There',
          subtitle: 'You\'re doing amazing!',
          color: Colors.purple,
          startColor: Colors.purple.withValues(alpha: 0.6),
          endColor: Colors.purple,
        );
      case ProgressLevel.almostThere:
        return ProgressLevelData(
          emoji: '🏃‍♂️',
          title: 'Almost There',
          subtitle: 'Final stretch ahead!',
          color: Colors.red,
          startColor: Colors.red.withValues(alpha: 0.6),
          endColor: Colors.red,
        );
      case ProgressLevel.nearlyMastered:
        return ProgressLevelData(
          emoji: '🔥',
          title: 'Nearly Mastered',
          subtitle: 'Excellence in sight!',
          color: Colors.deepOrange,
          startColor: Colors.deepOrange.withValues(alpha: 0.6),
          endColor: Colors.deepOrange,
        );
      case ProgressLevel.memorizationMaster:
        return ProgressLevelData(
          emoji: '👑',
          title: 'Memorization Master',
          subtitle: 'Masha Allah! Incredible achievement!',
          color: Colors.amber,
          startColor: Colors.amber.withValues(alpha: 0.6),
          endColor: Colors.amber,
        );
    }
  }
}

/// Visual representation data for a progress level
class ProgressLevelData extends Equatable {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final Color startColor;
  final Color endColor;

  const ProgressLevelData({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.startColor,
    required this.endColor,
  });

  @override
  List<Object?> get props => [emoji, title, subtitle, color, startColor, endColor];

  Map<String, dynamic> toMap() {
    return {
      'emoji': emoji,
      'title': title,
      'subtitle': subtitle,
      'color': color,
      'startColor': startColor,
      'endColor': endColor,
    };
  }
}