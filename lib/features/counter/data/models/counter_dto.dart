class CounterDto {
  final int value;

  CounterDto({required this.value});

  factory CounterDto.fromJson(Map<String, dynamic> json) {
    return CounterDto(
      value: json['value'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  @override
  String toString() {
    return 'CounterDto{value: $value}';
  }
}