class Counter {
  int value;

  Counter({this.value = 0});

  void increment() {
    value++;
  }

  @override
  String toString() {
    return 'Counter{value: $value}';
  }
}