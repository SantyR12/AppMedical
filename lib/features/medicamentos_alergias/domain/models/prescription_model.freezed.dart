// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrescriptionModel {

 String get id; String get pacienteId; String get medicoId; String get medicoNombre; String get medicamentoId; String get medicamentoNombre; double get dosis; DoseUnit get dosisUnidad;// Frecuencia en horas (ej: cada 8 horas = 8)
 int get frecuenciaHoras; AdministrationRoute get viaAdministracion; int get duracionDias; String? get indicacionesEspeciales; PrescriptionStatus get estado; DateTime? get fechaPrescripcion;// Firma digital (PB-15 criterio 5)
 String? get firmaDigital; String? get matriculaMedico;
/// Create a copy of PrescriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrescriptionModelCopyWith<PrescriptionModel> get copyWith => _$PrescriptionModelCopyWithImpl<PrescriptionModel>(this as PrescriptionModel, _$identity);

  /// Serializes this PrescriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.medicoId, medicoId) || other.medicoId == medicoId)&&(identical(other.medicoNombre, medicoNombre) || other.medicoNombre == medicoNombre)&&(identical(other.medicamentoId, medicamentoId) || other.medicamentoId == medicamentoId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre)&&(identical(other.dosis, dosis) || other.dosis == dosis)&&(identical(other.dosisUnidad, dosisUnidad) || other.dosisUnidad == dosisUnidad)&&(identical(other.frecuenciaHoras, frecuenciaHoras) || other.frecuenciaHoras == frecuenciaHoras)&&(identical(other.viaAdministracion, viaAdministracion) || other.viaAdministracion == viaAdministracion)&&(identical(other.duracionDias, duracionDias) || other.duracionDias == duracionDias)&&(identical(other.indicacionesEspeciales, indicacionesEspeciales) || other.indicacionesEspeciales == indicacionesEspeciales)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.fechaPrescripcion, fechaPrescripcion) || other.fechaPrescripcion == fechaPrescripcion)&&(identical(other.firmaDigital, firmaDigital) || other.firmaDigital == firmaDigital)&&(identical(other.matriculaMedico, matriculaMedico) || other.matriculaMedico == matriculaMedico));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,medicoId,medicoNombre,medicamentoId,medicamentoNombre,dosis,dosisUnidad,frecuenciaHoras,viaAdministracion,duracionDias,indicacionesEspeciales,estado,fechaPrescripcion,firmaDigital,matriculaMedico);

@override
String toString() {
  return 'PrescriptionModel(id: $id, pacienteId: $pacienteId, medicoId: $medicoId, medicoNombre: $medicoNombre, medicamentoId: $medicamentoId, medicamentoNombre: $medicamentoNombre, dosis: $dosis, dosisUnidad: $dosisUnidad, frecuenciaHoras: $frecuenciaHoras, viaAdministracion: $viaAdministracion, duracionDias: $duracionDias, indicacionesEspeciales: $indicacionesEspeciales, estado: $estado, fechaPrescripcion: $fechaPrescripcion, firmaDigital: $firmaDigital, matriculaMedico: $matriculaMedico)';
}


}

