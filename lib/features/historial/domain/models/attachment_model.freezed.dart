// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttachmentModel {

 String get id; String get historiaClinicaId; String get nombreArchivo; AttachmentType get tipo;/// URL del archivo en el servidor de almacenamiento
 String get url; int? get tamanoBytes; String? get subidoPor; DateTime? get subidoEn;
/// Create a copy of AttachmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentModelCopyWith<AttachmentModel> get copyWith => _$AttachmentModelCopyWithImpl<AttachmentModel>(this as AttachmentModel, _$identity);

  /// Serializes this AttachmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.nombreArchivo, nombreArchivo) || other.nombreArchivo == nombreArchivo)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.url, url) || other.url == url)&&(identical(other.tamanoBytes, tamanoBytes) || other.tamanoBytes == tamanoBytes)&&(identical(other.subidoPor, subidoPor) || other.subidoPor == subidoPor)&&(identical(other.subidoEn, subidoEn) || other.subidoEn == subidoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,nombreArchivo,tipo,url,tamanoBytes,subidoPor,subidoEn);

@override
String toString() {
  return 'AttachmentModel(id: $id, historiaClinicaId: $historiaClinicaId, nombreArchivo: $nombreArchivo, tipo: $tipo, url: $url, tamanoBytes: $tamanoBytes, subidoPor: $subidoPor, subidoEn: $subidoEn)';
}


}

