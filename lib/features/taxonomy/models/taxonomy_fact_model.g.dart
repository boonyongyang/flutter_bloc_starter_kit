// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxonomy_fact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaxonomyFactAdapter extends TypeAdapter<TaxonomyFact> {
  @override
  final int typeId = 2;

  @override
  TaxonomyFact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaxonomyFact(
      description: fields[0] as String,
      funFacts: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaxonomyFact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.funFacts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxonomyFactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaxonomyTypeAdapter extends TypeAdapter<TaxonomyType> {
  @override
  final int typeId = 3;

  @override
  TaxonomyType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaxonomyType(
      family: (fields[0] as Map).cast<String, TaxonomyFact>(),
      genus: (fields[1] as Map).cast<String, TaxonomyFact>(),
      order: (fields[2] as Map).cast<String, TaxonomyFact>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaxonomyType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.family)
      ..writeByte(1)
      ..write(obj.genus)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxonomyTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
