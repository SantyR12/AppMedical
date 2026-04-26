// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmergencyContact {

 String? get nombre; String? get telefono;
/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<EmergencyContact> get copyWith => _$EmergencyContactCopyWithImpl<EmergencyContact>(this as EmergencyContact, _$identity);

  /// Serializes this EmergencyContact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyContact&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.telefono, telefono) || other.telefono == telefono));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombre,telefono);

@override
String toString() {
  return 'EmergencyContact(nombre: $nombre, telefono: $telefono)';
}


}

/// @nodoc
abstract mixin class $EmergencyContactCopyWith<$Res>  {
  factory $EmergencyContactCopyWith(EmergencyContact value, $Res Function(EmergencyContact) _then) = _$EmergencyContactCopyWithImpl;
@useResult
$Res call({
 String? nombre, String? telefono
});




}
/// @nodoc
class _$EmergencyContactCopyWithImpl<$Res>
    implements $EmergencyContactCopyWith<$Res> {
  _$EmergencyContactCopyWithImpl(this._self, this._then);

  final EmergencyContact _self;
  final $Res Function(EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombre = freezed,Object? telefono = freezed,}) {
  return _then(_self.copyWith(
nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyContact].
extension EmergencyContactPatterns on EmergencyContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyContact value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyContact value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nombre,  String? telefono)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.nombre,_that.telefono);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nombre,  String? telefono)  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact():
return $default(_that.nombre,_that.telefono);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nombre,  String? telefono)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyContact() when $default != null:
return $default(_that.nombre,_that.telefono);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmergencyContact implements EmergencyContact {
  const _EmergencyContact({this.nombre, this.telefono});
  factory _EmergencyContact.fromJson(Map<String, dynamic> json) => _$EmergencyContactFromJson(json);

@override final  String? nombre;
@override final  String? telefono;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyContactCopyWith<_EmergencyContact> get copyWith => __$EmergencyContactCopyWithImpl<_EmergencyContact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmergencyContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyContact&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.telefono, telefono) || other.telefono == telefono));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombre,telefono);

@override
String toString() {
  return 'EmergencyContact(nombre: $nombre, telefono: $telefono)';
}


}

