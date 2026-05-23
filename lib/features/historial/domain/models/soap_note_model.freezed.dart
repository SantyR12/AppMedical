// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'soap_note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SoapNoteModel {

 String get id; String get historiaClinicaId; String get pacienteId;/// S: síntomas y motivo de consulta reportados por el paciente
 String get subjetivo;/// O: hallazgos del examen físico, signos vitales, laboratorios
 String get objetivo;/// A: interpretación clínica y diagnóstico
 String get analisis;/// P: tratamiento, medicamentos, seguimiento, interconsultas
 String get plan; String? get creadoPor; DateTime? get creadoEn;
/// Create a copy of SoapNoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoapNoteModelCopyWith<SoapNoteModel> get copyWith => _$SoapNoteModelCopyWithImpl<SoapNoteModel>(this as SoapNoteModel, _$identity);

  /// Serializes this SoapNoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoapNoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.subjetivo, subjetivo) || other.subjetivo == subjetivo)&&(identical(other.objetivo, objetivo) || other.objetivo == objetivo)&&(identical(other.analisis, analisis) || other.analisis == analisis)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.creadoPor, creadoPor) || other.creadoPor == creadoPor)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,pacienteId,subjetivo,objetivo,analisis,plan,creadoPor,creadoEn);

@override
String toString() {
  return 'SoapNoteModel(id: $id, historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, subjetivo: $subjetivo, objetivo: $objetivo, analisis: $analisis, plan: $plan, creadoPor: $creadoPor, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class $SoapNoteModelCopyWith<$Res>  {
  factory $SoapNoteModelCopyWith(SoapNoteModel value, $Res Function(SoapNoteModel) _then) = _$SoapNoteModelCopyWithImpl;
@useResult
$Res call({
 String id, String historiaClinicaId, String pacienteId, String subjetivo, String objetivo, String analisis, String plan, String? creadoPor, DateTime? creadoEn
});




}
/// @nodoc
class _$SoapNoteModelCopyWithImpl<$Res>
    implements $SoapNoteModelCopyWith<$Res> {
  _$SoapNoteModelCopyWithImpl(this._self, this._then);

  final SoapNoteModel _self;
  final $Res Function(SoapNoteModel) _then;

/// Create a copy of SoapNoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? historiaClinicaId = null,Object? pacienteId = null,Object? subjetivo = null,Object? objetivo = null,Object? analisis = null,Object? plan = null,Object? creadoPor = freezed,Object? creadoEn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,subjetivo: null == subjetivo ? _self.subjetivo : subjetivo // ignore: cast_nullable_to_non_nullable
as String,objetivo: null == objetivo ? _self.objetivo : objetivo // ignore: cast_nullable_to_non_nullable
as String,analisis: null == analisis ? _self.analisis : analisis // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,creadoPor: freezed == creadoPor ? _self.creadoPor : creadoPor // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SoapNoteModel].
extension SoapNoteModelPatterns on SoapNoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SoapNoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SoapNoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SoapNoteModel value)  $default,){
final _that = this;
switch (_that) {
case _SoapNoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SoapNoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _SoapNoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan,  String? creadoPor,  DateTime? creadoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SoapNoteModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan,_that.creadoPor,_that.creadoEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan,  String? creadoPor,  DateTime? creadoEn)  $default,) {final _that = this;
switch (_that) {
case _SoapNoteModel():
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan,_that.creadoPor,_that.creadoEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan,  String? creadoPor,  DateTime? creadoEn)?  $default,) {final _that = this;
switch (_that) {
case _SoapNoteModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan,_that.creadoPor,_that.creadoEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SoapNoteModel implements SoapNoteModel {
  const _SoapNoteModel({required this.id, required this.historiaClinicaId, required this.pacienteId, required this.subjetivo, required this.objetivo, required this.analisis, required this.plan, this.creadoPor, this.creadoEn});
  factory _SoapNoteModel.fromJson(Map<String, dynamic> json) => _$SoapNoteModelFromJson(json);

@override final  String id;
@override final  String historiaClinicaId;
@override final  String pacienteId;
/// S: síntomas y motivo de consulta reportados por el paciente
@override final  String subjetivo;
/// O: hallazgos del examen físico, signos vitales, laboratorios
@override final  String objetivo;
/// A: interpretación clínica y diagnóstico
@override final  String analisis;
/// P: tratamiento, medicamentos, seguimiento, interconsultas
@override final  String plan;
@override final  String? creadoPor;
@override final  DateTime? creadoEn;

/// Create a copy of SoapNoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SoapNoteModelCopyWith<_SoapNoteModel> get copyWith => __$SoapNoteModelCopyWithImpl<_SoapNoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SoapNoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SoapNoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.subjetivo, subjetivo) || other.subjetivo == subjetivo)&&(identical(other.objetivo, objetivo) || other.objetivo == objetivo)&&(identical(other.analisis, analisis) || other.analisis == analisis)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.creadoPor, creadoPor) || other.creadoPor == creadoPor)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,pacienteId,subjetivo,objetivo,analisis,plan,creadoPor,creadoEn);

@override
String toString() {
  return 'SoapNoteModel(id: $id, historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, subjetivo: $subjetivo, objetivo: $objetivo, analisis: $analisis, plan: $plan, creadoPor: $creadoPor, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class _$SoapNoteModelCopyWith<$Res> implements $SoapNoteModelCopyWith<$Res> {
  factory _$SoapNoteModelCopyWith(_SoapNoteModel value, $Res Function(_SoapNoteModel) _then) = __$SoapNoteModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String historiaClinicaId, String pacienteId, String subjetivo, String objetivo, String analisis, String plan, String? creadoPor, DateTime? creadoEn
});




}
/// @nodoc
class __$SoapNoteModelCopyWithImpl<$Res>
    implements _$SoapNoteModelCopyWith<$Res> {
  __$SoapNoteModelCopyWithImpl(this._self, this._then);

  final _SoapNoteModel _self;
  final $Res Function(_SoapNoteModel) _then;

/// Create a copy of SoapNoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? historiaClinicaId = null,Object? pacienteId = null,Object? subjetivo = null,Object? objetivo = null,Object? analisis = null,Object? plan = null,Object? creadoPor = freezed,Object? creadoEn = freezed,}) {
  return _then(_SoapNoteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,subjetivo: null == subjetivo ? _self.subjetivo : subjetivo // ignore: cast_nullable_to_non_nullable
as String,objetivo: null == objetivo ? _self.objetivo : objetivo // ignore: cast_nullable_to_non_nullable
as String,analisis: null == analisis ? _self.analisis : analisis // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,creadoPor: freezed == creadoPor ? _self.creadoPor : creadoPor // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateSoapNoteRequest {

 String get historiaClinicaId; String get pacienteId; String get subjetivo; String get objetivo; String get analisis; String get plan;
/// Create a copy of CreateSoapNoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateSoapNoteRequestCopyWith<CreateSoapNoteRequest> get copyWith => _$CreateSoapNoteRequestCopyWithImpl<CreateSoapNoteRequest>(this as CreateSoapNoteRequest, _$identity);

  /// Serializes this CreateSoapNoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateSoapNoteRequest&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.subjetivo, subjetivo) || other.subjetivo == subjetivo)&&(identical(other.objetivo, objetivo) || other.objetivo == objetivo)&&(identical(other.analisis, analisis) || other.analisis == analisis)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historiaClinicaId,pacienteId,subjetivo,objetivo,analisis,plan);

@override
String toString() {
  return 'CreateSoapNoteRequest(historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, subjetivo: $subjetivo, objetivo: $objetivo, analisis: $analisis, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $CreateSoapNoteRequestCopyWith<$Res>  {
  factory $CreateSoapNoteRequestCopyWith(CreateSoapNoteRequest value, $Res Function(CreateSoapNoteRequest) _then) = _$CreateSoapNoteRequestCopyWithImpl;
@useResult
$Res call({
 String historiaClinicaId, String pacienteId, String subjetivo, String objetivo, String analisis, String plan
});




}
/// @nodoc
class _$CreateSoapNoteRequestCopyWithImpl<$Res>
    implements $CreateSoapNoteRequestCopyWith<$Res> {
  _$CreateSoapNoteRequestCopyWithImpl(this._self, this._then);

  final CreateSoapNoteRequest _self;
  final $Res Function(CreateSoapNoteRequest) _then;

/// Create a copy of CreateSoapNoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? historiaClinicaId = null,Object? pacienteId = null,Object? subjetivo = null,Object? objetivo = null,Object? analisis = null,Object? plan = null,}) {
  return _then(_self.copyWith(
historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,subjetivo: null == subjetivo ? _self.subjetivo : subjetivo // ignore: cast_nullable_to_non_nullable
as String,objetivo: null == objetivo ? _self.objetivo : objetivo // ignore: cast_nullable_to_non_nullable
as String,analisis: null == analisis ? _self.analisis : analisis // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateSoapNoteRequest].
extension CreateSoapNoteRequestPatterns on CreateSoapNoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateSoapNoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateSoapNoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateSoapNoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateSoapNoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateSoapNoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateSoapNoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateSoapNoteRequest() when $default != null:
return $default(_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan)  $default,) {final _that = this;
switch (_that) {
case _CreateSoapNoteRequest():
return $default(_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String historiaClinicaId,  String pacienteId,  String subjetivo,  String objetivo,  String analisis,  String plan)?  $default,) {final _that = this;
switch (_that) {
case _CreateSoapNoteRequest() when $default != null:
return $default(_that.historiaClinicaId,_that.pacienteId,_that.subjetivo,_that.objetivo,_that.analisis,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateSoapNoteRequest implements CreateSoapNoteRequest {
  const _CreateSoapNoteRequest({required this.historiaClinicaId, required this.pacienteId, required this.subjetivo, required this.objetivo, required this.analisis, required this.plan});
  factory _CreateSoapNoteRequest.fromJson(Map<String, dynamic> json) => _$CreateSoapNoteRequestFromJson(json);

@override final  String historiaClinicaId;
@override final  String pacienteId;
@override final  String subjetivo;
@override final  String objetivo;
@override final  String analisis;
@override final  String plan;

/// Create a copy of CreateSoapNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSoapNoteRequestCopyWith<_CreateSoapNoteRequest> get copyWith => __$CreateSoapNoteRequestCopyWithImpl<_CreateSoapNoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateSoapNoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSoapNoteRequest&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.subjetivo, subjetivo) || other.subjetivo == subjetivo)&&(identical(other.objetivo, objetivo) || other.objetivo == objetivo)&&(identical(other.analisis, analisis) || other.analisis == analisis)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historiaClinicaId,pacienteId,subjetivo,objetivo,analisis,plan);

@override
String toString() {
  return 'CreateSoapNoteRequest(historiaClinicaId: $historiaClinicaId, pacienteId: $pacienteId, subjetivo: $subjetivo, objetivo: $objetivo, analisis: $analisis, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$CreateSoapNoteRequestCopyWith<$Res> implements $CreateSoapNoteRequestCopyWith<$Res> {
  factory _$CreateSoapNoteRequestCopyWith(_CreateSoapNoteRequest value, $Res Function(_CreateSoapNoteRequest) _then) = __$CreateSoapNoteRequestCopyWithImpl;
@override @useResult
$Res call({
 String historiaClinicaId, String pacienteId, String subjetivo, String objetivo, String analisis, String plan
});




}
/// @nodoc
class __$CreateSoapNoteRequestCopyWithImpl<$Res>
    implements _$CreateSoapNoteRequestCopyWith<$Res> {
  __$CreateSoapNoteRequestCopyWithImpl(this._self, this._then);

  final _CreateSoapNoteRequest _self;
  final $Res Function(_CreateSoapNoteRequest) _then;

/// Create a copy of CreateSoapNoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? historiaClinicaId = null,Object? pacienteId = null,Object? subjetivo = null,Object? objetivo = null,Object? analisis = null,Object? plan = null,}) {
  return _then(_CreateSoapNoteRequest(
historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,subjetivo: null == subjetivo ? _self.subjetivo : subjetivo // ignore: cast_nullable_to_non_nullable
as String,objetivo: null == objetivo ? _self.objetivo : objetivo // ignore: cast_nullable_to_non_nullable
as String,analisis: null == analisis ? _self.analisis : analisis // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
