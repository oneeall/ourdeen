import 'package:ourdeen/features/counter/data/models/counter_dto.dart';
import 'package:ourdeen/features/counter/domain/entities/counter.dart';

class CounterMapper {
  static Counter toEntity(CounterDto dto) {
    return Counter(value: dto.value);
  }

  static CounterDto toDto(Counter entity) {
    return CounterDto(value: entity.value);
  }
}