/// @nodoc
abstract mixin class _$EmergencyContactCopyWith<$Res> implements $EmergencyContactCopyWith<$Res> {
  factory _$EmergencyContactCopyWith(_EmergencyContact value, $Res Function(_EmergencyContact) _then) = __$EmergencyContactCopyWithImpl;
@override @useResult
$Res call({
 String? nombre, String? telefono
});




}
/// @nodoc
class __$EmergencyContactCopyWithImpl<$Res>
    implements _$EmergencyContactCopyWith<$Res> {
  __$EmergencyContactCopyWithImpl(this._self, this._then);

  final _EmergencyContact _self;
  final $Res Function(_EmergencyContact) _then;

/// Create a copy of EmergencyContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombre = freezed,Object? telefono = freezed,}) {
  return _then(_EmergencyContact(
nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PatientModel {

 String get id; String get nombreCompleto; DocumentType get tipoDocumento; String get numeroDocumento; DateTime get fechaNacimiento; Sex get sexo; String? get direccion; String? get telefono; String? get correo; EmergencyContact? get contactoEmergencia;// Relación con la historia clínica
 String? get historiaClinicaId; DateTime? get creadoEn; String? get ultimoMedicoTratante;
/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientModelCopyWith<PatientModel> get copyWith => _$PatientModelCopyWithImpl<PatientModel>(this as PatientModel, _$identity);

  /// Serializes this PatientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento)&&(identical(other.sexo, sexo) || other.sexo == sexo)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.correo, correo) || other.correo == correo)&&(identical(other.contactoEmergencia, contactoEmergencia) || other.contactoEmergencia == contactoEmergencia)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.ultimoMedicoTratante, ultimoMedicoTratante) || other.ultimoMedicoTratante == ultimoMedicoTratante));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombreCompleto,tipoDocumento,numeroDocumento,fechaNacimiento,sexo,direccion,telefono,correo,contactoEmergencia,historiaClinicaId,creadoEn,ultimoMedicoTratante);

@override
String toString() {
  return 'PatientModel(id: $id, nombreCompleto: $nombreCompleto, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento, sexo: $sexo, direccion: $direccion, telefono: $telefono, correo: $correo, contactoEmergencia: $contactoEmergencia, historiaClinicaId: $historiaClinicaId, creadoEn: $creadoEn, ultimoMedicoTratante: $ultimoMedicoTratante)';
}


}

/// @nodoc
abstract mixin class $PatientModelCopyWith<$Res>  {
  factory $PatientModelCopyWith(PatientModel value, $Res Function(PatientModel) _then) = _$PatientModelCopyWithImpl;
@useResult
$Res call({
 String id, String nombreCompleto, DocumentType tipoDocumento, String numeroDocumento, DateTime fechaNacimiento, Sex sexo, String? direccion, String? telefono, String? correo, EmergencyContact? contactoEmergencia, String? historiaClinicaId, DateTime? creadoEn, String? ultimoMedicoTratante
});


$EmergencyContactCopyWith<$Res>? get contactoEmergencia;

}
/// @nodoc
class _$PatientModelCopyWithImpl<$Res>
    implements $PatientModelCopyWith<$Res> {
  _$PatientModelCopyWithImpl(this._self, this._then);

  final PatientModel _self;
  final $Res Function(PatientModel) _then;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombreCompleto = null,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? fechaNacimiento = null,Object? sexo = null,Object? direccion = freezed,Object? telefono = freezed,Object? correo = freezed,Object? contactoEmergencia = freezed,Object? historiaClinicaId = freezed,Object? creadoEn = freezed,Object? ultimoMedicoTratante = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreCompleto: null == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as DocumentType,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: null == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime,sexo: null == sexo ? _self.sexo : sexo // ignore: cast_nullable_to_non_nullable
as Sex,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,correo: freezed == correo ? _self.correo : correo // ignore: cast_nullable_to_non_nullable
as String?,contactoEmergencia: freezed == contactoEmergencia ? _self.contactoEmergencia : contactoEmergencia // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,historiaClinicaId: freezed == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,ultimoMedicoTratante: freezed == ultimoMedicoTratante ? _self.ultimoMedicoTratante : ultimoMedicoTratante // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get contactoEmergencia {
    if (_self.contactoEmergencia == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.contactoEmergencia!, (value) {
    return _then(_self.copyWith(contactoEmergencia: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatientModel].
extension PatientModelPatterns on PatientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientModel value)  $default,){
final _that = this;
switch (_that) {
case _PatientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientModel value)?  $default,){
final _that = this;
switch (_that) {
case _PatientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia,  String? historiaClinicaId,  DateTime? creadoEn,  String? ultimoMedicoTratante)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientModel() when $default != null:
return $default(_that.id,_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia,_that.historiaClinicaId,_that.creadoEn,_that.ultimoMedicoTratante);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia,  String? historiaClinicaId,  DateTime? creadoEn,  String? ultimoMedicoTratante)  $default,) {final _that = this;
switch (_that) {
case _PatientModel():
return $default(_that.id,_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia,_that.historiaClinicaId,_that.creadoEn,_that.ultimoMedicoTratante);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia,  String? historiaClinicaId,  DateTime? creadoEn,  String? ultimoMedicoTratante)?  $default,) {final _that = this;
switch (_that) {
case _PatientModel() when $default != null:
return $default(_that.id,_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia,_that.historiaClinicaId,_that.creadoEn,_that.ultimoMedicoTratante);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientModel implements PatientModel {
  const _PatientModel({required this.id, required this.nombreCompleto, required this.tipoDocumento, required this.numeroDocumento, required this.fechaNacimiento, required this.sexo, this.direccion, this.telefono, this.correo, this.contactoEmergencia, this.historiaClinicaId, this.creadoEn, this.ultimoMedicoTratante});
  factory _PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);

@override final  String id;
@override final  String nombreCompleto;
@override final  DocumentType tipoDocumento;
@override final  String numeroDocumento;
@override final  DateTime fechaNacimiento;
@override final  Sex sexo;
@override final  String? direccion;
@override final  String? telefono;
@override final  String? correo;
@override final  EmergencyContact? contactoEmergencia;
// Relación con la historia clínica
@override final  String? historiaClinicaId;
@override final  DateTime? creadoEn;
@override final  String? ultimoMedicoTratante;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientModelCopyWith<_PatientModel> get copyWith => __$PatientModelCopyWithImpl<_PatientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento)&&(identical(other.sexo, sexo) || other.sexo == sexo)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.correo, correo) || other.correo == correo)&&(identical(other.contactoEmergencia, contactoEmergencia) || other.contactoEmergencia == contactoEmergencia)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn)&&(identical(other.ultimoMedicoTratante, ultimoMedicoTratante) || other.ultimoMedicoTratante == ultimoMedicoTratante));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombreCompleto,tipoDocumento,numeroDocumento,fechaNacimiento,sexo,direccion,telefono,correo,contactoEmergencia,historiaClinicaId,creadoEn,ultimoMedicoTratante);

@override
String toString() {
  return 'PatientModel(id: $id, nombreCompleto: $nombreCompleto, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento, sexo: $sexo, direccion: $direccion, telefono: $telefono, correo: $correo, contactoEmergencia: $contactoEmergencia, historiaClinicaId: $historiaClinicaId, creadoEn: $creadoEn, ultimoMedicoTratante: $ultimoMedicoTratante)';
}


}

/// @nodoc
abstract mixin class _$PatientModelCopyWith<$Res> implements $PatientModelCopyWith<$Res> {
  factory _$PatientModelCopyWith(_PatientModel value, $Res Function(_PatientModel) _then) = __$PatientModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String nombreCompleto, DocumentType tipoDocumento, String numeroDocumento, DateTime fechaNacimiento, Sex sexo, String? direccion, String? telefono, String? correo, EmergencyContact? contactoEmergencia, String? historiaClinicaId, DateTime? creadoEn, String? ultimoMedicoTratante
});


