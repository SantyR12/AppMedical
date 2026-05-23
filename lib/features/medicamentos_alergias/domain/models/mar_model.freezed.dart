// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarEntryModel {

 String get id; String get prescripcionId; String get pacienteId; DateTime get horaProgramada; DateTime? get horaReal; String? get administradoPor; ResultadoAdministracion get resultado; String? get dosisAdministrada; String? get viaAdministrada; String? get observaciones; DateTime? get creadoEn; String? get nombreMedicamento; String? get dosisPrescrita;
/// Create a copy of MarEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarEntryModelCopyWith<MarEntryModel> get copyWith => _$MarEntryModelCopyWithImpl<MarEntryModel>(this as MarEntryModel, _$identity);

  /// Serializes this MarEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarEntryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.prescripcionId, prescripcionId) || other.prescripcionId == prescripcionId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.horaProgramada, horaProgramada) || other.horaProgramada == horaProgramada)&&(identical(other.horaReal, horaReal) || other.horaReal == horaReal)&&(identical(other.administradoPor, administradoPor) || other.administradoPor == administradoPor)&&(identical(other.resultado, resultado) || other.resultado == resultado)&&(identical(other.dosisAdministrada, dosisAdministrada) || other.dosisAdministrada == dosisAdministrada)&&(identical(other.viaAdministrada, viaAdministrada) || other.viaAdministrada == viaAdministrada)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.nombreMedicamento, nombreMedicamento) || other.nombreMedicamento == nombreMedicamento)&&(identical(other.dosisPrescrita, dosisPrescrita) || other.dosisPrescrita == dosisPrescrita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,prescripcionId,pacienteId,horaProgramada,horaReal,administradoPor,resultado,dosisAdministrada,viaAdministrada,observaciones,creadoEn,nombreMedicamento,dosisPrescrita);

@override
String toString() {
  return 'MarEntryModel(id: $id, prescripcionId: $prescripcionId, pacienteId: $pacienteId, horaProgramada: $horaProgramada, horaReal: $horaReal, administradoPor: $administradoPor, resultado: $resultado, dosisAdministrada: $dosisAdministrada, viaAdministrada: $viaAdministrada, observaciones: $observaciones, creadoEn: $creadoEn, nombreMedicamento: $nombreMedicamento, dosisPrescrita: $dosisPrescrita)';
}


}

