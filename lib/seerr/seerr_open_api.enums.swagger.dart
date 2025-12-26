import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum MetadataSettings$SettingsTv {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('tvdb')
  tvdb('tvdb'),
  @JsonValue('tmdb')
  tmdb('tmdb');

  final String? value;

  const MetadataSettings$SettingsTv(this.value);
}

enum MetadataSettings$SettingsAnime {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('tvdb')
  tvdb('tvdb'),
  @JsonValue('tmdb')
  tmdb('tmdb');

  final String? value;

  const MetadataSettings$SettingsAnime(this.value);
}

enum RelatedVideoType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Clip')
  clip('Clip'),
  @JsonValue('Teaser')
  teaser('Teaser'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('Featurette')
  featurette('Featurette'),
  @JsonValue('Opening Credits')
  openingCredits('Opening Credits'),
  @JsonValue('Behind the Scenes')
  behindTheScenes('Behind the Scenes'),
  @JsonValue('Bloopers')
  bloopers('Bloopers');

  final String? value;

  const RelatedVideoType(this.value);
}

enum RelatedVideoSite {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('YouTube')
  youtube('YouTube');

  final String? value;

  const RelatedVideoSite(this.value);
}

enum JobType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('process')
  process('process'),
  @JsonValue('command')
  command('command');

  final String? value;

  const JobType(this.value);
}

enum JobInterval {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('short')
  short('short'),
  @JsonValue('long')
  long('long'),
  @JsonValue('fixed')
  fixed('fixed');

  final String? value;

  const JobInterval(this.value);
}

enum SettingsLogsGetFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('debug')
  debug('debug'),
  @JsonValue('info')
  info('info'),
  @JsonValue('warn')
  warn('warn'),
  @JsonValue('error')
  error('error');

  final String? value;

  const SettingsLogsGetFilter(this.value);
}

enum UserGetSort {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('created')
  created('created'),
  @JsonValue('updated')
  updated('updated'),
  @JsonValue('requests')
  requests('requests'),
  @JsonValue('displayname')
  displayname('displayname');

  final String? value;

  const UserGetSort(this.value);
}

enum BlacklistGetFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('manual')
  manual('manual'),
  @JsonValue('blacklistedTags')
  blacklistedtags('blacklistedTags');

  final String? value;

  const BlacklistGetFilter(this.value);
}

enum DiscoverMoviesGetCertificationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('exact')
  exact('exact'),
  @JsonValue('range')
  range('range');

  final String? value;

  const DiscoverMoviesGetCertificationMode(this.value);
}

enum DiscoverTvGetCertificationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('exact')
  exact('exact'),
  @JsonValue('range')
  range('range');

  final String? value;

  const DiscoverTvGetCertificationMode(this.value);
}

enum RequestGetFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('approved')
  approved('approved'),
  @JsonValue('available')
  available('available'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('processing')
  processing('processing'),
  @JsonValue('unavailable')
  unavailable('unavailable'),
  @JsonValue('failed')
  failed('failed'),
  @JsonValue('deleted')
  deleted('deleted'),
  @JsonValue('completed')
  completed('completed');

  final String? value;

  const RequestGetFilter(this.value);
}

enum RequestGetSort {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('added')
  added('added'),
  @JsonValue('modified')
  modified('modified');

  final String? value;

  const RequestGetSort(this.value);
}

enum RequestGetSortDirection {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asc')
  asc('asc'),
  @JsonValue('desc')
  desc('desc');

  final String? value;

  const RequestGetSortDirection(this.value);
}

enum RequestGetMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movie')
  movie('movie'),
  @JsonValue('tv')
  tv('tv'),
  @JsonValue('all')
  all('all');

  final String? value;

  const RequestGetMediaType(this.value);
}

enum RequestRequestIdStatusPostStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('approve')
  approve('approve'),
  @JsonValue('decline')
  decline('decline');

  final String? value;

  const RequestRequestIdStatusPostStatus(this.value);
}

enum MovieMovieIdRatingsGet$ResponseCriticsRating {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Rotten')
  rotten('Rotten'),
  @JsonValue('Fresh')
  fresh('Fresh'),
  @JsonValue('Certified Fresh')
  certifiedFresh('Certified Fresh');

  final String? value;

  const MovieMovieIdRatingsGet$ResponseCriticsRating(this.value);
}

enum MovieMovieIdRatingsGet$ResponseAudienceRating {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Spilled')
  spilled('Spilled'),
  @JsonValue('Upright')
  upright('Upright');

  final String? value;

  const MovieMovieIdRatingsGet$ResponseAudienceRating(this.value);
}

enum MovieMovieIdRatingscombinedGet$Response$RtCriticsRating {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Rotten')
  rotten('Rotten'),
  @JsonValue('Fresh')
  fresh('Fresh'),
  @JsonValue('Certified Fresh')
  certifiedFresh('Certified Fresh');

  final String? value;

  const MovieMovieIdRatingscombinedGet$Response$RtCriticsRating(this.value);
}

enum MovieMovieIdRatingscombinedGet$Response$RtAudienceRating {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Spilled')
  spilled('Spilled'),
  @JsonValue('Upright')
  upright('Upright');

  final String? value;

  const MovieMovieIdRatingscombinedGet$Response$RtAudienceRating(this.value);
}

enum TvTvIdRatingsGet$ResponseCriticsRating {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Rotten')
  rotten('Rotten'),
  @JsonValue('Fresh')
  fresh('Fresh');

  final String? value;

  const TvTvIdRatingsGet$ResponseCriticsRating(this.value);
}

enum MediaGetFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('available')
  available('available'),
  @JsonValue('partial')
  partial('partial'),
  @JsonValue('allavailable')
  allavailable('allavailable'),
  @JsonValue('processing')
  processing('processing'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('deleted')
  deleted('deleted');

  final String? value;

  const MediaGetFilter(this.value);
}

enum MediaGetSort {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('added')
  added('added'),
  @JsonValue('modified')
  modified('modified'),
  @JsonValue('mediaAdded')
  mediaadded('mediaAdded');

  final String? value;

  const MediaGetSort(this.value);
}

enum MediaMediaIdStatusPostStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('available')
  available('available'),
  @JsonValue('partial')
  partial('partial'),
  @JsonValue('processing')
  processing('processing'),
  @JsonValue('pending')
  pending('pending'),
  @JsonValue('unknown')
  unknown('unknown'),
  @JsonValue('deleted')
  deleted('deleted');

  final String? value;

  const MediaMediaIdStatusPostStatus(this.value);
}

enum IssueGetSort {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('added')
  added('added'),
  @JsonValue('modified')
  modified('modified');

  final String? value;

  const IssueGetSort(this.value);
}

enum IssueGetFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all')
  all('all'),
  @JsonValue('open')
  open('open'),
  @JsonValue('resolved')
  resolved('resolved');

  final String? value;

  const IssueGetFilter(this.value);
}

enum IssueIssueIdStatusPostStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('open')
  open('open'),
  @JsonValue('resolved')
  resolved('resolved');

  final String? value;

  const IssueIssueIdStatusPostStatus(this.value);
}

enum RequestPost$RequestBodyMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movie')
  movie('movie'),
  @JsonValue('tv')
  tv('tv');

  final String? value;

  const RequestPost$RequestBodyMediaType(this.value);
}

enum RequestRequestIdPut$RequestBodyMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movie')
  movie('movie'),
  @JsonValue('tv')
  tv('tv');

  final String? value;

  const RequestRequestIdPut$RequestBodyMediaType(this.value);
}