@override $EmergencyContactCopyWith<$Res>? get contactoEmergencia;

}
/// @nodoc
class __$PatientModelCopyWithImpl<$Res>
    implements _$PatientModelCopyWith<$Res> {
  __$PatientModelCopyWithImpl(this._self, this._then);

  final _PatientModel _self;
  final $Res Function(_PatientModel) _then;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombreCompleto = null,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? fechaNacimiento = null,Object? sexo = null,Object? direccion = freezed,Object? telefono = freezed,Object? correo = freezed,Object? contactoEmergencia = freezed,Object? historiaClinicaId = freezed,Object? creadoEn = freezed,Object? ultimoMedicoTratante = freezed,}) {
  return _then(_PatientModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nombreCompleto: null == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as DocumentType,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: null == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime,sexo: null == sexo ? _self.sexo : sexo // ignore: cast_nullable_to_non_nullable
as Sex,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,correo: freezed == correo ? _self.correo : correo // ignore: cast_nullable_to_non_nullable
as String?,contactoEmergencia: freezed == contactoEmergencia ? _self.contactoEmergencia : contactoEmergencia // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,historiaClinicaId: freezed == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,ultimoMedicoTratante: freezed == ultimoMedicoTratante ? _self.ultimoMedicoTratante : ultimoMedicoTratante // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get contactoEmergencia {
    if (_self.contactoEmergencia == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.contactoEmergencia!, (value) {
    return _then(_self.copyWith(contactoEmergencia: value));
  });
}
}


/// @nodoc
mixin _$ClinicalRecordModel {

 String get id; String get pacienteId; PatientModel get paciente; RecordStatus get estado;// Listas de los otros módulos — llegan como referencias
 List<String> get alergiasIds; List<String> get medicamentosActivosIds; List<String> get diagnosticosIds; List<String> get consultasPreviasIds;// Log de auditoría — quién editó y cuándo (PB-09 criterio 2)
 String? get ultimoEditadoPor; String? get ultimoEditadoDesde; DateTime? get ultimaEdicionEn; DateTime? get creadoEn;
/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClinicalRecordModelCopyWith<ClinicalRecordModel> get copyWith => _$ClinicalRecordModelCopyWithImpl<ClinicalRecordModel>(this as ClinicalRecordModel, _$identity);

  /// Serializes this ClinicalRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicalRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.paciente, paciente) || other.paciente == paciente)&&(identical(other.estado, estado) || other.estado == estado)&&const DeepCollectionEquality().equals(other.alergiasIds, alergiasIds)&&const DeepCollectionEquality().equals(other.medicamentosActivosIds, medicamentosActivosIds)&&const DeepCollectionEquality().equals(other.diagnosticosIds, diagnosticosIds)&&const DeepCollectionEquality().equals(other.consultasPreviasIds, consultasPreviasIds)&&(identical(other.ultimoEditadoPor, ultimoEditadoPor) || other.ultimoEditadoPor == ultimoEditadoPor)&&(identical(other.ultimoEditadoDesde, ultimoEditadoDesde) || other.ultimoEditadoDesde == ultimoEditadoDesde)&&(identical(other.ultimaEdicionEn, ultimaEdicionEn) || other.ultimaEdicionEn == ultimaEdicionEn)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,paciente,estado,const DeepCollectionEquality().hash(alergiasIds),const DeepCollectionEquality().hash(medicamentosActivosIds),const DeepCollectionEquality().hash(diagnosticosIds),const DeepCollectionEquality().hash(consultasPreviasIds),ultimoEditadoPor,ultimoEditadoDesde,ultimaEdicionEn,creadoEn);

@override
String toString() {
  return 'ClinicalRecordModel(id: $id, pacienteId: $pacienteId, paciente: $paciente, estado: $estado, alergiasIds: $alergiasIds, medicamentosActivosIds: $medicamentosActivosIds, diagnosticosIds: $diagnosticosIds, consultasPreviasIds: $consultasPreviasIds, ultimoEditadoPor: $ultimoEditadoPor, ultimoEditadoDesde: $ultimoEditadoDesde, ultimaEdicionEn: $ultimaEdicionEn, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class $ClinicalRecordModelCopyWith<$Res>  {
  factory $ClinicalRecordModelCopyWith(ClinicalRecordModel value, $Res Function(ClinicalRecordModel) _then) = _$ClinicalRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String pacienteId, PatientModel paciente, RecordStatus estado, List<String> alergiasIds, List<String> medicamentosActivosIds, List<String> diagnosticosIds, List<String> consultasPreviasIds, String? ultimoEditadoPor, String? ultimoEditadoDesde, DateTime? ultimaEdicionEn, DateTime? creadoEn
});