/// @nodoc
abstract mixin class $AttachmentModelCopyWith<$Res>  {
  factory $AttachmentModelCopyWith(AttachmentModel value, $Res Function(AttachmentModel) _then) = _$AttachmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String historiaClinicaId, String nombreArchivo, AttachmentType tipo, String url, int? tamanoBytes, String? subidoPor, DateTime? subidoEn
});




}
/// @nodoc
class _$AttachmentModelCopyWithImpl<$Res>
    implements $AttachmentModelCopyWith<$Res> {
  _$AttachmentModelCopyWithImpl(this._self, this._then);

  final AttachmentModel _self;
  final $Res Function(AttachmentModel) _then;

/// Create a copy of AttachmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? historiaClinicaId = null,Object? nombreArchivo = null,Object? tipo = null,Object? url = null,Object? tamanoBytes = freezed,Object? subidoPor = freezed,Object? subidoEn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,nombreArchivo: null == nombreArchivo ? _self.nombreArchivo : nombreArchivo // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as AttachmentType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tamanoBytes: freezed == tamanoBytes ? _self.tamanoBytes : tamanoBytes // ignore: cast_nullable_to_non_nullable
as int?,subidoPor: freezed == subidoPor ? _self.subidoPor : subidoPor // ignore: cast_nullable_to_non_nullable
as String?,subidoEn: freezed == subidoEn ? _self.subidoEn : subidoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachmentModel].
extension AttachmentModelPatterns on AttachmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachmentModel value)  $default,){
final _that = this;
switch (_that) {
case _AttachmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttachmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String nombreArchivo,  AttachmentType tipo,  String url,  int? tamanoBytes,  String? subidoPor,  DateTime? subidoEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachmentModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.nombreArchivo,_that.tipo,_that.url,_that.tamanoBytes,_that.subidoPor,_that.subidoEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String historiaClinicaId,  String nombreArchivo,  AttachmentType tipo,  String url,  int? tamanoBytes,  String? subidoPor,  DateTime? subidoEn)  $default,) {final _that = this;
switch (_that) {
case _AttachmentModel():
return $default(_that.id,_that.historiaClinicaId,_that.nombreArchivo,_that.tipo,_that.url,_that.tamanoBytes,_that.subidoPor,_that.subidoEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String historiaClinicaId,  String nombreArchivo,  AttachmentType tipo,  String url,  int? tamanoBytes,  String? subidoPor,  DateTime? subidoEn)?  $default,) {final _that = this;
switch (_that) {
case _AttachmentModel() when $default != null:
return $default(_that.id,_that.historiaClinicaId,_that.nombreArchivo,_that.tipo,_that.url,_that.tamanoBytes,_that.subidoPor,_that.subidoEn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttachmentModel implements AttachmentModel {
  const _AttachmentModel({required this.id, required this.historiaClinicaId, required this.nombreArchivo, required this.tipo, required this.url, this.tamanoBytes, this.subidoPor, this.subidoEn});
  factory _AttachmentModel.fromJson(Map<String, dynamic> json) => _$AttachmentModelFromJson(json);

@override final  String id;
@override final  String historiaClinicaId;
@override final  String nombreArchivo;
@override final  AttachmentType tipo;
/// URL del archivo en el servidor de almacenamiento
@override final  String url;
@override final  int? tamanoBytes;
@override final  String? subidoPor;
@override final  DateTime? subidoEn;

/// Create a copy of AttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentModelCopyWith<_AttachmentModel> get copyWith => __$AttachmentModelCopyWithImpl<_AttachmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.historiaClinicaId, historiaClinicaId) || other.historiaClinicaId == historiaClinicaId)&&(identical(other.nombreArchivo, nombreArchivo) || other.nombreArchivo == nombreArchivo)&&(identical(other.tipo, tipo) || other.tipo == tipo)&&(identical(other.url, url) || other.url == url)&&(identical(other.tamanoBytes, tamanoBytes) || other.tamanoBytes == tamanoBytes)&&(identical(other.subidoPor, subidoPor) || other.subidoPor == subidoPor)&&(identical(other.subidoEn, subidoEn) || other.subidoEn == subidoEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,historiaClinicaId,nombreArchivo,tipo,url,tamanoBytes,subidoPor,subidoEn);

@override
String toString() {
  return 'AttachmentModel(id: $id, historiaClinicaId: $historiaClinicaId, nombreArchivo: $nombreArchivo, tipo: $tipo, url: $url, tamanoBytes: $tamanoBytes, subidoPor: $subidoPor, subidoEn: $subidoEn)';
}


}

/// @nodoc
abstract mixin class _$AttachmentModelCopyWith<$Res> implements $AttachmentModelCopyWith<$Res> {
  factory _$AttachmentModelCopyWith(_AttachmentModel value, $Res Function(_AttachmentModel) _then) = __$AttachmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String historiaClinicaId, String nombreArchivo, AttachmentType tipo, String url, int? tamanoBytes, String? subidoPor, DateTime? subidoEn
});




}
/// @nodoc
class __$AttachmentModelCopyWithImpl<$Res>
    implements _$AttachmentModelCopyWith<$Res> {
  __$AttachmentModelCopyWithImpl(this._self, this._then);

  final _AttachmentModel _self;
  final $Res Function(_AttachmentModel) _then;

/// Create a copy of AttachmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? historiaClinicaId = null,Object? nombreArchivo = null,Object? tipo = null,Object? url = null,Object? tamanoBytes = freezed,Object? subidoPor = freezed,Object? subidoEn = freezed,}) {
  return _then(_AttachmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,historiaClinicaId: null == historiaClinicaId ? _self.historiaClinicaId : historiaClinicaId // ignore: cast_nullable_to_non_nullable
as String,nombreArchivo: null == nombreArchivo ? _self.nombreArchivo : nombreArchivo // ignore: cast_nullable_to_non_nullable
as String,tipo: null == tipo ? _self.tipo : tipo // ignore: cast_nullable_to_non_nullable
as AttachmentType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tamanoBytes: freezed == tamanoBytes ? _self.tamanoBytes : tamanoBytes // ignore: cast_nullable_to_non_nullable
as int?,subidoPor: freezed == subidoPor ? _self.subidoPor : subidoPor // ignore: cast_nullable_to_non_nullable
as String?,subidoEn: freezed == subidoEn ? _self.subidoEn : subidoEn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
