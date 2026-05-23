// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiagnosisModel {

 String get id; String get historiaClinicaId; String get pacienteId; String get codigoCie10; String get descripcion; TipoDiagnostico get tipo; EstadoDiagnostico get estado; String? get registradoPor; DateTime? get creadoEn; DateTime? get actualizadoEn;
/// Create a copy of DiagnosisModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisModelCopyWith<DiagnosisModel> get copyWith => _$DiagnosisModelCopyWithImpl<DiagnosisModel>(this as DiagnosisModel, _$identity);

  /// Serializes this DiagnosisModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.codigoCie10, codigoCie10) || other.codigoCie10 == codigoCie10)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.registradoPor, registradoPor) || other.registradoPor == registradoPor)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.actualizadoEn, actualizadoEn) || other.actualizadoEn == actualizadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,pacienteId,codigoCie10,descripcion,tipo,estado,registradoPor,creadoEn,actualizadoEn);

@override
String toString() {
  return 'DiagnosisModel(id: $id, historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, codigoCie10: $codigoCie10, descripcion: $descripcion, tipo: $tipo, estado: $estado, registradoPor: $registradoPor, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn)';
}


}

/// @nodoc
abstract mixin class $DiagnosisModelCopyWith<$Res>  {
  factory $DiagnosisModelCopyWith(DiagnosisModel value, $Res Function(DiagnosisModel) _then) = _$DiagnosisModelCopyWithImpl;
@useResult
$Res call({
 String id, String historiaClinicaId, String pacienteId, String codigoCie10, String descripcion, TipoDiagnostico tipo, EstadoDiagnostico estado, String? registradoPor, DateTime? creadoEn, DateTime? actualizadoEn
});




}
/// @nodoc
class _$DiagnosisModelCopyWithImpl<$Res>
    implements $DiagnosisModelCopyWith<$Res> {
  _$DiagnosisModelCopyWithImpl(this._self, this._then);

  final DiagnosisModel _self;
  final $Res Function(DiagnosisModel) _then;

/// Create a copy of DiagnosisModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? historiaClinicaId = null,Object? pacienteId = null,Object? codigoCie10 = null,Object? descripcion = null,Object? tipo = null,Object? estado = null,Object? registradoPor = freezed,Object? creadoEn = freezed,Object? actualizadoEn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,codigoCie10: null == codigoCie10 ? _self.codigoCie10 : codigoCie10 // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoDiagnostico,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoDiagnostico,registradoPor: freezed == registradoPor ? _self.registradoPor : registradoPor // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,actualizadoEn: freezed == actualizadoEn ? _self.actualizadoEn : actualizadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisModel].
extension DiagnosisModelPatterns on DiagnosisModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagnosisModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagnosisModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagnosisModel value)  $default,){
final _that = this;
switch (_that) {
case _DiagnosisModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagnosisModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiagnosisModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado,  String? registradoPor,  DateTime? creadoEn,  DateTime? actualizadoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagnosisModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado,_that.registradoPor,_that.creadoEn,_that.actualizadoEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado,  String? registradoPor,  DateTime? creadoEn,  DateTime? actualizadoEn)  $default,) {final _that = this;
switch (_that) {
case _DiagnosisModel():
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado,_that.registradoPor,_that.creadoEn,_that.actualizadoEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado,  String? registradoPor,  DateTime? creadoEn,  DateTime? actualizadoEn)?  $default,) {final _that = this;
switch (_that) {
case _DiagnosisModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado,_that.registradoPor,_that.creadoEn,_that.actualizadoEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiagnosisModel implements DiagnosisModel {
  const _DiagnosisModel({required this.id, required this.historiaClinicaId, required this.pacienteId, required this.codigoCie10, required this.descripcion, this.tipo = TipoDiagnostico.presuntivo, this.estado = EstadoDiagnostico.activo, this.registradoPor, this.creadoEn, this.actualizadoEn});
  factory _DiagnosisModel.fromJson(Map<String, dynamic> json) => _$DiagnosisModelFromJson(json);

@override final  String id;
@override final  String historiaClinicaId;
@override final  String pacienteId;
@override final  String codigoCie10;
@override final  String descripcion;
@override@JsonKey() final  TipoDiagnostico tipo;
@override@JsonKey() final  EstadoDiagnostico estado;
@override final  String? registradoPor;
@override final  DateTime? creadoEn;
@override final  DateTime? actualizadoEn;

/// Create a copy of DiagnosisModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisModelCopyWith<_DiagnosisModel> get copyWith => __$DiagnosisModelCopyWithImpl<_DiagnosisModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiagnosisModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.codigoCie10, codigoCie10) || other.codigoCie10 == codigoCie10)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.registradoPor, registradoPor) || other.registradoPor == registradoPor)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.actualizadoEn, actualizadoEn) || other.actualizadoEn == actualizadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,pacienteId,codigoCie10,descripcion,tipo,estado,registradoPor,creadoEn,actualizadoEn);

@override
String toString() {
  return 'DiagnosisModel(id: $id, historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, codigoCie10: $codigoCie10, descripcion: $descripcion, tipo: $tipo, estado: $estado, registradoPor: $registradoPor, creadoEn: $creadoEn, actualizadoEn: $actualizadoEn)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisModelCopyWith<$Res> implements $DiagnosisModelCopyWith<$Res> {
  factory _$DiagnosisModelCopyWith(_DiagnosisModel value, $Res Function(_DiagnosisModel) _then) = __$DiagnosisModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String historiaClinicaId, String pacienteId, String codigoCie10, String descripcion, TipoDiagnostico tipo, EstadoDiagnostico estado, String? registradoPor, DateTime? creadoEn, DateTime? actualizadoEn
});




}
/// @nodoc
class __$DiagnosisModelCopyWithImpl<$Res>
    implements _$DiagnosisModelCopyWith<$Res> {
  __$DiagnosisModelCopyWithImpl(this._self, this._then);

  final _DiagnosisModel _self;
  final $Res Function(_DiagnosisModel) _then;

/// Create a copy of DiagnosisModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? historiaClinicaId = null,Object? pacienteId = null,Object? codigoCie10 = null,Object? descripcion = null,Object? tipo = null,Object? estado = null,Object? registradoPor = freezed,Object? creadoEn = freezed,Object? actualizadoEn = freezed,}) {
  return _then(_DiagnosisModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,codigoCie10: null == codigoCie10 ? _self.codigoCie10 : codigoCie10 // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoDiagnostico,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoDiagnostico,registradoPor: freezed == registradoPor ? _self.registradoPor : registradoPor // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,actualizadoEn: freezed == actualizadoEn ? _self.actualizadoEn : actualizadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateDiagnosisRequest {

 String get historiaClinicaId; String get pacienteId; String get codigoCie10; String get descripcion; TipoDiagnostico get tipo; EstadoDiagnostico get estado;
/// Create a copy of CreateDiagnosisRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDiagnosisRequestCopyWith<CreateDiagnosisRequest> get copyWith => _$CreateDiagnosisRequestCopyWithImpl<CreateDiagnosisRequest>(this as CreateDiagnosisRequest, _$identity);

  /// Serializes this CreateDiagnosisRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDiagnosisRequest&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.codigoCie10, codigoCie10) || other.codigoCie10 == codigoCie10)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historiaClinicaId,pacienteId,codigoCie10,descripcion,tipo,estado);

@override
String toString() {
  return 'CreateDiagnosisRequest(historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, codigoCie10: $codigoCie10, descripcion: $descripcion, tipo: $tipo, estado: $estado)';
}


}

/// @nodoc
abstract mixin class $CreateDiagnosisRequestCopyWith<$Res>  {
  factory $CreateDiagnosisRequestCopyWith(CreateDiagnosisRequest value, $Res Function(CreateDiagnosisRequest) _then) = _$CreateDiagnosisRequestCopyWithImpl;
@useResult
$Res call({
 String historiaClinicaId, String pacienteId, String codigoCie10, String descripcion, TipoDiagnostico tipo, EstadoDiagnostico estado
});




}
/// @nodoc
class _$CreateDiagnosisRequestCopyWithImpl<$Res>
    implements $CreateDiagnosisRequestCopyWith<$Res> {
  _$CreateDiagnosisRequestCopyWithImpl(this._self, this._then);

  final CreateDiagnosisRequest _self;
  final $Res Function(CreateDiagnosisRequest) _then;

/// Create a copy of CreateDiagnosisRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? historiaClinicaId = null,Object? pacienteId = null,Object? codigoCie10 = null,Object? descripcion = null,Object? tipo = null,Object? estado = null,}) {
  return _then(_self.copyWith(
historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,codigoCie10: null == codigoCie10 ? _self.codigoCie10 : codigoCie10 // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoDiagnostico,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoDiagnostico,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateDiagnosisRequest].
extension CreateDiagnosisRequestPatterns on CreateDiagnosisRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateDiagnosisRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateDiagnosisRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateDiagnosisRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateDiagnosisRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateDiagnosisRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateDiagnosisRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateDiagnosisRequest() when $default != null:
return $default(_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado)  $default,) {final _that = this;
switch (_that) {
case _CreateDiagnosisRequest():
return $default(_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String historiaClinicaId,  String pacienteId,  String codigoCie10,  String descripcion,  TipoDiagnostico tipo,  EstadoDiagnostico estado)?  $default,) {final _that = this;
switch (_that) {
case _CreateDiagnosisRequest() when $default != null:
return $default(_that.historiaClinicaId,_that.pacienteId,_that.codigoCie10,_that.descripcion,_that.tipo,_that.estado);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateDiagnosisRequest implements CreateDiagnosisRequest {
  const _CreateDiagnosisRequest({required this.historiaClinicaId, required this.pacienteId, required this.codigoCie10, required this.descripcion, required this.tipo, this.estado = EstadoDiagnostico.activo});
  factory _CreateDiagnosisRequest.fromJson(Map<String, dynamic> json) => _$CreateDiagnosisRequestFromJson(json);

@override final  String historiaClinicaId;
@override final  String pacienteId;
@override final  String codigoCie10;
@override final  String descripcion;
@override final  TipoDiagnostico tipo;
@override@JsonKey() final  EstadoDiagnostico estado;

/// Create a copy of CreateDiagnosisRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDiagnosisRequestCopyWith<_CreateDiagnosisRequest> get copyWith => __$CreateDiagnosisRequestCopyWithImpl<_CreateDiagnosisRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateDiagnosisRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDiagnosisRequest&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.codigoCie10, codigoCie10) || other.codigoCie10 == codigoCie10)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.estado, estado) || other.estado == estado));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historiaClinicaId,pacienteId,codigoCie10,descripcion,tipo,estado);

@override
String toString() {
  return 'CreateDiagnosisRequest(historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, codigoCie10: $codigoCie10, descripcion: $descripcion, tipo: $tipo, estado: $estado)';
}


}

/// @nodoc
abstract mixin class _$CreateDiagnosisRequestCopyWith<$Res> implements $CreateDiagnosisRequestCopyWith<$Res> {
  factory _$CreateDiagnosisRequestCopyWith(_CreateDiagnosisRequest value, $Res Function(_CreateDiagnosisRequest) _then) = __$CreateDiagnosisRequestCopyWithImpl;
@override @useResult
$Res call({
 String historiaClinicaId, String pacienteId, String codigoCie10, String descripcion, TipoDiagnostico tipo, EstadoDiagnostico estado
});




}
/// @nodoc
class __$CreateDiagnosisRequestCopyWithImpl<$Res>
    implements _$CreateDiagnosisRequestCopyWith<$Res> {
  __$CreateDiagnosisRequestCopyWithImpl(this._self, this._then);

  final _CreateDiagnosisRequest _self;
  final $Res Function(_CreateDiagnosisRequest) _then;

/// Create a copy of CreateDiagnosisRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? historiaClinicaId = null,Object? pacienteId = null,Object? codigoCie10 = null,Object? descripcion = null,Object? tipo = null,Object? estado = null,}) {
  return _then(_CreateDiagnosisRequest(
historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,codigoCie10: null == codigoCie10 ? _self.codigoCie10 : codigoCie10 // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as TipoDiagnostico,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as EstadoDiagnostico,
  ));
}


}


/// @nodoc
mixin _$Cie10Item {

 String get codigo; String get descripcion;
/// Create a copy of Cie10Item
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Cie10ItemCopyWith<Cie10Item> get copyWith => _$Cie10ItemCopyWithImpl<Cie10Item>(this as Cie10Item, _$identity);

  /// Serializes this Cie10Item to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cie10Item&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codigo,descripcion);

@override
String toString() {
  return 'Cie10Item(codigo: $codigo, descripcion: $descripcion)';
}


}

/// @nodoc
abstract mixin class $Cie10ItemCopyWith<$Res>  {
  factory $Cie10ItemCopyWith(Cie10Item value, $Res Function(Cie10Item) _then) = _$Cie10ItemCopyWithImpl;
@useResult
$Res call({
 String codigo, String descripcion
});




}
/// @nodoc
class _$Cie10ItemCopyWithImpl<$Res>
    implements $Cie10ItemCopyWith<$Res> {
  _$Cie10ItemCopyWithImpl(this._self, this._then);

  final Cie10Item _self;
  final $Res Function(Cie10Item) _then;

/// Create a copy of Cie10Item
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codigo = null,Object? descripcion = null,}) {
  return _then(_self.copyWith(
codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Cie10Item].
extension Cie10ItemPatterns on Cie10Item {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cie10Item value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cie10Item() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cie10Item value)  $default,){
final _that = this;
switch (_that) {
case _Cie10Item():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cie10Item value)?  $default,){
final _that = this;
switch (_that) {
case _Cie10Item() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String codigo,  String descripcion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cie10Item() when $default != null:
return $default(_that.codigo,_that.descripcion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String codigo,  String descripcion)  $default,) {final _that = this;
switch (_that) {
case _Cie10Item():
return $default(_that.codigo,_that.descripcion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String codigo,  String descripcion)?  $default,) {final _that = this;
switch (_that) {
case _Cie10Item() when $default != null:
return $default(_that.codigo,_that.descripcion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cie10Item implements Cie10Item {
  const _Cie10Item({required this.codigo, required this.descripcion});
  factory _Cie10Item.fromJson(Map<String, dynamic> json) => _$Cie10ItemFromJson(json);

@override final  String codigo;
@override final  String descripcion;

/// Create a copy of Cie10Item
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Cie10ItemCopyWith<_Cie10Item> get copyWith => __$Cie10ItemCopyWithImpl<_Cie10Item>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Cie10ItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cie10Item&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codigo,descripcion);

@override
String toString() {
  return 'Cie10Item(codigo: $codigo, descripcion: $descripcion)';
}


}

/// @nodoc
abstract mixin class _$Cie10ItemCopyWith<$Res> implements $Cie10ItemCopyWith<$Res> {
  factory _$Cie10ItemCopyWith(_Cie10Item value, $Res Function(_Cie10Item) _then) = __$Cie10ItemCopyWithImpl;
@override @useResult
$Res call({
 String codigo, String descripcion
});




}
/// @nodoc
class __$Cie10ItemCopyWithImpl<$Res>
    implements _$Cie10ItemCopyWith<$Res> {
  __$Cie10ItemCopyWithImpl(this._self, this._then);

  final _Cie10Item _self;
  final $Res Function(_Cie10Item) _then;

/// Create a copy of Cie10Item
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codigo = null,Object? descripcion = null,}) {
  return _then(_Cie10Item(
codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