$PatientModelCopyWith<$Res> get paciente;

}
/// @nodoc
class _$ClinicalRecordModelCopyWithImpl<$Res>
    implements $ClinicalRecordModelCopyWith<$Res> {
  _$ClinicalRecordModelCopyWithImpl(this._self, this._then);

  final ClinicalRecordModel _self;
  final $Res Function(ClinicalRecordModel) _then;

/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pacienteId = null,Object? paciente = null,Object? estado = null,Object? alergiasIds = null,Object? medicamentosActivosIds = null,Object? diagnosticosIds = null,Object? consultasPreviasIds = null,Object? ultimoEditadoPor = freezed,Object? ultimoEditadoDesde = freezed,Object? ultimaEdicionEn = freezed,Object? creadoEn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,paciente: null == paciente ? _self.paciente : paciente // ignore: cast_nullable_to_non_nullable
as PatientModel,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as RecordStatus,alergiasIds: null == alergiasIds ? _self.alergiasIds : alergiasIds // ignore: cast_nullable_to_non_nullable
as List<String>,medicamentosActivosIds: null == medicamentosActivosIds ? _self.medicamentosActivosIds : medicamentosActivosIds // ignore: cast_nullable_to_non_nullable
as List<String>,diagnosticosIds: null == diagnosticosIds ? _self.diagnosticosIds : diagnosticosIds // ignore: cast_nullable_to_non_nullable
as List<String>,consultasPreviasIds: null == consultasPreviasIds ? _self.consultasPreviasIds : consultasPreviasIds // ignore: cast_nullable_to_non_nullable
as List<String>,ultimoEditadoPor: freezed == ultimoEditadoPor ? _self.ultimoEditadoPor : ultimoEditadoPor // ignore: cast_nullable_to_non_nullable
as String?,ultimoEditadoDesde: freezed == ultimoEditadoDesde ? _self.ultimoEditadoDesde : ultimoEditadoDesde // ignore: cast_nullable_to_non_nullable
as String?,ultimaEdicionEn: freezed == ultimaEdicionEn ? _self.ultimaEdicionEn : ultimaEdicionEn // ignore: cast_nullable_to_non_nullable
as DateTime?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientModelCopyWith<$Res> get paciente {
  
  return $PatientModelCopyWith<$Res>(_self.paciente, (value) {
    return _then(_self.copyWith(paciente: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClinicalRecordModel].
extension ClinicalRecordModelPatterns on ClinicalRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClinicalRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClinicalRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClinicalRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _ClinicalRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClinicalRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClinicalRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pacienteId,  PatientModel paciente,  RecordStatus estado,  List<String> alergiasIds,  List<String> medicamentosActivosIds,  List<String> diagnosticosIds,  List<String> consultasPreviasIds,  String? ultimoEditadoPor,  String? ultimoEditadoDesde,  DateTime? ultimaEdicionEn,  DateTime? creadoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClinicalRecordModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.paciente,_that.estado,_that.alergiasIds,_that.medicamentosActivosIds,_that.diagnosticosIds,_that.consultasPreviasIds,_that.ultimoEditadoPor,_that.ultimoEditadoDesde,_that.ultimaEdicionEn,_that.creadoEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pacienteId,  PatientModel paciente,  RecordStatus estado,  List<String> alergiasIds,  List<String> medicamentosActivosIds,  List<String> diagnosticosIds,  List<String> consultasPreviasIds,  String? ultimoEditadoPor,  String? ultimoEditadoDesde,  DateTime? ultimaEdicionEn,  DateTime? creadoEn)  $default,) {final _that = this;
switch (_that) {
case _ClinicalRecordModel():
return $default(_that.id,_that.pacienteId,_that.paciente,_that.estado,_that.alergiasIds,_that.medicamentosActivosIds,_that.diagnosticosIds,_that.consultasPreviasIds,_that.ultimoEditadoPor,_that.ultimoEditadoDesde,_that.ultimaEdicionEn,_that.creadoEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pacienteId,  PatientModel paciente,  RecordStatus estado,  List<String> alergiasIds,  List<String> medicamentosActivosIds,  List<String> diagnosticosIds,  List<String> consultasPreviasIds,  String? ultimoEditadoPor,  String? ultimoEditadoDesde,  DateTime? ultimaEdicionEn,  DateTime? creadoEn)?  $default,) {final _that = this;
switch (_that) {
case _ClinicalRecordModel() when $default != null:
return $default(_that.id,_that.pacienteId,_that.paciente,_that.estado,_that.alergiasIds,_that.medicamentosActivosIds,_that.diagnosticosIds,_that.consultasPreviasIds,_that.ultimoEditadoPor,_that.ultimoEditadoDesde,_that.ultimaEdicionEn,_that.creadoEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClinicalRecordModel implements ClinicalRecordModel {
  const _ClinicalRecordModel({required this.id, required this.pacienteId, required this.paciente, this.estado = RecordStatus.activa, final  List<String> alergiasIds = const [], final  List<String> medicamentosActivosIds = const [], final  List<String> diagnosticosIds = const [], final  List<String> consultasPreviasIds = const [], this.ultimoEditadoPor, this.ultimoEditadoDesde, this.ultimaEdicionEn, this.creadoEn}): _alergiasIds = alergiasIds,_medicamentosActivosIds = medicamentosActivosIds,_diagnosticosIds = diagnosticosIds,_consultasPreviasIds = consultasPreviasIds;
  factory _ClinicalRecordModel.fromJson(Map<String, dynamic> json) => _$ClinicalRecordModelFromJson(json);

@override final  String id;
@override final  String pacienteId;
@override final  PatientModel paciente;
@override@JsonKey() final  RecordStatus estado;
// Listas de los otros módulos — llegan como referencias
 final  List<String> _alergiasIds;
// Listas de los otros módulos — llegan como referencias
@override@JsonKey() List<String> get alergiasIds {
  if (_alergiasIds is EqualUnmodifiableListView) return _alergiasIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alergiasIds);
}

 final  List<String> _medicamentosActivosIds;
@override@JsonKey() List<String> get medicamentosActivosIds {
  if (_medicamentosActivosIds is EqualUnmodifiableListView) return _medicamentosActivosIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medicamentosActivosIds);
}

 final  List<String> _diagnosticosIds;
@override@JsonKey() List<String> get diagnosticosIds {
  if (_diagnosticosIds is EqualUnmodifiableListView) return _diagnosticosIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diagnosticosIds);
}

 final  List<String> _consultasPreviasIds;
@override@JsonKey() List<String> get consultasPreviasIds {
  if (_consultasPreviasIds is EqualUnmodifiableListView) return _consultasPreviasIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_consultasPreviasIds);
}

// Log de auditoría — quién editó y cuándo (PB-09 criterio 2)
@override final  String? ultimoEditadoPor;
@override final  String? ultimoEditadoDesde;
@override final  DateTime? ultimaEdicionEn;
@override final  DateTime? creadoEn;

/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicalRecordModelCopyWith<_ClinicalRecordModel> get copyWith => __$ClinicalRecordModelCopyWithImpl<_ClinicalRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClinicalRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicalRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pacienteId, pacienteId) || other.pacienteId == pacienteId)&&(identical(other.paciente, paciente) || other.paciente == paciente)&&(identical(other.estado, estado) || other.estado == estado)&&const DeepCollectionEquality().equals(other._alergiasIds, _alergiasIds)&&const DeepCollectionEquality().equals(other._medicamentosActivosIds, _medicamentosActivosIds)&&const DeepCollectionEquality().equals(other._diagnosticosIds, _diagnosticosIds)&&const DeepCollectionEquality().equals(other._consultasPreviasIds, _consultasPreviasIds)&&(identical(other.ultimoEditadoPor, ultimoEditadoPor) || other.ultimoEditadoPor == ultimoEditadoPor)&&(identical(other.ultimoEditadoDesde, ultimoEditadoDesde) || other.ultimoEditadoDesde == ultimoEditadoDesde)&&(identical(other.ultimaEdicionEn, ultimaEdicionEn) || other.ultimaEdicionEn == ultimaEdicionEn)&&(identical(other.creadoEn, creadoEn) || other.creadoEn == creadoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pacienteId,paciente,estado,const DeepCollectionEquality().hash(_alergiasIds),const DeepCollectionEquality().hash(_medicamentosActivosIds),const DeepCollectionEquality().hash(_diagnosticosIds),const DeepCollectionEquality().hash(_consultasPreviasIds),ultimoEditadoPor,ultimoEditadoDesde,ultimaEdicionEn,creadoEn);

@override
String toString() {
  return 'ClinicalRecordModel(id: $id, pacienteId: $pacienteId, paciente: $paciente, estado: $estado, alergiasIds: $alergiasIds, medicamentosActivosIds: $medicamentosActivosIds, diagnosticosIds: $diagnosticosIds, consultasPreviasIds: $consultasPreviasIds, ultimoEditadoPor: $ultimoEditadoPor, ultimoEditadoDesde: $ultimoEditadoDesde, ultimaEdicionEn: $ultimaEdicionEn, creadoEn: $creadoEn)';
}


}

/// @nodoc
abstract mixin class _$ClinicalRecordModelCopyWith<$Res> implements $ClinicalRecordModelCopyWith<$Res> {
  factory _$ClinicalRecordModelCopyWith(_ClinicalRecordModel value, $Res Function(_ClinicalRecordModel) _then) = __$ClinicalRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String pacienteId, PatientModel paciente, RecordStatus estado, List<String> alergiasIds, List<String> medicamentosActivosIds, List<String> diagnosticosIds, List<String> consultasPreviasIds, String? ultimoEditadoPor, String? ultimoEditadoDesde, DateTime? ultimaEdicionEn, DateTime? creadoEn
});


