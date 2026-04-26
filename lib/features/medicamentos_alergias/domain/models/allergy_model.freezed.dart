// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AllergyModel {

 String get id; String get pacienteId;// El agente usa la misma base de datos de medicamentos (PB-20 criterio 4)
 String get agenteCausante; ReactionType get tipoReaccion; AllergySeverity get severidad; AllergyStatus get estado; DateTime? get fechaDiagnostico; String? get observaciones; DateTime? get creadoEn; String? get creadoPor;
/// Create a copy of AllergyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllergyModelCopyWith<AllergyModel> get copyWith => _$AllergyModelCopyWithImpl<AllergyModel>(this as AllergyModel, _$identity);

  /// Serializes this AllergyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllergyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.tipoReaccion, tipoReaccion) || other.tipoReaccion == tipoReaccion)&&(identical(other.severidad, severidad) || other.severidad == severidad)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.fechaDiagnostico, fechaDiagnostico) || other.fechaDiagnostico == fechaDiagnostico)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.creadoPor, creadoPor) || other.creadoPor == creadoPor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,agenteCausante,tipoReaccion,severidad,estado,fechaDiagnostico,observaciones,creadoEn,creadoPor);

@override
String toString() {
  return 'AllergyModel(id: $id, pacienteId: $pacienteId, agenteCausante: $agenteCausante, tipoReaccion: $tipoReaccion, severidad: $severidad, estado: $estado, fechaDiagnostico: $fechaDiagnostico, observaciones: $observaciones, creadoEn: $creadoEn, creadoPor: $creadoPor)';
}


}

