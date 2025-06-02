// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'discovery_provider.dart';

class DiscoveryInfoMapper extends ClassMapperBase<DiscoveryInfo> {
  DiscoveryInfoMapper._();

  static DiscoveryInfoMapper? _instance;
  static DiscoveryInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DiscoveryInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DiscoveryInfo';

  static String _$id(DiscoveryInfo v) => v.id;
  static const Field<DiscoveryInfo, String> _f$id =
      Field('id', _$id, key: r'Id');
  static String _$name(DiscoveryInfo v) => v.name;
  static const Field<DiscoveryInfo, String> _f$name =
      Field('name', _$name, key: r'Name');
  static String _$address(DiscoveryInfo v) => v.address;
  static const Field<DiscoveryInfo, String> _f$address =
      Field('address', _$address, key: r'Address');
  static String? _$endPointAddress(DiscoveryInfo v) => v.endPointAddress;
  static const Field<DiscoveryInfo, String> _f$endPointAddress =
      Field('endPointAddress', _$endPointAddress, key: r'EndpointAddress');

  @override
  final MappableFields<DiscoveryInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #address: _f$address,
    #endPointAddress: _f$endPointAddress,
  };
  @override
  final bool ignoreNull = true;

  static DiscoveryInfo _instantiate(DecodingData data) {
    return DiscoveryInfo(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        address: data.dec(_f$address),
        endPointAddress: data.dec(_f$endPointAddress));
  }

  @override
  final Function instantiate = _instantiate;

  static DiscoveryInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DiscoveryInfo>(map);
  }

  static DiscoveryInfo fromJson(String json) {
    return ensureInitialized().decodeJson<DiscoveryInfo>(json);
  }
}

mixin DiscoveryInfoMappable {
  String toJson() {
    return DiscoveryInfoMapper.ensureInitialized()
        .encodeJson<DiscoveryInfo>(this as DiscoveryInfo);
  }

  Map<String, dynamic> toMap() {
    return DiscoveryInfoMapper.ensureInitialized()
        .encodeMap<DiscoveryInfo>(this as DiscoveryInfo);
  }

  DiscoveryInfoCopyWith<DiscoveryInfo, DiscoveryInfo, DiscoveryInfo>
      get copyWith => _DiscoveryInfoCopyWithImpl(
          this as DiscoveryInfo, $identity, $identity);
  @override
  String toString() {
    return DiscoveryInfoMapper.ensureInitialized()
        .stringifyValue(this as DiscoveryInfo);
  }
}

extension DiscoveryInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DiscoveryInfo, $Out> {
  DiscoveryInfoCopyWith<$R, DiscoveryInfo, $Out> get $asDiscoveryInfo =>
      $base.as((v, t, t2) => _DiscoveryInfoCopyWithImpl(v, t, t2));
}

abstract class DiscoveryInfoCopyWith<$R, $In extends DiscoveryInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? address, String? endPointAddress});
  DiscoveryInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DiscoveryInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DiscoveryInfo, $Out>
    implements DiscoveryInfoCopyWith<$R, DiscoveryInfo, $Out> {
  _DiscoveryInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DiscoveryInfo> $mapper =
      DiscoveryInfoMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? address,
          Object? endPointAddress = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (address != null) #address: address,
        if (endPointAddress != $none) #endPointAddress: endPointAddress
      }));
  @override
  DiscoveryInfo $make(CopyWithData data) => DiscoveryInfo(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      address: data.get(#address, or: $value.address),
      endPointAddress: data.get(#endPointAddress, or: $value.endPointAddress));

  @override
  DiscoveryInfoCopyWith<$R2, DiscoveryInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DiscoveryInfoCopyWithImpl($value, $cast, t);
}
