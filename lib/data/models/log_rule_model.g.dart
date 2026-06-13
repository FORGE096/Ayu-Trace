// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_rule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogRuleModelAdapter extends TypeAdapter<LogRuleModel> {
  @override
  final typeId = 0;

  @override
  LogRuleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogRuleModel(
      id: fields[0] as String,
      ruleName: fields[1] as String,
      pattern: fields[2] as String,
      severityIndex: (fields[3] as num).toInt(),
      isRegex: fields[4] as bool,
      isActive: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LogRuleModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ruleName)
      ..writeByte(2)
      ..write(obj.pattern)
      ..writeByte(3)
      ..write(obj.severityIndex)
      ..writeByte(4)
      ..write(obj.isRegex)
      ..writeByte(5)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogRuleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
