// ignore_for_file: type=lint

/// Metadata class containing information from SwaggerRequest
class SwaggerMetaData {
  const SwaggerMetaData({
    required this.summary,
    required this.description,
    required this.operationId,
    required this.consumes,
    required this.produces,
    required this.security,
    required this.tags,
    required this.deprecated,
  });

  final String summary;

  final String description;

  final String operationId;

  final List<String> consumes;

  final List<String> produces;

  final List<String> security;

  final List<String> tags;

  final bool deprecated;
}