/// @nodoc
abstract mixin class $MarEntryModelCopyWith<$Res>  {
  factory $MarEntryModelCopyWith(MarEntryModel value, $Res Function(MarEntryModel) _then) = _$MarEntryModelCopyWithImpl;
@useResult
$Res call({
 String id, String prescripcionId, String pacienteId, DateTime horaProgramada, DateTime? horaReal, String? administradoPor, ResultadoAdministracion resultado, String? dosisAdministrada, String? viaAdministrada, String? observaciones, DateTime? creadoEn, String? nombreMedicamento, String? dosisPrescrita
});




}
/// @nodoc
class _$MarEntryModelCopyWithImpl<$Res>
    implements $MarEntryModelCopyWith<$Res> {
  _$MarEntryModelCopyWithImpl(this._self, this._then);

  final MarEntryModel _self;
  final $Res Function(MarEntryModel) _then;

/// Create a copy of MarEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? prescripcionId = null,Object? pacienteId = null,Object? horaProgramada = null,Object? horaReal = freezed,Object? administradoPor = freezed,Object? resultado = null,Object? dosisAdministrada = freezed,Object? viaAdministrada = freezed,Object? observaciones = freezed,Object? creadoEn = freezed,Object? nombreMedicamento = freezed,Object? dosisPrescrita = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,prescripcionId: null == prescripcionId ? _self.prescripcionId : prescripcionId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,horaProgramada: null == horaProgramada ? _self.horaProgramada : horaProgramada // ignore: cast_nullable_to_non_nullable
as DateTime,horaReal: freezed == horaReal ? _self.horaReal : horaReal // ignore: cast_nullable_to_non_nullable
as DateTime?,administradoPor: freezed == administradoPor ? _self.administradoPor : administradoPor // ignore: cast_nullable_to_non_nullable
as String?,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as ResultadoAdministracion,dosisAdministrada: freezed == dosisAdministrada ? _self.dosisAdministrada : dosisAdministrada // ignore: cast_nullable_to_non_nullable
as String?,viaAdministrada: freezed == viaAdministrada ? _self.viaAdministrada : viaAdministrada // ignore: cast_nullable_to_non_nullable
as String?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,nombreMedicamento: freezed == nombreMedicamento ? _self.nombreMedicamento : nombreMedicamento // ignore: cast_nullable_to_non_nullable
as String?,dosisPrescrita: freezed == dosisPrescrita ? _self.dosisPrescrita : dosisPrescrita // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarEntryModel].
extension MarEntryModelPatterns on MarEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _MarEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MarEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String prescripcionId,  String pacienteId,  DateTime horaProgramada,  DateTime? horaReal,  String? administradoPor,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones,  DateTime? creadoEn,  String? nombreMedicamento,  String? dosisPrescrita)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarEntryModel() when $default != null:
return $default(_that.id,_that.prescripcionId,_that.pacienteId,_that.horaProgramada,_that.horaReal,_that.administradoPor,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones,_that.creadoEn,_that.nombreMedicamento,_that.dosisPrescrita);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String prescripcionId,  String pacienteId,  DateTime horaProgramada,  DateTime? horaReal,  String? administradoPor,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones,  DateTime? creadoEn,  String? nombreMedicamento,  String? dosisPrescrita)  $default,) {final _that = this;
switch (_that) {
case _MarEntryModel():
return $default(_that.id,_that.prescripcionId,_that.pacienteId,_that.horaProgramada,_that.horaReal,_that.administradoPor,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones,_that.creadoEn,_that.nombreMedicamento,_that.dosisPrescrita);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String prescripcionId,  String pacienteId,  DateTime horaProgramada,  DateTime? horaReal,  String? administradoPor,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones,  DateTime? creadoEn,  String? nombreMedicamento,  String? dosisPrescrita)?  $default,) {final _that = this;
switch (_that) {
case _MarEntryModel() when $default != null:
return $default(_that.id,_that.prescripcionId,_that.pacienteId,_that.horaProgramada,_that.horaReal,_that.administradoPor,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones,_that.creadoEn,_that.nombreMedicamento,_that.dosisPrescrita);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarEntryModel implements MarEntryModel {
  const _MarEntryModel({required this.id, required this.prescripcionId, required this.pacienteId, required this.horaProgramada, this.horaReal, this.administradoPor, this.resultado = ResultadoAdministracion.administrado, this.dosisAdministrada, this.viaAdministrada, this.observaciones, this.creadoEn, this.nombreMedicamento, this.dosisPrescrita});
  factory _MarEntryModel.fromJson(Map<String, dynamic> json) => _$MarEntryModelFromJson(json);

@override final  String id;
@override final  String prescripcionId;
@override final  String pacienteId;
@override final  DateTime horaProgramada;
@override final  DateTime? horaReal;
@override final  String? administradoPor;
@override@JsonKey() final  ResultadoAdministracion resultado;
@override final  String? dosisAdministrada;
@override final  String? viaAdministrada;
@override final  String? observaciones;
@override final  DateTime? creadoEn;
@override final  String? nombreMedicamento;
@override final  String? dosisPrescrita;

/// Create a copy of MarEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarEntryModelCopyWith<_MarEntryModel> get copyWith => __$MarEntryModelCopyWithImpl<_MarEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarEntryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.prescripcionId, prescripcionId) || other.prescripcionId == prescripcionId)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.horaProgramada, horaProgramada) || other.horaProgramada == horaProgramada)&&(identical(other.horaReal, horaReal) || other.horaReal == horaReal)&&(identical(other.administradoPor, administradoPor) || other.administradoPor == administradoPor)&&(identical(other.resultado, resultado) || other.resultado == resultado)&&(identical(other.dosisAdministrada, dosisAdministrada) || other.dosisAdministrada == dosisAdministrada)&&(identical(other.viaAdministrada, viaAdministrada) || other.viaAdministrada == viaAdministrada)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.nombreMedicamento, nombreMedicamento) || other.nombreMedicamento == nombreMedicamento)&&(identical(other.dosisPrescrita, dosisPrescrita) || other.dosisPrescrita == dosisPrescrita));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,prescripcionId,pacienteId,horaProgramada,horaReal,administradoPor,resultado,dosisAdministrada,viaAdministrada,observaciones,creadoEn,nombreMedicamento,dosisPrescrita);

@override
String toString() {
  return 'MarEntryModel(id: $id, prescripcionId: $prescripcionId, pacienteId: $pacienteId, horaProgramada: $horaProgramada, horaReal: $horaReal, administradoPor: $administradoPor, resultado: $resultado, dosisAdministrada: $dosisAdministrada, viaAdministrada: $viaAdministrada, observaciones: $observaciones, creadoEn: $creadoEn, nombreMedicamento: $nombreMedicamento, dosisPrescrita: $dosisPrescrita)';
}


}

/// @nodoc
abstract mixin class _$MarEntryModelCopyWith<$Res> implements $MarEntryModelCopyWith<$Res> {
  factory _$MarEntryModelCopyWith(_MarEntryModel value, $Res Function(_MarEntryModel) _then) = __$MarEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String prescripcionId, String pacienteId, DateTime horaProgramada, DateTime? horaReal, String? administradoPor, ResultadoAdministracion resultado, String? dosisAdministrada, String? viaAdministrada, String? observaciones, DateTime? creadoEn, String? nombreMedicamento, String? dosisPrescrita
});




}
/// @nodoc
class __$MarEntryModelCopyWithImpl<$Res>
    implements _$MarEntryModelCopyWith<$Res> {
  __$MarEntryModelCopyWithImpl(this._self, this._then);

  final _MarEntryModel _self;
  final $Res Function(_MarEntryModel) _then;

/// Create a copy of MarEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? prescripcionId = null,Object? pacienteId = null,Object? horaProgramada = null,Object? horaReal = freezed,Object? administradoPor = freezed,Object? resultado = null,Object? dosisAdministrada = freezed,Object? viaAdministrada = freezed,Object? observaciones = freezed,Object? creadoEn = freezed,Object? nombreMedicamento = freezed,Object? dosisPrescrita = freezed,}) {
  return _then(_MarEntryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,prescripcionId: null == prescripcionId ? _self.prescripcionId : prescripcionId // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,horaProgramada: null == horaProgramada ? _self.horaProgramada : horaProgramada // ignore: cast_nullable_to_non_nullable
as DateTime,horaReal: freezed == horaReal ? _self.horaReal : horaReal // ignore: cast_nullable_to_non_nullable
as DateTime?,administradoPor: freezed == administradoPor ? _self.administradoPor : administradoPor // ignore: cast_nullable_to_non_nullable
as String?,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as ResultadoAdministracion,dosisAdministrada: freezed == dosisAdministrada ? _self.dosisAdministrada : dosisAdministrada // ignore: cast_nullable_to_non_nullable
as String?,viaAdministrada: freezed == viaAdministrada ? _self.viaAdministrada : viaAdministrada // ignore: cast_nullable_to_non_nullable
as String?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,nombreMedicamento: freezed == nombreMedicamento ? _self.nombreMedicamento : nombreMedicamento // ignore: cast_nullable_to_non_nullable
as String?,dosisPrescrita: freezed == dosisPrescrita ? _self.dosisPrescrita : dosisPrescrita // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RegisterMarEntryRequest {

 String get prescripcionId; DateTime get horaReal; ResultadoAdministracion get resultado; String? get dosisAdministrada; String? get viaAdministrada; String? get observaciones;
/// Create a copy of RegisterMarEntryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterMarEntryRequestCopyWith<RegisterMarEntryRequest> get copyWith => _$RegisterMarEntryRequestCopyWithImpl<RegisterMarEntryRequest>(this as RegisterMarEntryRequest, _$identity);

  /// Serializes this RegisterMarEntryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterMarEntryRequest&&(identical(other.prescripcionId, prescripcionId) || other.prescripcionId == prescripcionId)&&(identical(other.horaReal, horaReal) || other.horaReal == horaReal)&&(identical(other.resultado, resultado) || other.resultado == resultado)&&(identical(other.dosisAdministrada, dosisAdministrada) || other.dosisAdministrada == dosisAdministrada)&&(identical(other.viaAdministrada, viaAdministrada) || other.viaAdministrada == viaAdministrada)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prescripcionId,horaReal,resultado,dosisAdministrada,viaAdministrada,observaciones);

@override
String toString() {
  return 'RegisterMarEntryRequest(prescripcionId: $prescripcionId, horaReal: $horaReal, resultado: $resultado, dosisAdministrada: $dosisAdministrada, viaAdministrada: $viaAdministrada, observaciones: $observaciones)';
}


}

/// @nodoc
abstract mixin class $RegisterMarEntryRequestCopyWith<$Res>  {
  factory $RegisterMarEntryRequestCopyWith(RegisterMarEntryRequest value, $Res Function(RegisterMarEntryRequest) _then) = _$RegisterMarEntryRequestCopyWithImpl;
@useResult
$Res call({
 String prescripcionId, DateTime horaReal, ResultadoAdministracion resultado, String? dosisAdministrada, String? viaAdministrada, String? observaciones
});




}
/// @nodoc
class _$RegisterMarEntryRequestCopyWithImpl<$Res>
    implements $RegisterMarEntryRequestCopyWith<$Res> {
  _$RegisterMarEntryRequestCopyWithImpl(this._self, this._then);

  final RegisterMarEntryRequest _self;
  final $Res Function(RegisterMarEntryRequest) _then;

/// Create a copy of RegisterMarEntryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prescripcionId = null,Object? horaReal = null,Object? resultado = null,Object? dosisAdministrada = freezed,Object? viaAdministrada = freezed,Object? observaciones = freezed,}) {
  return _then(_self.copyWith(
prescripcionId: null == prescripcionId ? _self.prescripcionId : prescripcionId // ignore: cast_nullable_to_non_nullable
as String,horaReal: null == horaReal ? _self.horaReal : horaReal // ignore: cast_nullable_to_non_nullable
as DateTime,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as ResultadoAdministracion,dosisAdministrada: freezed == dosisAdministrada ? _self.dosisAdministrada : dosisAdministrada // ignore: cast_nullable_to_non_nullable
as String?,viaAdministrada: freezed == viaAdministrada ? _self.viaAdministrada : viaAdministrada // ignore: cast_nullable_to_non_nullable
as String?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterMarEntryRequest].
extension RegisterMarEntryRequestPatterns on RegisterMarEntryRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterMarEntryRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterMarEntryRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterMarEntryRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterMarEntryRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterMarEntryRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterMarEntryRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String prescripcionId,  DateTime horaReal,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterMarEntryRequest() when $default != null:
return $default(_that.prescripcionId,_that.horaReal,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String prescripcionId,  DateTime horaReal,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones)  $default,) {final _that = this;
switch (_that) {
case _RegisterMarEntryRequest():
return $default(_that.prescripcionId,_that.horaReal,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String prescripcionId,  DateTime horaReal,  ResultadoAdministracion resultado,  String? dosisAdministrada,  String? viaAdministrada,  String? observaciones)?  $default,) {final _that = this;
switch (_that) {
case _RegisterMarEntryRequest() when $default != null:
return $default(_that.prescripcionId,_that.horaReal,_that.resultado,_that.dosisAdministrada,_that.viaAdministrada,_that.observaciones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterMarEntryRequest implements RegisterMarEntryRequest {
  const _RegisterMarEntryRequest({required this.prescripcionId, required this.horaReal, required this.resultado, this.dosisAdministrada, this.viaAdministrada, this.observaciones});
  factory _RegisterMarEntryRequest.fromJson(Map<String, dynamic> json) => _$RegisterMarEntryRequestFromJson(json);

@override final  String prescripcionId;
@override final  DateTime horaReal;
@override final  ResultadoAdministracion resultado;
@override final  String? dosisAdministrada;
@override final  String? viaAdministrada;
@override final  String? observaciones;

/// Create a copy of RegisterMarEntryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterMarEntryRequestCopyWith<_RegisterMarEntryRequest> get copyWith => __$RegisterMarEntryRequestCopyWithImpl<_RegisterMarEntryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterMarEntryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterMarEntryRequest&&(identical(other.prescripcionId, prescripcionId) || other.prescripcionId == prescripcionId)&&(identical(other.horaReal, horaReal) || other.horaReal == horaReal)&&(identical(other.resultado, resultado) || other.resultado == resultado)&&(identical(other.dosisAdministrada, dosisAdministrada) || other.dosisAdministrada == dosisAdministrada)&&(identical(other.viaAdministrada, viaAdministrada) || other.viaAdministrada == viaAdministrada)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,prescripcionId,horaReal,resultado,dosisAdministrada,viaAdministrada,observaciones);

@override
String toString() {
  return 'RegisterMarEntryRequest(prescripcionId: $prescripcionId, horaReal: $horaReal, resultado: $resultado, dosisAdministrada: $dosisAdministrada, viaAdministrada: $viaAdministrada, observaciones: $observaciones)';
}


}

/// @nodoc
abstract mixin class _$RegisterMarEntryRequestCopyWith<$Res> implements $RegisterMarEntryRequestCopyWith<$Res> {
  factory _$RegisterMarEntryRequestCopyWith(_RegisterMarEntryRequest value, $Res Function(_RegisterMarEntryRequest) _then) = __$RegisterMarEntryRequestCopyWithImpl;
@override @useResult
$Res call({
 String prescripcionId, DateTime horaReal, ResultadoAdministracion resultado, String? dosisAdministrada, String? viaAdministrada, String? observaciones
});




}
/// @nodoc
class __$RegisterMarEntryRequestCopyWithImpl<$Res>
    implements _$RegisterMarEntryRequestCopyWith<$Res> {
  __$RegisterMarEntryRequestCopyWithImpl(this._self, this._then);

  final _RegisterMarEntryRequest _self;
  final $Res Function(_RegisterMarEntryRequest) _then;

/// Create a copy of RegisterMarEntryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prescripcionId = null,Object? horaReal = null,Object? resultado = null,Object? dosisAdministrada = freezed,Object? viaAdministrada = freezed,Object? observaciones = freezed,}) {
  return _then(_RegisterMarEntryRequest(
prescripcionId: null == prescripcionId ? _self.prescripcionId : prescripcionId // ignore: cast_nullable_to_non_nullable
as String,horaReal: null == horaReal ? _self.horaReal : horaReal // ignore: cast_nullable_to_non_nullable
as DateTime,resultado: null == resultado ? _self.resultado : resultado // ignore: cast_nullable_to_non_nullable
as ResultadoAdministracion,dosisAdministrada: freezed == dosisAdministrada ? _self.dosisAdministrada : dosisAdministrada // ignore: cast_nullable_to_non_nullable
as String?,viaAdministrada: freezed == viaAdministrada ? _self.viaAdministrada : viaAdministrada // ignore: cast_nullable_to_non_nullable
as String?,observaciones: freezed == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
