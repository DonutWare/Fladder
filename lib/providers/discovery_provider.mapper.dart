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
}