@override $PatientModelCopyWith<$Res> get paciente;

}
/// @nodoc
class __$ClinicalRecordModelCopyWithImpl<$Res>
    implements _$ClinicalRecordModelCopyWith<$Res> {
  __$ClinicalRecordModelCopyWithImpl(this._self, this._then);

  final _ClinicalRecordModel _self;
  final $Res Function(_ClinicalRecordModel) _then;

/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pacienteId = null,Object? paciente = null,Object? estado = null,Object? alergiasIds = null,Object? medicamentosActivosIds = null,Object? diagnosticosIds = null,Object? consultasPreviasIds = null,Object? ultimoEditadoPor = freezed,Object? ultimoEditadoDesde = freezed,Object? ultimaEdicionEn = freezed,Object? creadoEn = freezed,}) {
  return _then(_ClinicalRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pacienteId: null == pacienteId ? _self.pacienteId : pacienteId // ignore: cast_nullable_to_non_nullable
as String,paciente: null == paciente ? _self.paciente : paciente // ignore: cast_nullable_to_non_nullable
as PatientModel,estado: null == estado ? _self.estado : estado // ignore: cast_nullable_to_non_nullable
as RecordStatus,alergiasIds: null == alergiasIds ? _self._alergiasIds : alergiasIds // ignore: cast_nullable_to_non_nullable
as List<String>,medicamentosActivosIds: null == medicamentosActivosIds ? _self._medicamentosActivosIds : medicamentosActivosIds // ignore: cast_nullable_to_non_nullable
as List<String>,diagnosticosIds: null == diagnosticosIds ? _self._diagnosticosIds : diagnosticosIds // ignore: cast_nullable_to_non_nullable
as List<String>,consultasPreviasIds: null == consultasPreviasIds ? _self._consultasPreviasIds : consultasPreviasIds // ignore: cast_nullable_to_non_nullable
as List<String>,ultimoEditadoPor: freezed == ultimoEditadoPor ? _self.ultimoEditadoPor : ultimoEditadoPor // ignore: cast_nullable_to_non_nullable
as String?,ultimoEditadoDesde: freezed == ultimoEditadoDesde ? _self.ultimoEditadoDesde : ultimoEditadoDesde // ignore: cast_nullable_to_non_nullable
as String?,ultimaEdicionEn: freezed == ultimaEdicionEn ? _self.ultimaEdicionEn : ultimaEdicionEn // ignore: cast_nullable_to_non_nullable
as DateTime?,creadoEn: freezed == creadoEn ? _self.creadoEn : creadoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ClinicalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientModelCopyWith<$Res> get paciente {
  
  return $PatientModelCopyWith<$Res>(_self.paciente, (value) {
    return _then(_self.copyWith(paciente: value));
  });
}
}


/// @nodoc
mixin _$CreateClinicalRecordRequest {

 String get nombreCompleto; DocumentType get tipoDocumento; String get numeroDocumento; DateTime get fechaNacimiento; Sex get sexo; String? get direccion; String? get telefono; String? get correo; EmergencyContact? get contactoEmergencia;
/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateClinicalRecordRequestCopyWith<CreateClinicalRecordRequest> get copyWith => _$CreateClinicalRecordRequestCopyWithImpl<CreateClinicalRecordRequest>(this as CreateClinicalRecordRequest, _$identity);

  /// Serializes this CreateClinicalRecordRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateClinicalRecordRequest&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento)&&(identical(other.sexo, sexo) || other.sexo == sexo)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.correo, correo) || other.correo == correo)&&(identical(other.contactoEmergencia, contactoEmergencia) || other.contactoEmergencia == contactoEmergencia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreCompleto,tipoDocumento,numeroDocumento,fechaNacimiento,sexo,direccion,telefono,correo,contactoEmergencia);

@override
String toString() {
  return 'CreateClinicalRecordRequest(nombreCompleto: $nombreCompleto, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento, sexo: $sexo, direccion: $direccion, telefono: $telefono, correo: $correo, contactoEmergencia: $contactoEmergencia)';
}


}

/// @nodoc
abstract mixin class $CreateClinicalRecordRequestCopyWith<$Res>  {
  factory $CreateClinicalRecordRequestCopyWith(CreateClinicalRecordRequest value, $Res Function(CreateClinicalRecordRequest) _then) = _$CreateClinicalRecordRequestCopyWithImpl;
@useResult
$Res call({
 String nombreCompleto, DocumentType tipoDocumento, String numeroDocumento, DateTime fechaNacimiento, Sex sexo, String? direccion, String? telefono, String? correo, EmergencyContact? contactoEmergencia
});


$EmergencyContactCopyWith<$Res>? get contactoEmergencia;

}
/// @nodoc
class _$CreateClinicalRecordRequestCopyWithImpl<$Res>
    implements $CreateClinicalRecordRequestCopyWith<$Res> {
  _$CreateClinicalRecordRequestCopyWithImpl(this._self, this._then);

  final CreateClinicalRecordRequest _self;
  final $Res Function(CreateClinicalRecordRequest) _then;

/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombreCompleto = null,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? fechaNacimiento = null,Object? sexo = null,Object? direccion = freezed,Object? telefono = freezed,Object? correo = freezed,Object? contactoEmergencia = freezed,}) {
  return _then(_self.copyWith(
nombreCompleto: null == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as DocumentType,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: null == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime,sexo: null == sexo ? _self.sexo : sexo // ignore: cast_nullable_to_non_nullable
as Sex,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,correo: freezed == correo ? _self.correo : correo // ignore: cast_nullable_to_non_nullable
as String?,contactoEmergencia: freezed == contactoEmergencia ? _self.contactoEmergencia : contactoEmergencia // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,
  ));
}
/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get contactoEmergencia {
    if (_self.contactoEmergencia == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.contactoEmergencia!, (value) {
    return _then(_self.copyWith(contactoEmergencia: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateClinicalRecordRequest].
extension CreateClinicalRecordRequestPatterns on CreateClinicalRecordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateClinicalRecordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateClinicalRecordRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateClinicalRecordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest() when $default != null:
return $default(_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia)  $default,) {final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest():
return $default(_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nombreCompleto,  DocumentType tipoDocumento,  String numeroDocumento,  DateTime fechaNacimiento,  Sex sexo,  String? direccion,  String? telefono,  String? correo,  EmergencyContact? contactoEmergencia)?  $default,) {final _that = this;
switch (_that) {
case _CreateClinicalRecordRequest() when $default != null:
return $default(_that.nombreCompleto,_that.tipoDocumento,_that.numeroDocumento,_that.fechaNacimiento,_that.sexo,_that.direccion,_that.telefono,_that.correo,_that.contactoEmergencia);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateClinicalRecordRequest implements CreateClinicalRecordRequest {
  const _CreateClinicalRecordRequest({required this.nombreCompleto, required this.tipoDocumento, required this.numeroDocumento, required this.fechaNacimiento, required this.sexo, this.direccion, this.telefono, this.correo, this.contactoEmergencia});
  factory _CreateClinicalRecordRequest.fromJson(Map<String, dynamic> json) => _$CreateClinicalRecordRequestFromJson(json);

@override final  String nombreCompleto;
@override final  DocumentType tipoDocumento;
@override final  String numeroDocumento;
@override final  DateTime fechaNacimiento;
@override final  Sex sexo;
@override final  String? direccion;
@override final  String? telefono;
@override final  String? correo;
@override final  EmergencyContact? contactoEmergencia;

/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateClinicalRecordRequestCopyWith<_CreateClinicalRecordRequest> get copyWith => __$CreateClinicalRecordRequestCopyWithImpl<_CreateClinicalRecordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateClinicalRecordRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateClinicalRecordRequest&&(identical(other.nombreCompleto, nombreCompleto) || other.nombreCompleto == nombreCompleto)&&(identical(other.tipoDocumento, tipoDocumento) || other.tipoDocumento == tipoDocumento)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento)&&(identical(other.sexo, sexo) || other.sexo == sexo)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.telefono, telefono) || other.telefono == telefono)&&(identical(other.correo, correo) || other.correo == correo)&&(identical(other.contactoEmergencia, contactoEmergencia) || other.contactoEmergencia == contactoEmergencia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreCompleto,tipoDocumento,numeroDocumento,fechaNacimiento,sexo,direccion,telefono,correo,contactoEmergencia);

@override
String toString() {
  return 'CreateClinicalRecordRequest(nombreCompleto: $nombreCompleto, tipoDocumento: $tipoDocumento, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento, sexo: $sexo, direccion: $direccion, telefono: $telefono, correo: $correo, contactoEmergencia: $contactoEmergencia)';
}


}

/// @nodoc
abstract mixin class _$CreateClinicalRecordRequestCopyWith<$Res> implements $CreateClinicalRecordRequestCopyWith<$Res> {
  factory _$CreateClinicalRecordRequestCopyWith(_CreateClinicalRecordRequest value, $Res Function(_CreateClinicalRecordRequest) _then) = __$CreateClinicalRecordRequestCopyWithImpl;
@override @useResult
$Res call({
 String nombreCompleto, DocumentType tipoDocumento, String numeroDocumento, DateTime fechaNacimiento, Sex sexo, String? direccion, String? telefono, String? correo, EmergencyContact? contactoEmergencia
});


@override $EmergencyContactCopyWith<$Res>? get contactoEmergencia;

}
/// @nodoc
class __$CreateClinicalRecordRequestCopyWithImpl<$Res>
    implements _$CreateClinicalRecordRequestCopyWith<$Res> {
  __$CreateClinicalRecordRequestCopyWithImpl(this._self, this._then);

  final _CreateClinicalRecordRequest _self;
  final $Res Function(_CreateClinicalRecordRequest) _then;

/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombreCompleto = null,Object? tipoDocumento = null,Object? numeroDocumento = null,Object? fechaNacimiento = null,Object? sexo = null,Object? direccion = freezed,Object? telefono = freezed,Object? correo = freezed,Object? contactoEmergencia = freezed,}) {
  return _then(_CreateClinicalRecordRequest(
nombreCompleto: null == nombreCompleto ? _self.nombreCompleto : nombreCompleto // ignore: cast_nullable_to_non_nullable
as String,tipoDocumento: null == tipoDocumento ? _self.tipoDocumento : tipoDocumento // ignore: cast_nullable_to_non_nullable
as DocumentType,numeroDocumento: null == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String,fechaNacimiento: null == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime,sexo: null == sexo ? _self.sexo : sexo // ignore: cast_nullable_to_non_nullable
as Sex,direccion: freezed == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String?,telefono: freezed == telefono ? _self.telefono : telefono // ignore: cast_nullable_to_non_nullable
as String?,correo: freezed == correo ? _self.correo : correo // ignore: cast_nullable_to_non_nullable
as String?,contactoEmergencia: freezed == contactoEmergencia ? _self.contactoEmergencia : contactoEmergencia // ignore: cast_nullable_to_non_nullable
as EmergencyContact?,
  ));
}

/// Create a copy of CreateClinicalRecordRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmergencyContactCopyWith<$Res>? get contactoEmergencia {
    if (_self.contactoEmergencia == null) {
    return null;
  }

  return $EmergencyContactCopyWith<$Res>(_self.contactoEmergencia!, (value) {
    return _then(_self.copyWith(contactoEmergencia: value));
  });
}
}