/// @nodoc
abstract mixin class $PrescriptionModelCopyWith<$Res>  {
  factory $PrescriptionModelCopyWith(PrescriptionModel value, $Res Function(PrescriptionModel) _then) = _$PrescriptionModelCopyWithImpl;
@useResult
$Res call({
 String id, String pacienteId, String medicoId, String medicoNombre, String medicamentoId, String medicamentoNombre, double dosis, DoseUnit dosisUnidad, int frecuenciaHoras, AdministrationRoute viaAdministracion, int duracionDias, String? indicacionesEspeciales, PrescriptionStatus estado, DateTime? fechaPrescripcion, String? firmaDigital, String? matriculaMedico
});




}
/// @nodoc
class _$PrescriptionModelCopyWithImpl<$Res>
    implements $PrescriptionModelCopyWith<$Res> {
  _$PrescriptionModelCopyWithImpl(this._self, this._then);

  final PrescriptionModel _self;
  final $Res Function(PrescriptionModel) _then;

/// Create a copy of PrescriptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pacienteId = null,Object? medicoId = null,Object? medicoNombre = null,Object? medicamentoId = null,Object? medicamentoNombre = null,Object? dosis = null,Object? dosisUnidad = null,Object? frecuenciaHoras = null,Object? viaAdministracion = null,Object? duracionDias = null,Object? indicacionesEspeciales = freezed,Object? estado = null,Object? fechaPrescripcion = freezed,Object? firmaDigital = freezed,Object? matriculaMedico = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,medicoId: null == medicoId ? _self.medicoId : medicoId // ignore: cast_nullable_to_non_nullable
as String,medicoNombre: null == medicoNombre ? _self.medicoNombre : medicoNombre // ignore: cast_nullable_to_non_nullable
as String,medicamentoId: null == medicamentoId ? _self.medicamentoId : medicamentoId // ignore: cast_nullable_to_non_nullable
as String,medicamentoNombre: null == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String,dosis: null == dosis ? _self.dosis : dosis // ignore: cast_nullable_to_non_nullable
as double,dosisUnidad: null == dosisUnidad ? _self.dosisUnidad : dosisUnidad // ignore: cast_nullable_to_non_nullable
as DoseUnit,frecuenciaHoras: null == frecuenciaHoras ? _self.frecuenciaHoras : frecuenciaHoras // ignore: cast_nullable_to_non_nullable
as int,viaAdministracion: null == viaAdministracion ? _self.viaAdministracion : viaAdministracion // ignore: cast_nullable_to_non_nullable
as AdministrationRoute,duracionDias: null == duracionDias ? _self.duracionDias : duracionDias // ignore: cast_nullable_to_non_nullable
as int,indicacionesEspeciales: freezed == indicacionesEspeciales ? _self.indicacionesEspeciales : indicacionesEspeciales // ignore: cast_nullable_to_non_nullable
as String?,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as PrescriptionStatus,fechaPrescripcion: freezed == fechaPrescripcion ? _self.fechaPrescripcion : fechaPrescripcion // ignore: cast_nullable_to_non_nullable
as DateTime?,firmaDigital: freezed == firmaDigital ? _self.firmaDigital : firmaDigital // ignore: cast_nullable_to_non_nullable
as String?,matriculaMedico: freezed == matriculaMedico ? _self.matriculaMedico : matriculaMedico // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrescriptionModel].
extension PrescriptionModelPatterns on PrescriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrescriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrescriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrescriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _PrescriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrescriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PrescriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pacienteId,  String medicoId,  String medicoNombre,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales,  PrescriptionStatus estado,  DateTime? fechaPrescripcion,  String? firmaDigital,  String? matriculaMedico)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrescriptionModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.medicoId,_that.medicoNombre,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales,_that.estado,_that.fechaPrescripcion,_that.firmaDigital,_that.matriculaMedico);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pacienteId,  String medicoId,  String medicoNombre,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales,  PrescriptionStatus estado,  DateTime? fechaPrescripcion,  String? firmaDigital,  String? matriculaMedico)  $default,) {final _that = this;
switch (_that) {
case _PrescriptionModel():
return $default(_that.id,_that.pacienteId,_that.medicoId,_that.medicoNombre,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales,_that.estado,_that.fechaPrescripcion,_that.firmaDigital,_that.matriculaMedico);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pacienteId,  String medicoId,  String medicoNombre,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales,  PrescriptionStatus estado,  DateTime? fechaPrescripcion,  String? firmaDigital,  String? matriculaMedico)?  $default,) {final _that = this;
switch (_that) {
case _PrescriptionModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.medicoId,_that.medicoNombre,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales,_that.estado,_that.fechaPrescripcion,_that.firmaDigital,_that.matriculaMedico);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrescriptionModel implements PrescriptionModel {
  const _PrescriptionModel({required this.id, required this.pacienteId, required this.medicoId, required this.medicoNombre, required this.medicamentoId, required this.medicamentoNombre, required this.dosis, required this.dosisUnidad, required this.frecuenciaHoras, required this.viaAdministracion, required this.duracionDias, this.indicacionesEspeciales, this.estado = PrescriptionStatus.activa, this.fechaPrescripcion, this.firmaDigital, this.matriculaMedico});
  factory _PrescriptionModel.fromJson(Map<String, dynamic> json) => _$PrescriptionModelFromJson(json);

@override final  String id;
@override final  String pacienteId;
@override final  String medicoId;
@override final  String medicoNombre;
@override final  String medicamentoId;
@override final  String medicamentoNombre;
@override final  double dosis;
@override final  DoseUnit dosisUnidad;
// Frecuencia en horas (ej: cada 8 horas = 8)
@override final  int frecuenciaHoras;
@override final  AdministrationRoute viaAdministracion;
@override final  int duracionDias;
@override final  String? indicacionesEspeciales;
@override@JsonKey() final  PrescriptionStatus estado;
@override final  DateTime? fechaPrescripcion;
// Firma digital (PB-15 criterio 5)
@override final  String? firmaDigital;
@override final  String? matriculaMedico;

/// Create a copy of PrescriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrescriptionModelCopyWith<_PrescriptionModel> get copyWith => __$PrescriptionModelCopyWithImpl<_PrescriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrescriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrescriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.medicoId, medicoId) || other.medicoId == medicoId)&&(identical(other.medicoNombre, medicoNombre) || other.medicoNombre == medicoNombre)&&(identical(other.medicamentoId, medicamentoId) || other.medicamentoId == medicamentoId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre)&&(identical(other.dosis, dosis) || other.dosis == dosis)&&(identical(other.dosisUnidad, dosisUnidad) || other.dosisUnidad == dosisUnidad)&&(identical(other.frecuenciaHoras, frecuenciaHoras) || other.frecuenciaHoras == frecuenciaHoras)&&(identical(other.viaAdministracion, viaAdministracion) || other.viaAdministracion == viaAdministracion)&&(identical(other.duracionDias, duracionDias) || other.duracionDias == duracionDias)&&(identical(other.indicacionesEspeciales, indicacionesEspeciales) || other.indicacionesEspeciales == indicacionesEspeciales)&&(identical(other.estado, estado) || other.estado == estado)&&(identical(other.fechaPrescripcion, fechaPrescripcion) || other.fechaPrescripcion == fechaPrescripcion)&&(identical(other.firmaDigital, firmaDigital) || other.firmaDigital == firmaDigital)&&(identical(other.matriculaMedico, matriculaMedico) || other.matriculaMedico == matriculaMedico));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,medicoId,medicoNombre,medicamentoId,medicamentoNombre,dosis,dosisUnidad,frecuenciaHoras,viaAdministracion,duracionDias,indicacionesEspeciales,estado,fechaPrescripcion,firmaDigital,matriculaMedico);

@override
String toString() {
  return 'PrescriptionModel(id: $id, pacienteId: $pacienteId, medicoId: $medicoId, medicoNombre: $medicoNombre, medicamentoId: $medicamentoId, medicamentoNombre: $medicamentoNombre, dosis: $dosis, dosisUnidad: $dosisUnidad, frecuenciaHoras: $frecuenciaHoras, viaAdministracion: $viaAdministracion, duracionDias: $duracionDias, indicacionesEspeciales: $indicacionesEspeciales, estado: $estado, fechaPrescripcion: $fechaPrescripcion, firmaDigital: $firmaDigital, matriculaMedico: $matriculaMedico)';
}


}

/// @nodoc
abstract mixin class _$PrescriptionModelCopyWith<$Res> implements $PrescriptionModelCopyWith<$Res> {
  factory _$PrescriptionModelCopyWith(_PrescriptionModel value, $Res Function(_PrescriptionModel) _then) = __$PrescriptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String pacienteId, String medicoId, String medicoNombre, String medicamentoId, String medicamentoNombre, double dosis, DoseUnit dosisUnidad, int frecuenciaHoras, AdministrationRoute viaAdministracion, int duracionDias, String? indicacionesEspeciales, PrescriptionStatus estado, DateTime? fechaPrescripcion, String? firmaDigital, String? matriculaMedico
});




}
/// @nodoc
class __$PrescriptionModelCopyWithImpl<$Res>
    implements _$PrescriptionModelCopyWith<$Res> {
  __$PrescriptionModelCopyWithImpl(this._self, this._then);

  final _PrescriptionModel _self;
  final $Res Function(_PrescriptionModel) _then;

/// Create a copy of PrescriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pacienteId = null,Object? medicoId = null,Object? medicoNombre = null,Object? medicamentoId = null,Object? medicamentoNombre = null,Object? dosis = null,Object? dosisUnidad = null,Object? frecuenciaHoras = null,Object? viaAdministracion = null,Object? duracionDias = null,Object? indicacionesEspeciales = freezed,Object? estado = null,Object? fechaPrescripcion = freezed,Object? firmaDigital = freezed,Object? matriculaMedico = freezed,}) {
  return _then(_PrescriptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,medicoId: null == medicoId ? _self.medicoId : medicoId // ignore: cast_nullable_to_non_nullable
as String,medicoNombre: null == medicoNombre ? _self.medicoNombre : medicoNombre // ignore: cast_nullable_to_non_nullable
as String,medicamentoId: null == medicamentoId ? _self.medicamentoId : medicamentoId // ignore: cast_nullable_to_non_nullable
as String,medicamentoNombre: null == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String,dosis: null == dosis ? _self.dosis : dosis // ignore: cast_nullable_to_non_nullable
as double,dosisUnidad: null == dosisUnidad ? _self.dosisUnidad : dosisUnidad // ignore: cast_nullable_to_non_nullable
as DoseUnit,frecuenciaHoras: null == frecuenciaHoras ? _self.frecuenciaHoras : frecuenciaHoras // ignore: cast_nullable_to_non_nullable
as int,viaAdministracion: null == viaAdministracion ? _self.viaAdministracion : viaAdministracion // ignore: cast_nullable_to_non_nullable
as AdministrationRoute,duracionDias: null == duracionDias ? _self.duracionDias : duracionDias // ignore: cast_nullable_to_non_nullable
as int,indicacionesEspeciales: freezed == indicacionesEspeciales ? _self.indicacionesEspeciales : indicacionesEspeciales // ignore: cast_nullable_to_non_nullable
as String?,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as PrescriptionStatus,fechaPrescripcion: freezed == fechaPrescripcion ? _self.fechaPrescripcion : fechaPrescripcion // ignore: cast_nullable_to_non_nullable
as DateTime?,firmaDigital: freezed == firmaDigital ? _self.firmaDigital : firmaDigital // ignore: cast_nullable_to_non_nullable
as String?,matriculaMedico: freezed == matriculaMedico ? _self.matriculaMedico : matriculaMedico // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreatePrescriptionRequest {

 String get pacienteId; String get medicamentoId; String get medicamentoNombre; double get dosis; DoseUnit get dosisUnidad; int get frecuenciaHoras; AdministrationRoute get viaAdministracion; int get duracionDias; String? get indicacionesEspeciales;
/// Create a copy of CreatePrescriptionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePrescriptionRequestCopyWith<CreatePrescriptionRequest> get copyWith => _$CreatePrescriptionRequestCopyWithImpl<CreatePrescriptionRequest>(this as CreatePrescriptionRequest, _$identity);

  /// Serializes this CreatePrescriptionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePrescriptionRequest&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.medicamentoId, medicamentoId) || other.medicamentoId == medicamentoId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre)&&(identical(other.dosis, dosis) || other.dosis == dosis)&&(identical(other.dosisUnidad, dosisUnidad) || other.dosisUnidad == dosisUnidad)&&(identical(other.frecuenciaHoras, frecuenciaHoras) || other.frecuenciaHoras == frecuenciaHoras)&&(identical(other.viaAdministracion, viaAdministracion) || other.viaAdministracion == viaAdministracion)&&(identical(other.duracionDias, duracionDias) || other.duracionDias == duracionDias)&&(identical(other.indicacionesEspeciales, indicacionesEspeciales) || other.indicacionesEspeciales == indicacionesEspeciales));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pacienteId,medicamentoId,medicamentoNombre,dosis,dosisUnidad,frecuenciaHoras,viaAdministracion,duracionDias,indicacionesEspeciales);

@override
String toString() {
  return 'CreatePrescriptionRequest(pacienteId: $pacienteId, medicamentoId: $medicamentoId, medicamentoNombre: $medicamentoNombre, dosis: $dosis, dosisUnidad: $dosisUnidad, frecuenciaHoras: $frecuenciaHoras, viaAdministracion: $viaAdministracion, duracionDias: $duracionDias, indicacionesEspeciales: $indicacionesEspeciales)';
}


}

/// @nodoc
abstract mixin class $CreatePrescriptionRequestCopyWith<$Res>  {
  factory $CreatePrescriptionRequestCopyWith(CreatePrescriptionRequest value, $Res Function(CreatePrescriptionRequest) _then) = _$CreatePrescriptionRequestCopyWithImpl;
@useResult
$Res call({
 String pacienteId, String medicamentoId, String medicamentoNombre, double dosis, DoseUnit dosisUnidad, int frecuenciaHoras, AdministrationRoute viaAdministracion, int duracionDias, String? indicacionesEspeciales
});




}
/// @nodoc
class _$CreatePrescriptionRequestCopyWithImpl<$Res>
    implements $CreatePrescriptionRequestCopyWith<$Res> {
  _$CreatePrescriptionRequestCopyWithImpl(this._self, this._then);

  final CreatePrescriptionRequest _self;
  final $Res Function(CreatePrescriptionRequest) _then;

/// Create a copy of CreatePrescriptionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pacienteId = null,Object? medicamentoId = null,Object? medicamentoNombre = null,Object? dosis = null,Object? dosisUnidad = null,Object? frecuenciaHoras = null,Object? viaAdministracion = null,Object? duracionDias = null,Object? indicacionesEspeciales = freezed,}) {
  return _then(_self.copyWith(
pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,medicamentoId: null == medicamentoId ? _self.medicamentoId : medicamentoId // ignore: cast_nullable_to_non_nullable
as String,medicamentoNombre: null == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String,dosis: null == dosis ? _self.dosis : dosis // ignore: cast_nullable_to_non_nullable
as double,dosisUnidad: null == dosisUnidad ? _self.dosisUnidad : dosisUnidad // ignore: cast_nullable_to_non_nullable
as DoseUnit,frecuenciaHoras: null == frecuenciaHoras ? _self.frecuenciaHoras : frecuenciaHoras // ignore: cast_nullable_to_non_nullable
as int,viaAdministracion: null == viaAdministracion ? _self.viaAdministracion : viaAdministracion // ignore: cast_nullable_to_non_nullable
as AdministrationRoute,duracionDias: null == duracionDias ? _self.duracionDias : duracionDias // ignore: cast_nullable_to_non_nullable
as int,indicacionesEspeciales: freezed == indicacionesEspeciales ? _self.indicacionesEspeciales : indicacionesEspeciales // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePrescriptionRequest].
extension CreatePrescriptionRequestPatterns on CreatePrescriptionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePrescriptionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePrescriptionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePrescriptionRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePrescriptionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePrescriptionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePrescriptionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pacienteId,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePrescriptionRequest() when $default != null:
return $default(_that.pacienteId,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pacienteId,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales)  $default,) {final _that = this;
switch (_that) {
case _CreatePrescriptionRequest():
return $default(_that.pacienteId,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pacienteId,  String medicamentoId,  String medicamentoNombre,  double dosis,  DoseUnit dosisUnidad,  int frecuenciaHoras,  AdministrationRoute viaAdministracion,  int duracionDias,  String? indicacionesEspeciales)?  $default,) {final _that = this;
switch (_that) {
case _CreatePrescriptionRequest() when $default != null:
return $default(_that.pacienteId,_that.medicamentoId,_that.medicamentoNombre,_that.dosis,_that.dosisUnidad,_that.frecuenciaHoras,_that.viaAdministracion,_that.duracionDias,_that.indicacionesEspeciales);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePrescriptionRequest implements CreatePrescriptionRequest {
  const _CreatePrescriptionRequest({required this.pacienteId, required this.medicamentoId, required this.medicamentoNombre, required this.dosis, required this.dosisUnidad, required this.frecuenciaHoras, required this.viaAdministracion, required this.duracionDias, this.indicacionesEspeciales});
  factory _CreatePrescriptionRequest.fromJson(Map<String, dynamic> json) => _$CreatePrescriptionRequestFromJson(json);

@override final  String pacienteId;
@override final  String medicamentoId;
@override final  String medicamentoNombre;
@override final  double dosis;
@override final  DoseUnit dosisUnidad;
@override final  int frecuenciaHoras;
@override final  AdministrationRoute viaAdministracion;
@override final  int duracionDias;
@override final  String? indicacionesEspeciales;

/// Create a copy of CreatePrescriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePrescriptionRequestCopyWith<_CreatePrescriptionRequest> get copyWith => __$CreatePrescriptionRequestCopyWithImpl<_CreatePrescriptionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePrescriptionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePrescriptionRequest&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.medicamentoId, medicamentoId) || other.medicamentoId == medicamentoId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre)&&(identical(other.dosis, dosis) || other.dosis == dosis)&&(identical(other.dosisUnidad, dosisUnidad) || other.dosisUnidad == dosisUnidad)&&(identical(other.frecuenciaHoras, frecuenciaHoras) || other.frecuenciaHoras == frecuenciaHoras)&&(identical(other.viaAdministracion, viaAdministracion) || other.viaAdministracion == viaAdministracion)&&(identical(other.duracionDias, duracionDias) || other.duracionDias == duracionDias)&&(identical(other.indicacionesEspeciales, indicacionesEspeciales) || other.indicacionesEspeciales == indicacionesEspeciales));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pacienteId,medicamentoId,medicamentoNombre,dosis,dosisUnidad,frecuenciaHoras,viaAdministracion,duracionDias,indicacionesEspeciales);

@override
String toString() {
  return 'CreatePrescriptionRequest(pacienteId: $pacienteId, medicamentoId: $medicamentoId, medicamentoNombre: $medicamentoNombre, dosis: $dosis, dosisUnidad: $dosisUnidad, frecuenciaHoras: $frecuenciaHoras, viaAdministracion: $viaAdministracion, duracionDias: $duracionDias, indicacionesEspeciales: $indicacionesEspeciales)';
}


}

/// @nodoc
abstract mixin class _$CreatePrescriptionRequestCopyWith<$Res> implements $CreatePrescriptionRequestCopyWith<$Res> {
  factory _$CreatePrescriptionRequestCopyWith(_CreatePrescriptionRequest value, $Res Function(_CreatePrescriptionRequest) _then) = __$CreatePrescriptionRequestCopyWithImpl;
@override @useResult
$Res call({
 String pacienteId, String medicamentoId, String medicamentoNombre, double dosis, DoseUnit dosisUnidad, int frecuenciaHoras, AdministrationRoute viaAdministracion, int duracionDias, String? indicacionesEspeciales
});




}
/// @nodoc
class __$CreatePrescriptionRequestCopyWithImpl<$Res>
    implements _$CreatePrescriptionRequestCopyWith<$Res> {
  __$CreatePrescriptionRequestCopyWithImpl(this._self, this._then);

  final _CreatePrescriptionRequest _self;
  final $Res Function(_CreatePrescriptionRequest) _then;

/// Create a copy of CreatePrescriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pacienteId = null,Object? medicamentoId = null,Object? medicamentoNombre = null,Object? dosis = null,Object? dosisUnidad = null,Object? frecuenciaHoras = null,Object? viaAdministracion = null,Object? duracionDias = null,Object? indicacionesEspeciales = freezed,}) {
  return _then(_CreatePrescriptionRequest(
pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,medicamentoId: null == medicamentoId ? _self.medicamentoId : medicamentoId // ignore: cast_nullable_to_non_nullable
as String,medicamentoNombre: null == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String,dosis: null == dosis ? _self.dosis : dosis // ignore: cast_nullable_to_non_nullable
as double,dosisUnidad: null == dosisUnidad ? _self.dosisUnidad : dosisUnidad // ignore: cast_nullable_to_non_nullable
as DoseUnit,frecuenciaHoras: null == frecuenciaHoras ? _self.frecuenciaHoras : frecuenciaHoras // ignore: cast_nullable_to_non_nullable
as int,viaAdministracion: null == viaAdministracion ? _self.viaAdministracion : viaAdministracion // ignore: cast_nullable_to_non_nullable
as AdministrationRoute,duracionDias: null == duracionDias ? _self.duracionDias : duracionDias // ignore: cast_nullable_to_non_nullable
as int,indicacionesEspeciales: freezed == indicacionesEspeciales ? _self.indicacionesEspeciales : indicacionesEspeciales // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DuplicityAlert {

 bool get hasDuplicity; String? get existingPrescriptionId; String? get medicamentoNombre;
/// Create a copy of DuplicityAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DuplicityAlertCopyWith<DuplicityAlert> get copyWith => _$DuplicityAlertCopyWithImpl<DuplicityAlert>(this as DuplicityAlert, _$identity);

  /// Serializes this DuplicityAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicityAlert&&(identical(other.hasDuplicity, hasDuplicity) || other.hasDuplicity == hasDuplicity)&&(identical(other.existingPrescriptionId, existingPrescriptionId) || other.existingPrescriptionId == existingPrescriptionId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasDuplicity,existingPrescriptionId,medicamentoNombre);

@override
String toString() {
  return 'DuplicityAlert(hasDuplicity: $hasDuplicity, existingPrescriptionId: $existingPrescriptionId, medicamentoNombre: $medicamentoNombre)';
}


}

/// @nodoc
abstract mixin class $DuplicityAlertCopyWith<$Res>  {
  factory $DuplicityAlertCopyWith(DuplicityAlert value, $Res Function(DuplicityAlert) _then) = _$DuplicityAlertCopyWithImpl;
@useResult
$Res call({
 bool hasDuplicity, String? existingPrescriptionId, String? medicamentoNombre
});




}
/// @nodoc
class _$DuplicityAlertCopyWithImpl<$Res>
    implements $DuplicityAlertCopyWith<$Res> {
  _$DuplicityAlertCopyWithImpl(this._self, this._then);

  final DuplicityAlert _self;
  final $Res Function(DuplicityAlert) _then;

/// Create a copy of DuplicityAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasDuplicity = null,Object? existingPrescriptionId = freezed,Object? medicamentoNombre = freezed,}) {
  return _then(_self.copyWith(
hasDuplicity: null == hasDuplicity ? _self.hasDuplicity : hasDuplicity // ignore: cast_nullable_to_non_nullable
as bool,existingPrescriptionId: freezed == existingPrescriptionId ? _self.existingPrescriptionId : existingPrescriptionId // ignore: cast_nullable_to_non_nullable
as String?,medicamentoNombre: freezed == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DuplicityAlert].
extension DuplicityAlertPatterns on DuplicityAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DuplicityAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DuplicityAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DuplicityAlert value)  $default,){
final _that = this;
switch (_that) {
case _DuplicityAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DuplicityAlert value)?  $default,){
final _that = this;
switch (_that) {
case _DuplicityAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasDuplicity,  String? existingPrescriptionId,  String? medicamentoNombre)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DuplicityAlert() when $default != null:
return $default(_that.hasDuplicity,_that.existingPrescriptionId,_that.medicamentoNombre);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasDuplicity,  String? existingPrescriptionId,  String? medicamentoNombre)  $default,) {final _that = this;
switch (_that) {
case _DuplicityAlert():
return $default(_that.hasDuplicity,_that.existingPrescriptionId,_that.medicamentoNombre);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasDuplicity,  String? existingPrescriptionId,  String? medicamentoNombre)?  $default,) {final _that = this;
switch (_that) {
case _DuplicityAlert() when $default != null:
return $default(_that.hasDuplicity,_that.existingPrescriptionId,_that.medicamentoNombre);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DuplicityAlert implements DuplicityAlert {
  const _DuplicityAlert({required this.hasDuplicity, this.existingPrescriptionId, this.medicamentoNombre});
  factory _DuplicityAlert.fromJson(Map<String, dynamic> json) => _$DuplicityAlertFromJson(json);

@override final  bool hasDuplicity;
@override final  String? existingPrescriptionId;
@override final  String? medicamentoNombre;

/// Create a copy of DuplicityAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DuplicityAlertCopyWith<_DuplicityAlert> get copyWith => __$DuplicityAlertCopyWithImpl<_DuplicityAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DuplicityAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DuplicityAlert&&(identical(other.hasDuplicity, hasDuplicity) || other.hasDuplicity == hasDuplicity)&&(identical(other.existingPrescriptionId, existingPrescriptionId) || other.existingPrescriptionId == existingPrescriptionId)&&(identical(other.medicamentoNombre, medicamentoNombre) || other.medicamentoNombre == medicamentoNombre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasDuplicity,existingPrescriptionId,medicamentoNombre);

@override
String toString() {
  return 'DuplicityAlert(hasDuplicity: $hasDuplicity, existingPrescriptionId: $existingPrescriptionId, medicamentoNombre: $medicamentoNombre)';
}


}

/// @nodoc
abstract mixin class _$DuplicityAlertCopyWith<$Res> implements $DuplicityAlertCopyWith<$Res> {
  factory _$DuplicityAlertCopyWith(_DuplicityAlert value, $Res Function(_DuplicityAlert) _then) = __$DuplicityAlertCopyWithImpl;
@override @useResult
$Res call({
 bool hasDuplicity, String? existingPrescriptionId, String? medicamentoNombre
});




}
/// @nodoc
class __$DuplicityAlertCopyWithImpl<$Res>
    implements _$DuplicityAlertCopyWith<$Res> {
  __$DuplicityAlertCopyWithImpl(this._self, this._then);

  final _DuplicityAlert _self;
  final $Res Function(_DuplicityAlert) _then;

/// Create a copy of DuplicityAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasDuplicity = null,Object? existingPrescriptionId = freezed,Object? medicamentoNombre = freezed,}) {
  return _then(_DuplicityAlert(
hasDuplicity: null == hasDuplicity ? _self.hasDuplicity : hasDuplicity // ignore: cast_nullable_to_non_nullable
as bool,existingPrescriptionId: freezed == existingPrescriptionId ? _self.existingPrescriptionId : existingPrescriptionId // ignore: cast_nullable_to_non_nullable
as String?,medicamentoNombre: freezed == medicamentoNombre ? _self.medicamentoNombre : medicamentoNombre // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AllergyAlert {

 bool get hasAllergy; String? get allergyId; String? get agenteCausante; String? get severidad;
/// Create a copy of AllergyAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllergyAlertCopyWith<AllergyAlert> get copyWith => _$AllergyAlertCopyWithImpl<AllergyAlert>(this as AllergyAlert, _$identity);

  /// Serializes this AllergyAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllergyAlert&&(identical(other.hasAllergy, hasAllergy) || other.hasAllergy == hasAllergy)&&(identical(other.allergyId, allergyId) || other.allergyId == allergyId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.severidad, severidad) || other.severidad == severidad));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasAllergy,allergyId,agenteCausante,severidad);

@override
String toString() {
  return 'AllergyAlert(hasAllergy: $hasAllergy, allergyId: $allergyId, agenteCausante: $agenteCausante, severidad: $severidad)';
}


}

/// @nodoc
abstract mixin class $AllergyAlertCopyWith<$Res>  {
  factory $AllergyAlertCopyWith(AllergyAlert value, $Res Function(AllergyAlert) _then) = _$AllergyAlertCopyWithImpl;
@useResult
$Res call({
 bool hasAllergy, String? allergyId, String? agenteCausante, String? severidad
});




}
/// @nodoc
class _$AllergyAlertCopyWithImpl<$Res>
    implements $AllergyAlertCopyWith<$Res> {
  _$AllergyAlertCopyWithImpl(this._self, this._then);

  final AllergyAlert _self;
  final $Res Function(AllergyAlert) _then;

/// Create a copy of AllergyAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasAllergy = null,Object? allergyId = freezed,Object? agenteCausante = freezed,Object? severidad = freezed,}) {
  return _then(_self.copyWith(
hasAllergy: null == hasAllergy ? _self.hasAllergy : hasAllergy // ignore: cast_nullable_to_non_nullable
as bool,allergyId: freezed == allergyId ? _self.allergyId : allergyId // ignore: cast_nullable_to_non_nullable
as String?,agenteCausante: freezed == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String?,severidad: freezed == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AllergyAlert].
extension AllergyAlertPatterns on AllergyAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllergyAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllergyAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllergyAlert value)  $default,){
final _that = this;
switch (_that) {
case _AllergyAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllergyAlert value)?  $default,){
final _that = this;
switch (_that) {
case _AllergyAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasAllergy,  String? allergyId,  String? agenteCausante,  String? severidad)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllergyAlert() when $default != null:
return $default(_that.hasAllergy,_that.allergyId,_that.agenteCausante,_that.severidad);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasAllergy,  String? allergyId,  String? agenteCausante,  String? severidad)  $default,) {final _that = this;
switch (_that) {
case _AllergyAlert():
return $default(_that.hasAllergy,_that.allergyId,_that.agenteCausante,_that.severidad);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasAllergy,  String? allergyId,  String? agenteCausante,  String? severidad)?  $default,) {final _that = this;
switch (_that) {
case _AllergyAlert() when $default != null:
return $default(_that.hasAllergy,_that.allergyId,_that.agenteCausante,_that.severidad);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllergyAlert implements AllergyAlert {
  const _AllergyAlert({required this.hasAllergy, this.allergyId, this.agenteCausante, this.severidad});
  factory _AllergyAlert.fromJson(Map<String, dynamic> json) => _$AllergyAlertFromJson(json);

@override final  bool hasAllergy;
@override final  String? allergyId;
@override final  String? agenteCausante;
@override final  String? severidad;

/// Create a copy of AllergyAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllergyAlertCopyWith<_AllergyAlert> get copyWith => __$AllergyAlertCopyWithImpl<_AllergyAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllergyAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllergyAlert&&(identical(other.hasAllergy, hasAllergy) || other.hasAllergy == hasAllergy)&&(identical(other.allergyId, allergyId) || other.allergyId == allergyId)&&(identical(other.agenteCausante, agenteCausante) || other.agenteCausante == agenteCausante)&&(identical(other.severidad, severidad) || other.severidad == severidad));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasAllergy,allergyId,agenteCausante,severidad);

@override
String toString() {
  return 'AllergyAlert(hasAllergy: $hasAllergy, allergyId: $allergyId, agenteCausante: $agenteCausante, severidad: $severidad)';
}


}

/// @nodoc
abstract mixin class _$AllergyAlertCopyWith<$Res> implements $AllergyAlertCopyWith<$Res> {
  factory _$AllergyAlertCopyWith(_AllergyAlert value, $Res Function(_AllergyAlert) _then) = __$AllergyAlertCopyWithImpl;
@override @useResult
$Res call({
 bool hasAllergy, String? allergyId, String? agenteCausante, String? severidad
});




}
/// @nodoc
class __$AllergyAlertCopyWithImpl<$Res>
    implements _$AllergyAlertCopyWith<$Res> {
  __$AllergyAlertCopyWithImpl(this._self, this._then);

  final _AllergyAlert _self;
  final $Res Function(_AllergyAlert) _then;

/// Create a copy of AllergyAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasAllergy = null,Object? allergyId = freezed,Object? agenteCausante = freezed,Object? severidad = freezed,}) {
  return _then(_AllergyAlert(
hasAllergy: null == hasAllergy ? _self.hasAllergy : hasAllergy // ignore: cast_nullable_to_non_nullable
as bool,allergyId: freezed == allergyId ? _self.allergyId : allergyId // ignore: cast_nullable_to_non_nullable
as String?,agenteCausante: freezed == agenteCausante ? _self.agenteCausante : agenteCausante // ignore: cast_nullable_to_non_nullable
as String?,severidad: freezed == severidad ? _self.severidad : severidad // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