/// @nodoc
abstract mixin class $AllergyModelCopyWith<$Res>  {
  factory $AllergyModelCopyWith(AllergyModel value, $Res Function(AllergyModel) _then) = _$AllergyModelCopyWithImpl;
@useResult
$Res call({
 String id, String pacienteId, String agenteCausante, ReactionType tipoReaccion, AllergySeverity severidad, AllergyStatus estado, DateTime? fechaDiagnostico, String? observaciones, DateTime? creadoEn, String? creadoPor
});




}
/// @nodoc
class _$AllergyModelCopyWithImpl<$Res>
    implements $AllergyModelCopyWith<$Res> {
  _$AllergyModelCopyWithImpl(this._self, this._then);

  final AllergyModel _self;
  final $Res Function(AllergyModel) _then;

/// Create a copy of AllergyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pacienteId = null,Object? agenteCausante = null,Object? tipoReaccion = null,Object? severidad = null,Object? estado = null,Object? fechaDiagnostico = freezed,Object? observaciones = freezed,Object? creadoEn = freezed,Object? creadoPor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,agenteCausante: null == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String,tipoReaccion: null == tipoReaccion ? _self.tipoReaccion : tipoReaccion // ignore: cast_nullable_to_non_nullable
as ReactionType,severidad: null == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as AllergySeverity,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as AllergyStatus,fechaDiagnostico: freezed == fechaDiagnostico ? _self.fechaDiagnostico : fechaDiagnostico // ignore: cast_nullable_to_non_nullable
as DateTime?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,creadoPor: freezed == creadoPor ? _self.creadoPor : creadoPor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AllergyModel].
extension AllergyModelPatterns on AllergyModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllergyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllergyModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllergyModel value)  $default,){
final _that = this;
switch (_that) {
case _AllergyModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllergyModel value)?  $default,){
final _that = this;
switch (_that) {
case _AllergyModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  AllergyStatus estado,  DateTime? fechaDiagnostico,  String? observaciones,  DateTime? creadoEn,  String? creadoPor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllergyModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.estado,_that.fechaDiagnostico,_that.observaciones,_that.creadoEn,_that.creadoPor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  AllergyStatus estado,  DateTime? fechaDiagnostico,  String? observaciones,  DateTime? creadoEn,  String? creadoPor)  $default,) {final _that = this;
switch (_that) {
case _AllergyModel():
return $default(_that.id,_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.estado,_that.fechaDiagnostico,_that.observaciones,_that.creadoEn,_that.creadoPor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  AllergyStatus estado,  DateTime? fechaDiagnostico,  String? observaciones,  DateTime? creadoEn,  String? creadoPor)?  $default,) {final _that = this;
switch (_that) {
case _AllergyModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.estado,_that.fechaDiagnostico,_that.observaciones,_that.creadoEn,_that.creadoPor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllergyModel extends AllergyModel {
  const _AllergyModel({required this.id, required this.pacienteId, required this.agenteCausante, required this.tipoReaccion, required this.severidad, this.estado = AllergyStatus.activa, this.fechaDiagnostico, this.observaciones, this.creadoEn, this.creadoPor}): super._();
  factory _AllergyModel.fromJson(Map<String, dynamic> json) => _$AllergyModelFromJson(json);

@override final  String id;
@override final  String pacienteId;
// El agente usa la misma base de datos de medicamentos (PB-20 criterio 4)
@override final  String agenteCausante;
@override final  ReactionType tipoReaccion;
@override final  AllergySeverity severidad;
@override@JsonKey() final  AllergyStatus estado;
@override final  DateTime? fechaDiagnostico;
@override final  String? observaciones;
@override final  DateTime? creadoEn;
@override final  String? creadoPor;

/// Create a copy of AllergyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllergyModelCopyWith<_AllergyModel> get copyWith => __$AllergyModelCopyWithImpl<_AllergyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllergyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllergyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.tipoReaccion, tipoReaccion) || other.tipoReaccion == tipoReaccion)&&(identical(other.severidad, severidad) || other.severidad == severidad)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.fechaDiagnostico, fechaDiagnostico) || other.fechaDiagnostico == fechaDiagnostico)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.creadoPor, creadoPor) || other.creadoPor == creadoPor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,agenteCausante,tipoReaccion,severidad,estado,fechaDiagnostico,observaciones,creadoEn,creadoPor);

@override
String toString() {
  return 'AllergyModel(id: $id, pacienteId: $pacienteId, agenteCausante: $agenteCausante, tipoReaccion: $tipoReaccion, severidad: $severidad, estado: $estado, fechaDiagnostico: $fechaDiagnostico, observaciones: $observaciones, creadoEn: $creadoEn, creadoPor: $creadoPor)';
}


}

/// @nodoc
abstract mixin class _$AllergyModelCopyWith<$Res> implements $AllergyModelCopyWith<$Res> {
  factory _$AllergyModelCopyWith(_AllergyModel value, $Res Function(_AllergyModel) _then) = __$AllergyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String pacienteId, String agenteCausante, ReactionType tipoReaccion, AllergySeverity severidad, AllergyStatus estado, DateTime? fechaDiagnostico, String? observaciones, DateTime? creadoEn, String? creadoPor
});




}
/// @nodoc
class __$AllergyModelCopyWithImpl<$Res>
    implements _$AllergyModelCopyWith<$Res> {
  __$AllergyModelCopyWithImpl(this._self, this._then);

  final _AllergyModel _self;
  final $Res Function(_AllergyModel) _then;

/// Create a copy of AllergyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pacienteId = null,Object? agenteCausante = null,Object? tipoReaccion = null,Object? severidad = null,Object? estado = null,Object? fechaDiagnostico = freezed,Object? observaciones = freezed,Object? creadoEn = freezed,Object? creadoPor = freezed,}) {
  return _then(_AllergyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,agenteCausante: null == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String,tipoReaccion: null == tipoReaccion ? _self.tipoReaccion : tipoReaccion // ignore: cast_nullable_to_non_nullable
as ReactionType,severidad: null == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as AllergySeverity,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as AllergyStatus,fechaDiagnostico: freezed == fechaDiagnostico ? _self.fechaDiagnostico : fechaDiagnostico // ignore: cast_nullable_to_non_nullable
as DateTime?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,creadoPor: freezed == creadoPor ? _self.creadoPor : creadoPor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreateAllergyRequest {

 String get pacienteId; String get agenteCausante; ReactionType get tipoReaccion; AllergySeverity get severidad; DateTime? get fechaDiagnostico; String? get observaciones;
/// Create a copy of CreateAllergyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAllergyRequestCopyWith<CreateAllergyRequest> get copyWith => _$CreateAllergyRequestCopyWithImpl<CreateAllergyRequest>(this as CreateAllergyRequest, _$identity);

  /// Serializes this CreateAllergyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAllergyRequest&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.tipoReaccion, tipoReaccion) || other.tipoReaccion == tipoReaccion)&&(identical(other.severidad, severidad) || other.severidad == severidad)&&(identical(other.fechaDiagnostico, fechaDiagnostico) || other.fechaDiagnostico == fechaDiagnostico)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pacienteId,agenteCausante,tipoReaccion,severidad,fechaDiagnostico,observaciones);

@override
String toString() {
  return 'CreateAllergyRequest(pacienteId: $pacienteId, agenteCausante: $agenteCausante, tipoReaccion: $tipoReaccion, severidad: $severidad, fechaDiagnostico: $fechaDiagnostico, observaciones: $observaciones)';
}


}

/// @nodoc
abstract mixin class $CreateAllergyRequestCopyWith<$Res>  {
  factory $CreateAllergyRequestCopyWith(CreateAllergyRequest value, $Res Function(CreateAllergyRequest) _then) = _$CreateAllergyRequestCopyWithImpl;
@useResult
$Res call({
 String pacienteId, String agenteCausante, ReactionType tipoReaccion, AllergySeverity severidad, DateTime? fechaDiagnostico, String? observaciones
});




}
/// @nodoc
class _$CreateAllergyRequestCopyWithImpl<$Res>
    implements $CreateAllergyRequestCopyWith<$Res> {
  _$CreateAllergyRequestCopyWithImpl(this._self, this._then);

  final CreateAllergyRequest _self;
  final $Res Function(CreateAllergyRequest) _then;

/// Create a copy of CreateAllergyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pacienteId = null,Object? agenteCausante = null,Object? tipoReaccion = null,Object? severidad = null,Object? fechaDiagnostico = freezed,Object? observaciones = freezed,}) {
  return _then(_self.copyWith(
pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,agenteCausante: null == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String,tipoReaccion: null == tipoReaccion ? _self.tipoReaccion : tipoReaccion // ignore: cast_nullable_to_non_nullable
as ReactionType,severidad: null == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as AllergySeverity,fechaDiagnostico: freezed == fechaDiagnostico ? _self.fechaDiagnostico : fechaDiagnostico // ignore: cast_nullable_to_non_nullable
as DateTime?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateAllergyRequest].
extension CreateAllergyRequestPatterns on CreateAllergyRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAllergyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAllergyRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAllergyRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateAllergyRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAllergyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAllergyRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  DateTime? fechaDiagnostico,  String? observaciones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAllergyRequest() when $default != null:
return $default(_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.fechaDiagnostico,_that.observaciones);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  DateTime? fechaDiagnostico,  String? observaciones)  $default,) {final _that = this;
switch (_that) {
case _CreateAllergyRequest():
return $default(_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.fechaDiagnostico,_that.observaciones);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pacienteId,  String agenteCausante,  ReactionType tipoReaccion,  AllergySeverity severidad,  DateTime? fechaDiagnostico,  String? observaciones)?  $default,) {final _that = this;
switch (_that) {
case _CreateAllergyRequest() when $default != null:
return $default(_that.pacienteId,_that.agenteCausante,_that.tipoReaccion,_that.severidad,_that.fechaDiagnostico,_that.observaciones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAllergyRequest extends CreateAllergyRequest {
  const _CreateAllergyRequest({required this.pacienteId, required this.agenteCausante, required this.tipoReaccion, required this.severidad, this.fechaDiagnostico, this.observaciones}): super._();
  factory _CreateAllergyRequest.fromJson(Map<String, dynamic> json) => _$CreateAllergyRequestFromJson(json);

@override final  String pacienteId;
@override final  String agenteCausante;
@override final  ReactionType tipoReaccion;
@override final  AllergySeverity severidad;
@override final  DateTime? fechaDiagnostico;
@override final  String? observaciones;

/// Create a copy of CreateAllergyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAllergyRequestCopyWith<_CreateAllergyRequest> get copyWith => __$CreateAllergyRequestCopyWithImpl<_CreateAllergyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAllergyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAllergyRequest&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.tipoReaccion, tipoReaccion) || other.tipoReaccion == tipoReaccion)&&(identical(other.severidad, severidad) || other.severidad == severidad)&&(identical(other.fechaDiagnostico, fechaDiagnostico) || other.fechaDiagnostico == fechaDiagnostico)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pacienteId,agenteCausante,tipoReaccion,severidad,fechaDiagnostico,observaciones);

@override
String toString() {
  return 'CreateAllergyRequest(pacienteId: $pacienteId, agenteCausante: $agenteCausante, tipoReaccion: $tipoReaccion, severidad: $severidad, fechaDiagnostico: $fechaDiagnostico, observaciones: $observaciones)';
}


}

/// @nodoc
abstract mixin class _$CreateAllergyRequestCopyWith<$Res> implements $CreateAllergyRequestCopyWith<$Res> {
  factory _$CreateAllergyRequestCopyWith(_CreateAllergyRequest value, $Res Function(_CreateAllergyRequest) _then) = __$CreateAllergyRequestCopyWithImpl;
@override @useResult
$Res call({
 String pacienteId, String agenteCausante, ReactionType tipoReaccion, AllergySeverity severidad, DateTime? fechaDiagnostico, String? observaciones
});




}
/// @nodoc
class __$CreateAllergyRequestCopyWithImpl<$Res>
    implements _$CreateAllergyRequestCopyWith<$Res> {
  __$CreateAllergyRequestCopyWithImpl(this._self, this._then);

  final _CreateAllergyRequest _self;
  final $Res Function(_CreateAllergyRequest) _then;

/// Create a copy of CreateAllergyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pacienteId = null,Object? agenteCausante = null,Object? tipoReaccion = null,Object? severidad = null,Object? fechaDiagnostico = freezed,Object? observaciones = freezed,}) {
  return _then(_CreateAllergyRequest(
pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,agenteCausante: null == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String,tipoReaccion: null == tipoReaccion ? _self.tipoReaccion : tipoReaccion // ignore: cast_nullable_to_non_nullable
as ReactionType,severidad: null == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as AllergySeverity,fechaDiagnostico: freezed == fechaDiagnostico ? _self.fechaDiagnostico : fechaDiagnostico // ignore: cast_nullable_to_non_nullable
as DateTime?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MedicationModel {

 String get id; String get nombreGenerico; String? get nombreComercial; String? get categoria;
/// Create a copy of MedicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationModelCopyWith<MedicationModel> get copyWith => _$MedicationModelCopyWithImpl<MedicationModel>(this as MedicationModel, _$identity);

  /// Serializes this MedicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreGenerico, nombreGenerico) || other.nombreGenerico == nombreGenerico)&&(identical(other.nombreComercial, nombreComercial) || other.nombreComercial == nombreComercial)&&(identical(other.categoria, categoria) || other.categoria == categoria));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombreGenerico,nombreComercial,categoria);

@override
String toString() {
  return 'MedicationModel(id: $id, nombreGenerico: $nombreGenerico, nombreComercial: $nombreComercial, categoria: $categoria)';
}


}

/// @nodoc
abstract mixin class $MedicationModelCopyWith<$Res>  {
  factory $MedicationModelCopyWith(MedicationModel value, $Res Function(MedicationModel) _then) = _$MedicationModelCopyWithImpl;
@useResult
$Res call({
 String id, String nombreGenerico, String? nombreComercial, String? categoria
});




}
/// @nodoc
class _$MedicationModelCopyWithImpl<$Res>
    implements $MedicationModelCopyWith<$Res> {
  _$MedicationModelCopyWithImpl(this._self, this._then);

  final MedicationModel _self;
  final $Res Function(MedicationModel) _then;

/// Create a copy of MedicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombreGenerico = null,Object? nombreComercial = freezed,Object? categoria = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreGenerico: null == nombreGenerico ? _self.nombreGenerico : nombreGenerico // ignore: cast_nullable_to_non_nullable
as String,nombreComercial: freezed == nombreComercial ? _self.nombreComercial : nombreComercial // ignore: cast_nullable_to_non_nullable
as String?,categoria: freezed == categoria ? _self.categoria : categoria // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicationModel].
extension MedicationModelPatterns on MedicationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicationModel value)  $default,){
final _that = this;
switch (_that) {
case _MedicationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _MedicationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombreGenerico,  String? nombreComercial,  String? categoria)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicationModel() when $default != null:
return $default(_that.id,_that.nombreGenerico,_that.nombreComercial,_that.categoria);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombreGenerico,  String? nombreComercial,  String? categoria)  $default,) {final _that = this;
switch (_that) {
case _MedicationModel():
return $default(_that.id,_that.nombreGenerico,_that.nombreComercial,_that.categoria);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombreGenerico,  String? nombreComercial,  String? categoria)?  $default,) {final _that = this;
switch (_that) {
case _MedicationModel() when $default != null:
return $default(_that.id,_that.nombreGenerico,_that.nombreComercial,_that.categoria);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedicationModel extends MedicationModel {
  const _MedicationModel({required this.id, required this.nombreGenerico, this.nombreComercial, this.categoria}): super._();
  factory _MedicationModel.fromJson(Map<String, dynamic> json) => _$MedicationModelFromJson(json);

@override final  String id;
@override final  String nombreGenerico;
@override final  String? nombreComercial;
@override final  String? categoria;

/// Create a copy of MedicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicationModelCopyWith<_MedicationModel> get copyWith => __$MedicationModelCopyWithImpl<_MedicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreGenerico, nombreGenerico) || other.nombreGenerico == nombreGenerico)&&(identical(other.nombreComercial, nombreComercial) || other.nombreComercial == nombreComercial)&&(identical(other.categoria, categoria) || other.categoria == categoria));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombreGenerico,nombreComercial,categoria);

@override
String toString() {
  return 'MedicationModel(id: $id, nombreGenerico: $nombreGenerico, nombreComercial: $nombreComercial, categoria: $categoria)';
}


}

/// @nodoc
abstract mixin class _$MedicationModelCopyWith<$Res> implements $MedicationModelCopyWith<$Res> {
  factory _$MedicationModelCopyWith(_MedicationModel value, $Res Function(_MedicationModel) _then) = __$MedicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombreGenerico, String? nombreComercial, String? categoria
});




}
/// @nodoc
class __$MedicationModelCopyWithImpl<$Res>
    implements _$MedicationModelCopyWith<$Res> {
  __$MedicationModelCopyWithImpl(this._self, this._then);

  final _MedicationModel _self;
  final $Res Function(_MedicationModel) _then;

/// Create a copy of MedicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombreGenerico = null,Object? nombreComercial = freezed,Object? categoria = freezed,}) {
  return _then(_MedicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreGenerico: null == nombreGenerico ? _self.nombreGenerico : nombreGenerico // ignore: cast_nullable_to_non_nullable
as String,nombreComercial: freezed == nombreComercial ? _self.nombreComercial : nombreComercial // ignore: cast_nullable_to_non_nullable
as String?,categoria: freezed == categoria ? _self.categoria : categoria // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