/// @nodoc
mixin _$PatientSearchParams {

 String? get nombre; String? get numeroDocumento; DateTime? get fechaNacimiento;
/// Create a copy of PatientSearchParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientSearchParamsCopyWith<PatientSearchParams> get copyWith => _$PatientSearchParamsCopyWithImpl<PatientSearchParams>(this as PatientSearchParams, _$identity);

  /// Serializes this PatientSearchParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSearchParams&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombre,numeroDocumento,fechaNacimiento);

@override
String toString() {
  return 'PatientSearchParams(nombre: $nombre, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento)';
}


}

/// @nodoc
abstract mixin class $PatientSearchParamsCopyWith<$Res>  {
  factory $PatientSearchParamsCopyWith(PatientSearchParams value, $Res Function(PatientSearchParams) _then) = _$PatientSearchParamsCopyWithImpl;
@useResult
$Res call({
 String? nombre, String? numeroDocumento, DateTime? fechaNacimiento
});




}
/// @nodoc
class _$PatientSearchParamsCopyWithImpl<$Res>
    implements $PatientSearchParamsCopyWith<$Res> {
  _$PatientSearchParamsCopyWithImpl(this._self, this._then);

  final PatientSearchParams _self;
  final $Res Function(PatientSearchParams) _then;

/// Create a copy of PatientSearchParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombre = freezed,Object? numeroDocumento = freezed,Object? fechaNacimiento = freezed,}) {
  return _then(_self.copyWith(
nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,numeroDocumento: freezed == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String?,fechaNacimiento: freezed == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientSearchParams].
extension PatientSearchParamsPatterns on PatientSearchParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientSearchParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientSearchParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientSearchParams value)  $default,){
final _that = this;
switch (_that) {
case _PatientSearchParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientSearchParams value)?  $default,){
final _that = this;
switch (_that) {
case _PatientSearchParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nombre,  String? numeroDocumento,  DateTime? fechaNacimiento)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientSearchParams() when $default != null:
return $default(_that.nombre,_that.numeroDocumento,_that.fechaNacimiento);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nombre,  String? numeroDocumento,  DateTime? fechaNacimiento)  $default,) {final _that = this;
switch (_that) {
case _PatientSearchParams():
return $default(_that.nombre,_that.numeroDocumento,_that.fechaNacimiento);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nombre,  String? numeroDocumento,  DateTime? fechaNacimiento)?  $default,) {final _that = this;
switch (_that) {
case _PatientSearchParams() when $default != null:
return $default(_that.nombre,_that.numeroDocumento,_that.fechaNacimiento);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientSearchParams implements PatientSearchParams {
  const _PatientSearchParams({this.nombre, this.numeroDocumento, this.fechaNacimiento});
  factory _PatientSearchParams.fromJson(Map<String, dynamic> json) => _$PatientSearchParamsFromJson(json);

@override final  String? nombre;
@override final  String? numeroDocumento;
@override final  DateTime? fechaNacimiento;

/// Create a copy of PatientSearchParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientSearchParamsCopyWith<_PatientSearchParams> get copyWith => __$PatientSearchParamsCopyWithImpl<_PatientSearchParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientSearchParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientSearchParams&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.numeroDocumento, numeroDocumento) || other.numeroDocumento == numeroDocumento)&&(identical(other.fechaNacimiento, fechaNacimiento) || other.fechaNacimiento == fechaNacimiento));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombre,numeroDocumento,fechaNacimiento);

@override
String toString() {
  return 'PatientSearchParams(nombre: $nombre, numeroDocumento: $numeroDocumento, fechaNacimiento: $fechaNacimiento)';
}


}

/// @nodoc
abstract mixin class _$PatientSearchParamsCopyWith<$Res> implements $PatientSearchParamsCopyWith<$Res> {
  factory _$PatientSearchParamsCopyWith(_PatientSearchParams value, $Res Function(_PatientSearchParams) _then) = __$PatientSearchParamsCopyWithImpl;
@override @useResult
$Res call({
 String? nombre, String? numeroDocumento, DateTime? fechaNacimiento
});




}
/// @nodoc
class __$PatientSearchParamsCopyWithImpl<$Res>
    implements _$PatientSearchParamsCopyWith<$Res> {
  __$PatientSearchParamsCopyWithImpl(this._self, this._then);

  final _PatientSearchParams _self;
  final $Res Function(_PatientSearchParams) _then;

/// Create a copy of PatientSearchParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombre = freezed,Object? numeroDocumento = freezed,Object? fechaNacimiento = freezed,}) {
  return _then(_PatientSearchParams(
nombre: freezed == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String?,numeroDocumento: freezed == numeroDocumento ? _self.numeroDocumento : numeroDocumento // ignore: cast_nullable_to_non_nullable
as String?,fechaNacimiento: freezed == fechaNacimiento ? _self.fechaNacimiento : fechaNacimiento // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
