import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum AudioSpatialFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('DolbyAtmos')
  dolbyatmos('DolbyAtmos'),
  @JsonValue('DTSX')
  dtsx('DTSX');

  final String? value;

  const AudioSpatialFormat(this.value);
}

enum BaseItemKind {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('AggregateFolder')
  aggregatefolder('AggregateFolder'),
  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('AudioBook')
  audiobook('AudioBook'),
  @JsonValue('BasePluginFolder')
  basepluginfolder('BasePluginFolder'),
  @JsonValue('Book')
  book('Book'),
  @JsonValue('BoxSet')
  boxset('BoxSet'),
  @JsonValue('Channel')
  channel('Channel'),
  @JsonValue('ChannelFolderItem')
  channelfolderitem('ChannelFolderItem'),
  @JsonValue('CollectionFolder')
  collectionfolder('CollectionFolder'),
  @JsonValue('Episode')
  episode('Episode'),
  @JsonValue('Folder')
  folder('Folder'),
  @JsonValue('Genre')
  genre('Genre'),
  @JsonValue('ManualPlaylistsFolder')
  manualplaylistsfolder('ManualPlaylistsFolder'),
  @JsonValue('Movie')
  movie('Movie'),
  @JsonValue('LiveTvChannel')
  livetvchannel('LiveTvChannel'),
  @JsonValue('LiveTvProgram')
  livetvprogram('LiveTvProgram'),
  @JsonValue('MusicAlbum')
  musicalbum('MusicAlbum'),
  @JsonValue('MusicArtist')
  musicartist('MusicArtist'),
  @JsonValue('MusicGenre')
  musicgenre('MusicGenre'),
  @JsonValue('MusicVideo')
  musicvideo('MusicVideo'),
  @JsonValue('Person')
  person('Person'),
  @JsonValue('Photo')
  photo('Photo'),
  @JsonValue('PhotoAlbum')
  photoalbum('PhotoAlbum'),
  @JsonValue('Playlist')
  playlist('Playlist'),
  @JsonValue('PlaylistsFolder')
  playlistsfolder('PlaylistsFolder'),
  @JsonValue('Program')
  program('Program'),
  @JsonValue('Recording')
  recording('Recording'),
  @JsonValue('Season')
  season('Season'),
  @JsonValue('Series')
  series('Series'),
  @JsonValue('Studio')
  studio('Studio'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('TvChannel')
  tvchannel('TvChannel'),
  @JsonValue('TvProgram')
  tvprogram('TvProgram'),
  @JsonValue('UserRootFolder')
  userrootfolder('UserRootFolder'),
  @JsonValue('UserView')
  userview('UserView'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Year')
  year('Year');

  final String? value;

  const BaseItemKind(this.value);
}

enum ChannelItemSortField {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Name')
  name('Name'),
  @JsonValue('CommunityRating')
  communityrating('CommunityRating'),
  @JsonValue('PremiereDate')
  premieredate('PremiereDate'),
  @JsonValue('DateCreated')
  datecreated('DateCreated'),
  @JsonValue('Runtime')
  runtime('Runtime'),
  @JsonValue('PlayCount')
  playcount('PlayCount'),
  @JsonValue('CommunityPlayCount')
  communityplaycount('CommunityPlayCount');

  final String? value;

  const ChannelItemSortField(this.value);
}

enum ChannelMediaContentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Clip')
  clip('Clip'),
  @JsonValue('Podcast')
  podcast('Podcast'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('Movie')
  movie('Movie'),
  @JsonValue('Episode')
  episode('Episode'),
  @JsonValue('Song')
  song('Song'),
  @JsonValue('MovieExtra')
  movieextra('MovieExtra'),
  @JsonValue('TvExtra')
  tvextra('TvExtra');

  final String? value;

  const ChannelMediaContentType(this.value);
}

enum ChannelMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Photo')
  photo('Photo');

  final String? value;

  const ChannelMediaType(this.value);
}

enum ChannelType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TV')
  tv('TV'),
  @JsonValue('Radio')
  radio('Radio');

  final String? value;

  const ChannelType(this.value);
}

enum CodecType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Video')
  video('Video'),
  @JsonValue('VideoAudio')
  videoaudio('VideoAudio'),
  @JsonValue('Audio')
  audio('Audio');

  final String? value;

  const CodecType(this.value);
}

enum CollectionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('unknown')
  unknown('unknown'),
  @JsonValue('movies')
  movies('movies'),
  @JsonValue('tvshows')
  tvshows('tvshows'),
  @JsonValue('music')
  music('music'),
  @JsonValue('musicvideos')
  musicvideos('musicvideos'),
  @JsonValue('trailers')
  trailers('trailers'),
  @JsonValue('homevideos')
  homevideos('homevideos'),
  @JsonValue('boxsets')
  boxsets('boxsets'),
  @JsonValue('books')
  books('books'),
  @JsonValue('photos')
  photos('photos'),
  @JsonValue('livetv')
  livetv('livetv'),
  @JsonValue('playlists')
  playlists('playlists'),
  @JsonValue('folders')
  folders('folders');

  final String? value;

  const CollectionType(this.value);
}

enum CollectionTypeOptions {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movies')
  movies('movies'),
  @JsonValue('tvshows')
  tvshows('tvshows'),
  @JsonValue('music')
  music('music'),
  @JsonValue('musicvideos')
  musicvideos('musicvideos'),
  @JsonValue('homevideos')
  homevideos('homevideos'),
  @JsonValue('boxsets')
  boxsets('boxsets'),
  @JsonValue('books')
  books('books'),
  @JsonValue('mixed')
  mixed('mixed');

  final String? value;

  const CollectionTypeOptions(this.value);
}

enum DayOfWeek {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Sunday')
  sunday('Sunday'),
  @JsonValue('Monday')
  monday('Monday'),
  @JsonValue('Tuesday')
  tuesday('Tuesday'),
  @JsonValue('Wednesday')
  wednesday('Wednesday'),
  @JsonValue('Thursday')
  thursday('Thursday'),
  @JsonValue('Friday')
  friday('Friday'),
  @JsonValue('Saturday')
  saturday('Saturday');

  final String? value;

  const DayOfWeek(this.value);
}

enum DayPattern {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Daily')
  daily('Daily'),
  @JsonValue('Weekdays')
  weekdays('Weekdays'),
  @JsonValue('Weekends')
  weekends('Weekends');

  final String? value;

  const DayPattern(this.value);
}

enum DeinterlaceMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('yadif')
  yadif('yadif'),
  @JsonValue('bwdif')
  bwdif('bwdif');

  final String? value;

  const DeinterlaceMethod(this.value);
}

enum DlnaProfileType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Photo')
  photo('Photo'),
  @JsonValue('Subtitle')
  subtitle('Subtitle'),
  @JsonValue('Lyric')
  lyric('Lyric');

  final String? value;

  const DlnaProfileType(this.value);
}

enum DownMixStereoAlgorithms {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('Dave750')
  dave750('Dave750'),
  @JsonValue('NightmodeDialogue')
  nightmodedialogue('NightmodeDialogue'),
  @JsonValue('Rfc7845')
  rfc7845('Rfc7845'),
  @JsonValue('Ac4')
  ac4('Ac4');

  final String? value;

  const DownMixStereoAlgorithms(this.value);
}

enum DynamicDayOfWeek {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Sunday')
  sunday('Sunday'),
  @JsonValue('Monday')
  monday('Monday'),
  @JsonValue('Tuesday')
  tuesday('Tuesday'),
  @JsonValue('Wednesday')
  wednesday('Wednesday'),
  @JsonValue('Thursday')
  thursday('Thursday'),
  @JsonValue('Friday')
  friday('Friday'),
  @JsonValue('Saturday')
  saturday('Saturday'),
  @JsonValue('Everyday')
  everyday('Everyday'),
  @JsonValue('Weekday')
  weekday('Weekday'),
  @JsonValue('Weekend')
  weekend('Weekend');

  final String? value;

  const DynamicDayOfWeek(this.value);
}

enum EmbeddedSubtitleOptions {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('AllowAll')
  allowall('AllowAll'),
  @JsonValue('AllowText')
  allowtext('AllowText'),
  @JsonValue('AllowImage')
  allowimage('AllowImage'),
  @JsonValue('AllowNone')
  allownone('AllowNone');

  final String? value;

  const EmbeddedSubtitleOptions(this.value);
}

enum EncoderPreset {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('auto')
  auto('auto'),
  @JsonValue('placebo')
  placebo('placebo'),
  @JsonValue('veryslow')
  veryslow('veryslow'),
  @JsonValue('slower')
  slower('slower'),
  @JsonValue('slow')
  slow('slow'),
  @JsonValue('medium')
  medium('medium'),
  @JsonValue('fast')
  fast('fast'),
  @JsonValue('faster')
  faster('faster'),
  @JsonValue('veryfast')
  veryfast('veryfast'),
  @JsonValue('superfast')
  superfast('superfast'),
  @JsonValue('ultrafast')
  ultrafast('ultrafast');

  final String? value;

  const EncoderPreset(this.value);
}

enum EncodingContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const EncodingContext(this.value);
}

enum ExternalIdMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Album')
  album('Album'),
  @JsonValue('AlbumArtist')
  albumartist('AlbumArtist'),
  @JsonValue('Artist')
  artist('Artist'),
  @JsonValue('BoxSet')
  boxset('BoxSet'),
  @JsonValue('Episode')
  episode('Episode'),
  @JsonValue('Movie')
  movie('Movie'),
  @JsonValue('OtherArtist')
  otherartist('OtherArtist'),
  @JsonValue('Person')
  person('Person'),
  @JsonValue('ReleaseGroup')
  releasegroup('ReleaseGroup'),
  @JsonValue('Season')
  season('Season'),
  @JsonValue('Series')
  series('Series'),
  @JsonValue('Track')
  track('Track'),
  @JsonValue('Book')
  book('Book');

  final String? value;

  const ExternalIdMediaType(this.value);
}

enum ExtraType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('Clip')
  clip('Clip'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('BehindTheScenes')
  behindthescenes('BehindTheScenes'),
  @JsonValue('DeletedScene')
  deletedscene('DeletedScene'),
  @JsonValue('Interview')
  interview('Interview'),
  @JsonValue('Scene')
  scene('Scene'),
  @JsonValue('Sample')
  sample('Sample'),
  @JsonValue('ThemeSong')
  themesong('ThemeSong'),
  @JsonValue('ThemeVideo')
  themevideo('ThemeVideo'),
  @JsonValue('Featurette')
  featurette('Featurette'),
  @JsonValue('Short')
  short('Short');

  final String? value;

  const ExtraType(this.value);
}

enum FileSystemEntryType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('File')
  file('File'),
  @JsonValue('Directory')
  directory('Directory'),
  @JsonValue('NetworkComputer')
  networkcomputer('NetworkComputer'),
  @JsonValue('NetworkShare')
  networkshare('NetworkShare');

  final String? value;

  const FileSystemEntryType(this.value);
}

enum ForgotPasswordAction {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ContactAdmin')
  contactadmin('ContactAdmin'),
  @JsonValue('PinCode')
  pincode('PinCode'),
  @JsonValue('InNetworkRequired')
  innetworkrequired('InNetworkRequired');

  final String? value;

  const ForgotPasswordAction(this.value);
}

enum GeneralCommandType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MoveUp')
  moveup('MoveUp'),
  @JsonValue('MoveDown')
  movedown('MoveDown'),
  @JsonValue('MoveLeft')
  moveleft('MoveLeft'),
  @JsonValue('MoveRight')
  moveright('MoveRight'),
  @JsonValue('PageUp')
  pageup('PageUp'),
  @JsonValue('PageDown')
  pagedown('PageDown'),
  @JsonValue('PreviousLetter')
  previousletter('PreviousLetter'),
  @JsonValue('NextLetter')
  nextletter('NextLetter'),
  @JsonValue('ToggleOsd')
  toggleosd('ToggleOsd'),
  @JsonValue('ToggleContextMenu')
  togglecontextmenu('ToggleContextMenu'),
  @JsonValue('Select')
  select('Select'),
  @JsonValue('Back')
  back('Back'),
  @JsonValue('TakeScreenshot')
  takescreenshot('TakeScreenshot'),
  @JsonValue('SendKey')
  sendkey('SendKey'),
  @JsonValue('SendString')
  sendstring('SendString'),
  @JsonValue('GoHome')
  gohome('GoHome'),
  @JsonValue('GoToSettings')
  gotosettings('GoToSettings'),
  @JsonValue('VolumeUp')
  volumeup('VolumeUp'),
  @JsonValue('VolumeDown')
  volumedown('VolumeDown'),
  @JsonValue('Mute')
  mute('Mute'),
  @JsonValue('Unmute')
  unmute('Unmute'),
  @JsonValue('ToggleMute')
  togglemute('ToggleMute'),
  @JsonValue('SetVolume')
  setvolume('SetVolume'),
  @JsonValue('SetAudioStreamIndex')
  setaudiostreamindex('SetAudioStreamIndex'),
  @JsonValue('SetSubtitleStreamIndex')
  setsubtitlestreamindex('SetSubtitleStreamIndex'),
  @JsonValue('ToggleFullscreen')
  togglefullscreen('ToggleFullscreen'),
  @JsonValue('DisplayContent')
  displaycontent('DisplayContent'),
  @JsonValue('GoToSearch')
  gotosearch('GoToSearch'),
  @JsonValue('DisplayMessage')
  displaymessage('DisplayMessage'),
  @JsonValue('SetRepeatMode')
  setrepeatmode('SetRepeatMode'),
  @JsonValue('ChannelUp')
  channelup('ChannelUp'),
  @JsonValue('ChannelDown')
  channeldown('ChannelDown'),
  @JsonValue('Guide')
  guide('Guide'),
  @JsonValue('ToggleStats')
  togglestats('ToggleStats'),
  @JsonValue('PlayMediaSource')
  playmediasource('PlayMediaSource'),
  @JsonValue('PlayTrailers')
  playtrailers('PlayTrailers'),
  @JsonValue('SetShuffleQueue')
  setshufflequeue('SetShuffleQueue'),
  @JsonValue('PlayState')
  playstate('PlayState'),
  @JsonValue('PlayNext')
  playnext('PlayNext'),
  @JsonValue('ToggleOsdMenu')
  toggleosdmenu('ToggleOsdMenu'),
  @JsonValue('Play')
  play('Play'),
  @JsonValue('SetMaxStreamingBitrate')
  setmaxstreamingbitrate('SetMaxStreamingBitrate'),
  @JsonValue('SetPlaybackOrder')
  setplaybackorder('SetPlaybackOrder');

  final String? value;

  const GeneralCommandType(this.value);
}

enum GroupQueueMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Queue')
  queue('Queue'),
  @JsonValue('QueueNext')
  queuenext('QueueNext');

  final String? value;

  const GroupQueueMode(this.value);
}

enum GroupRepeatMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('RepeatOne')
  repeatone('RepeatOne'),
  @JsonValue('RepeatAll')
  repeatall('RepeatAll'),
  @JsonValue('RepeatNone')
  repeatnone('RepeatNone');

  final String? value;

  const GroupRepeatMode(this.value);
}

enum GroupShuffleMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Sorted')
  sorted('Sorted'),
  @JsonValue('Shuffle')
  shuffle('Shuffle');

  final String? value;

  const GroupShuffleMode(this.value);
}

enum GroupStateType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Idle')
  idle('Idle'),
  @JsonValue('Waiting')
  waiting('Waiting'),
  @JsonValue('Paused')
  paused('Paused'),
  @JsonValue('Playing')
  playing('Playing');

  final String? value;

  const GroupStateType(this.value);
}

enum GroupUpdateType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('UserJoined')
  userjoined('UserJoined'),
  @JsonValue('UserLeft')
  userleft('UserLeft'),
  @JsonValue('GroupJoined')
  groupjoined('GroupJoined'),
  @JsonValue('GroupLeft')
  groupleft('GroupLeft'),
  @JsonValue('StateUpdate')
  stateupdate('StateUpdate'),
  @JsonValue('PlayQueue')
  playqueue('PlayQueue'),
  @JsonValue('NotInGroup')
  notingroup('NotInGroup'),
  @JsonValue('GroupDoesNotExist')
  groupdoesnotexist('GroupDoesNotExist'),
  @JsonValue('CreateGroupDenied')
  creategroupdenied('CreateGroupDenied'),
  @JsonValue('JoinGroupDenied')
  joingroupdenied('JoinGroupDenied'),
  @JsonValue('LibraryAccessDenied')
  libraryaccessdenied('LibraryAccessDenied');

  final String? value;

  const GroupUpdateType(this.value);
}

enum HardwareAccelerationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('none')
  none('none'),
  @JsonValue('amf')
  amf('amf'),
  @JsonValue('qsv')
  qsv('qsv'),
  @JsonValue('nvenc')
  nvenc('nvenc'),
  @JsonValue('v4l2m2m')
  v4l2m2m('v4l2m2m'),
  @JsonValue('vaapi')
  vaapi('vaapi'),
  @JsonValue('videotoolbox')
  videotoolbox('videotoolbox'),
  @JsonValue('rkmpp')
  rkmpp('rkmpp');

  final String? value;

  const HardwareAccelerationType(this.value);
}

enum ImageFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ImageFormat(this.value);
}

enum ImageOrientation {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TopLeft')
  topleft('TopLeft'),
  @JsonValue('TopRight')
  topright('TopRight'),
  @JsonValue('BottomRight')
  bottomright('BottomRight'),
  @JsonValue('BottomLeft')
  bottomleft('BottomLeft'),
  @JsonValue('LeftTop')
  lefttop('LeftTop'),
  @JsonValue('RightTop')
  righttop('RightTop'),
  @JsonValue('RightBottom')
  rightbottom('RightBottom'),
  @JsonValue('LeftBottom')
  leftbottom('LeftBottom');

  final String? value;

  const ImageOrientation(this.value);
}

enum ImageResolution {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MatchSource')
  matchsource('MatchSource'),
  @JsonValue('P144')
  p144('P144'),
  @JsonValue('P240')
  p240('P240'),
  @JsonValue('P360')
  p360('P360'),
  @JsonValue('P480')
  p480('P480'),
  @JsonValue('P720')
  p720('P720'),
  @JsonValue('P1080')
  p1080('P1080'),
  @JsonValue('P1440')
  p1440('P1440'),
  @JsonValue('P2160')
  p2160('P2160');

  final String? value;

  const ImageResolution(this.value);
}

enum ImageSavingConvention {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Legacy')
  legacy('Legacy'),
  @JsonValue('Compatible')
  compatible('Compatible');

  final String? value;

  const ImageSavingConvention(this.value);
}

enum ImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ImageType(this.value);
}

enum IsoType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Dvd')
  dvd('Dvd'),
  @JsonValue('BluRay')
  bluray('BluRay');

  final String? value;

  const IsoType(this.value);
}

enum ItemFields {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('AirTime')
  airtime('AirTime'),
  @JsonValue('CanDelete')
  candelete('CanDelete'),
  @JsonValue('CanDownload')
  candownload('CanDownload'),
  @JsonValue('ChannelInfo')
  channelinfo('ChannelInfo'),
  @JsonValue('Chapters')
  chapters('Chapters'),
  @JsonValue('Trickplay')
  trickplay('Trickplay'),
  @JsonValue('ChildCount')
  childcount('ChildCount'),
  @JsonValue('CumulativeRunTimeTicks')
  cumulativeruntimeticks('CumulativeRunTimeTicks'),
  @JsonValue('CustomRating')
  customrating('CustomRating'),
  @JsonValue('DateCreated')
  datecreated('DateCreated'),
  @JsonValue('DateLastMediaAdded')
  datelastmediaadded('DateLastMediaAdded'),
  @JsonValue('DisplayPreferencesId')
  displaypreferencesid('DisplayPreferencesId'),
  @JsonValue('Etag')
  etag('Etag'),
  @JsonValue('ExternalUrls')
  externalurls('ExternalUrls'),
  @JsonValue('Genres')
  genres('Genres'),
  @JsonValue('HomePageUrl')
  homepageurl('HomePageUrl'),
  @JsonValue('ItemCounts')
  itemcounts('ItemCounts'),
  @JsonValue('MediaSourceCount')
  mediasourcecount('MediaSourceCount'),
  @JsonValue('MediaSources')
  mediasources('MediaSources'),
  @JsonValue('OriginalTitle')
  originaltitle('OriginalTitle'),
  @JsonValue('Overview')
  overview('Overview'),
  @JsonValue('ParentId')
  parentid('ParentId'),
  @JsonValue('Path')
  path('Path'),
  @JsonValue('People')
  people('People'),
  @JsonValue('PlayAccess')
  playaccess('PlayAccess'),
  @JsonValue('ProductionLocations')
  productionlocations('ProductionLocations'),
  @JsonValue('ProviderIds')
  providerids('ProviderIds'),
  @JsonValue('PrimaryImageAspectRatio')
  primaryimageaspectratio('PrimaryImageAspectRatio'),
  @JsonValue('RecursiveItemCount')
  recursiveitemcount('RecursiveItemCount'),
  @JsonValue('Settings')
  settings('Settings'),
  @JsonValue('ScreenshotImageTags')
  screenshotimagetags('ScreenshotImageTags'),
  @JsonValue('SeriesPrimaryImage')
  seriesprimaryimage('SeriesPrimaryImage'),
  @JsonValue('SeriesStudio')
  seriesstudio('SeriesStudio'),
  @JsonValue('SortName')
  sortname('SortName'),
  @JsonValue('SpecialEpisodeNumbers')
  specialepisodenumbers('SpecialEpisodeNumbers'),
  @JsonValue('Studios')
  studios('Studios'),
  @JsonValue('Taglines')
  taglines('Taglines'),
  @JsonValue('Tags')
  tags('Tags'),
  @JsonValue('RemoteTrailers')
  remotetrailers('RemoteTrailers'),
  @JsonValue('MediaStreams')
  mediastreams('MediaStreams'),
  @JsonValue('SeasonUserData')
  seasonuserdata('SeasonUserData'),
  @JsonValue('ServiceName')
  servicename('ServiceName'),
  @JsonValue('ThemeSongIds')
  themesongids('ThemeSongIds'),
  @JsonValue('ThemeVideoIds')
  themevideoids('ThemeVideoIds'),
  @JsonValue('ExternalEtag')
  externaletag('ExternalEtag'),
  @JsonValue('PresentationUniqueKey')
  presentationuniquekey('PresentationUniqueKey'),
  @JsonValue('InheritedParentalRatingValue')
  inheritedparentalratingvalue('InheritedParentalRatingValue'),
  @JsonValue('ExternalSeriesId')
  externalseriesid('ExternalSeriesId'),
  @JsonValue('SeriesPresentationUniqueKey')
  seriespresentationuniquekey('SeriesPresentationUniqueKey'),
  @JsonValue('DateLastRefreshed')
  datelastrefreshed('DateLastRefreshed'),
  @JsonValue('DateLastSaved')
  datelastsaved('DateLastSaved'),
  @JsonValue('RefreshState')
  refreshstate('RefreshState'),
  @JsonValue('ChannelImage')
  channelimage('ChannelImage'),
  @JsonValue('EnableMediaSourceDisplay')
  enablemediasourcedisplay('EnableMediaSourceDisplay'),
  @JsonValue('Width')
  width('Width'),
  @JsonValue('Height')
  height('Height'),
  @JsonValue('ExtraIds')
  extraids('ExtraIds'),
  @JsonValue('LocalTrailerCount')
  localtrailercount('LocalTrailerCount'),
  @JsonValue('IsHD')
  ishd('IsHD'),
  @JsonValue('SpecialFeatureCount')
  specialfeaturecount('SpecialFeatureCount');

  final String? value;

  const ItemFields(this.value);
}

enum ItemFilter {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('IsFolder')
  isfolder('IsFolder'),
  @JsonValue('IsNotFolder')
  isnotfolder('IsNotFolder'),
  @JsonValue('IsUnplayed')
  isunplayed('IsUnplayed'),
  @JsonValue('IsPlayed')
  isplayed('IsPlayed'),
  @JsonValue('IsFavorite')
  isfavorite('IsFavorite'),
  @JsonValue('IsResumable')
  isresumable('IsResumable'),
  @JsonValue('Likes')
  likes('Likes'),
  @JsonValue('Dislikes')
  dislikes('Dislikes'),
  @JsonValue('IsFavoriteOrLikes')
  isfavoriteorlikes('IsFavoriteOrLikes');

  final String? value;

  const ItemFilter(this.value);
}

enum ItemSortBy {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Default')
  $default('Default'),
  @JsonValue('AiredEpisodeOrder')
  airedepisodeorder('AiredEpisodeOrder'),
  @JsonValue('Album')
  album('Album'),
  @JsonValue('AlbumArtist')
  albumartist('AlbumArtist'),
  @JsonValue('Artist')
  artist('Artist'),
  @JsonValue('DateCreated')
  datecreated('DateCreated'),
  @JsonValue('OfficialRating')
  officialrating('OfficialRating'),
  @JsonValue('DatePlayed')
  dateplayed('DatePlayed'),
  @JsonValue('PremiereDate')
  premieredate('PremiereDate'),
  @JsonValue('StartDate')
  startdate('StartDate'),
  @JsonValue('SortName')
  sortname('SortName'),
  @JsonValue('Name')
  name('Name'),
  @JsonValue('Random')
  random('Random'),
  @JsonValue('Runtime')
  runtime('Runtime'),
  @JsonValue('CommunityRating')
  communityrating('CommunityRating'),
  @JsonValue('ProductionYear')
  productionyear('ProductionYear'),
  @JsonValue('PlayCount')
  playcount('PlayCount'),
  @JsonValue('CriticRating')
  criticrating('CriticRating'),
  @JsonValue('IsFolder')
  isfolder('IsFolder'),
  @JsonValue('IsUnplayed')
  isunplayed('IsUnplayed'),
  @JsonValue('IsPlayed')
  isplayed('IsPlayed'),
  @JsonValue('SeriesSortName')
  seriessortname('SeriesSortName'),
  @JsonValue('VideoBitRate')
  videobitrate('VideoBitRate'),
  @JsonValue('AirTime')
  airtime('AirTime'),
  @JsonValue('Studio')
  studio('Studio'),
  @JsonValue('IsFavoriteOrLiked')
  isfavoriteorliked('IsFavoriteOrLiked'),
  @JsonValue('DateLastContentAdded')
  datelastcontentadded('DateLastContentAdded'),
  @JsonValue('SeriesDatePlayed')
  seriesdateplayed('SeriesDatePlayed'),
  @JsonValue('ParentIndexNumber')
  parentindexnumber('ParentIndexNumber'),
  @JsonValue('IndexNumber')
  indexnumber('IndexNumber'),
  @JsonValue('SimilarityScore')
  similarityscore('SimilarityScore'),
  @JsonValue('SearchScore')
  searchscore('SearchScore');

  final String? value;

  const ItemSortBy(this.value);
}

enum KeepUntil {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('UntilDeleted')
  untildeleted('UntilDeleted'),
  @JsonValue('UntilSpaceNeeded')
  untilspaceneeded('UntilSpaceNeeded'),
  @JsonValue('UntilWatched')
  untilwatched('UntilWatched'),
  @JsonValue('UntilDate')
  untildate('UntilDate');

  final String? value;

  const KeepUntil(this.value);
}

enum LiveTvServiceStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Ok')
  ok('Ok'),
  @JsonValue('Unavailable')
  unavailable('Unavailable');

  final String? value;

  const LiveTvServiceStatus(this.value);
}

enum LocationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('FileSystem')
  filesystem('FileSystem'),
  @JsonValue('Remote')
  remote('Remote'),
  @JsonValue('Virtual')
  virtual('Virtual'),
  @JsonValue('Offline')
  offline('Offline');

  final String? value;

  const LocationType(this.value);
}

enum LogLevel {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Trace')
  trace('Trace'),
  @JsonValue('Debug')
  debug('Debug'),
  @JsonValue('Information')
  information('Information'),
  @JsonValue('Warning')
  warning('Warning'),
  @JsonValue('Error')
  error('Error'),
  @JsonValue('Critical')
  critical('Critical'),
  @JsonValue('None')
  none('None');

  final String? value;

  const LogLevel(this.value);
}

enum MediaProtocol {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('File')
  file('File'),
  @JsonValue('Http')
  http('Http'),
  @JsonValue('Rtmp')
  rtmp('Rtmp'),
  @JsonValue('Rtsp')
  rtsp('Rtsp'),
  @JsonValue('Udp')
  udp('Udp'),
  @JsonValue('Rtp')
  rtp('Rtp'),
  @JsonValue('Ftp')
  ftp('Ftp');

  final String? value;

  const MediaProtocol(this.value);
}

enum MediaSegmentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('Commercial')
  commercial('Commercial'),
  @JsonValue('Preview')
  preview('Preview'),
  @JsonValue('Recap')
  recap('Recap'),
  @JsonValue('Outro')
  outro('Outro'),
  @JsonValue('Intro')
  intro('Intro');

  final String? value;

  const MediaSegmentType(this.value);
}

enum MediaSourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Default')
  $default('Default'),
  @JsonValue('Grouping')
  grouping('Grouping'),
  @JsonValue('Placeholder')
  placeholder('Placeholder');

  final String? value;

  const MediaSourceType(this.value);
}

enum MediaStreamProtocol {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('http')
  http('http'),
  @JsonValue('hls')
  hls('hls');

  final String? value;

  const MediaStreamProtocol(this.value);
}

enum MediaStreamType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Subtitle')
  subtitle('Subtitle'),
  @JsonValue('EmbeddedImage')
  embeddedimage('EmbeddedImage'),
  @JsonValue('Data')
  data('Data'),
  @JsonValue('Lyric')
  lyric('Lyric');

  final String? value;

  const MediaStreamType(this.value);
}

enum MediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('Photo')
  photo('Photo'),
  @JsonValue('Book')
  book('Book');

  final String? value;

  const MediaType(this.value);
}

enum MetadataField {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Cast')
  cast('Cast'),
  @JsonValue('Genres')
  genres('Genres'),
  @JsonValue('ProductionLocations')
  productionlocations('ProductionLocations'),
  @JsonValue('Studios')
  studios('Studios'),
  @JsonValue('Tags')
  tags('Tags'),
  @JsonValue('Name')
  name('Name'),
  @JsonValue('Overview')
  overview('Overview'),
  @JsonValue('Runtime')
  runtime('Runtime'),
  @JsonValue('OfficialRating')
  officialrating('OfficialRating');

  final String? value;

  const MetadataField(this.value);
}

enum MetadataRefreshMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('ValidationOnly')
  validationonly('ValidationOnly'),
  @JsonValue('Default')
  $default('Default'),
  @JsonValue('FullRefresh')
  fullrefresh('FullRefresh');

  final String? value;

  const MetadataRefreshMode(this.value);
}

enum PersonKind {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('Actor')
  actor('Actor'),
  @JsonValue('Director')
  director('Director'),
  @JsonValue('Composer')
  composer('Composer'),
  @JsonValue('Writer')
  writer('Writer'),
  @JsonValue('GuestStar')
  gueststar('GuestStar'),
  @JsonValue('Producer')
  producer('Producer'),
  @JsonValue('Conductor')
  conductor('Conductor'),
  @JsonValue('Lyricist')
  lyricist('Lyricist'),
  @JsonValue('Arranger')
  arranger('Arranger'),
  @JsonValue('Engineer')
  engineer('Engineer'),
  @JsonValue('Mixer')
  mixer('Mixer'),
  @JsonValue('Remixer')
  remixer('Remixer'),
  @JsonValue('Creator')
  creator('Creator'),
  @JsonValue('Artist')
  artist('Artist'),
  @JsonValue('AlbumArtist')
  albumartist('AlbumArtist'),
  @JsonValue('Author')
  author('Author'),
  @JsonValue('Illustrator')
  illustrator('Illustrator'),
  @JsonValue('Penciller')
  penciller('Penciller'),
  @JsonValue('Inker')
  inker('Inker'),
  @JsonValue('Colorist')
  colorist('Colorist'),
  @JsonValue('Letterer')
  letterer('Letterer'),
  @JsonValue('CoverArtist')
  coverartist('CoverArtist'),
  @JsonValue('Editor')
  editor('Editor'),
  @JsonValue('Translator')
  translator('Translator');

  final String? value;

  const PersonKind(this.value);
}

enum PlayAccess {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Full')
  full('Full'),
  @JsonValue('None')
  none('None');

  final String? value;

  const PlayAccess(this.value);
}

enum PlaybackErrorCode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NotAllowed')
  notallowed('NotAllowed'),
  @JsonValue('NoCompatibleStream')
  nocompatiblestream('NoCompatibleStream'),
  @JsonValue('RateLimitExceeded')
  ratelimitexceeded('RateLimitExceeded');

  final String? value;

  const PlaybackErrorCode(this.value);
}

enum PlaybackOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Default')
  $default('Default'),
  @JsonValue('Shuffle')
  shuffle('Shuffle');

  final String? value;

  const PlaybackOrder(this.value);
}

enum PlaybackRequestType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Play')
  play('Play'),
  @JsonValue('SetPlaylistItem')
  setplaylistitem('SetPlaylistItem'),
  @JsonValue('RemoveFromPlaylist')
  removefromplaylist('RemoveFromPlaylist'),
  @JsonValue('MovePlaylistItem')
  moveplaylistitem('MovePlaylistItem'),
  @JsonValue('Queue')
  queue('Queue'),
  @JsonValue('Unpause')
  unpause('Unpause'),
  @JsonValue('Pause')
  pause('Pause'),
  @JsonValue('Stop')
  stop('Stop'),
  @JsonValue('Seek')
  seek('Seek'),
  @JsonValue('Buffer')
  buffer('Buffer'),
  @JsonValue('Ready')
  ready('Ready'),
  @JsonValue('NextItem')
  nextitem('NextItem'),
  @JsonValue('PreviousItem')
  previousitem('PreviousItem'),
  @JsonValue('SetRepeatMode')
  setrepeatmode('SetRepeatMode'),
  @JsonValue('SetShuffleMode')
  setshufflemode('SetShuffleMode'),
  @JsonValue('Ping')
  ping('Ping'),
  @JsonValue('IgnoreWait')
  ignorewait('IgnoreWait');

  final String? value;

  const PlaybackRequestType(this.value);
}

enum PlayCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PlayNow')
  playnow('PlayNow'),
  @JsonValue('PlayNext')
  playnext('PlayNext'),
  @JsonValue('PlayLast')
  playlast('PlayLast'),
  @JsonValue('PlayInstantMix')
  playinstantmix('PlayInstantMix'),
  @JsonValue('PlayShuffle')
  playshuffle('PlayShuffle');

  final String? value;

  const PlayCommand(this.value);
}

enum PlayMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Transcode')
  transcode('Transcode'),
  @JsonValue('DirectStream')
  directstream('DirectStream'),
  @JsonValue('DirectPlay')
  directplay('DirectPlay');

  final String? value;

  const PlayMethod(this.value);
}

enum PlayQueueUpdateReason {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NewPlaylist')
  newplaylist('NewPlaylist'),
  @JsonValue('SetCurrentItem')
  setcurrentitem('SetCurrentItem'),
  @JsonValue('RemoveItems')
  removeitems('RemoveItems'),
  @JsonValue('MoveItem')
  moveitem('MoveItem'),
  @JsonValue('Queue')
  queue('Queue'),
  @JsonValue('QueueNext')
  queuenext('QueueNext'),
  @JsonValue('NextItem')
  nextitem('NextItem'),
  @JsonValue('PreviousItem')
  previousitem('PreviousItem'),
  @JsonValue('RepeatMode')
  repeatmode('RepeatMode'),
  @JsonValue('ShuffleMode')
  shufflemode('ShuffleMode');

  final String? value;

  const PlayQueueUpdateReason(this.value);
}

enum PlaystateCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Stop')
  stop('Stop'),
  @JsonValue('Pause')
  pause('Pause'),
  @JsonValue('Unpause')
  unpause('Unpause'),
  @JsonValue('NextTrack')
  nexttrack('NextTrack'),
  @JsonValue('PreviousTrack')
  previoustrack('PreviousTrack'),
  @JsonValue('Seek')
  seek('Seek'),
  @JsonValue('Rewind')
  rewind('Rewind'),
  @JsonValue('FastForward')
  fastforward('FastForward'),
  @JsonValue('PlayPause')
  playpause('PlayPause');

  final String? value;

  const PlaystateCommand(this.value);
}

enum PluginStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Active')
  active('Active'),
  @JsonValue('Restart')
  restart('Restart'),
  @JsonValue('Deleted')
  deleted('Deleted'),
  @JsonValue('Superceded')
  superceded('Superceded'),
  @JsonValue('Malfunctioned')
  malfunctioned('Malfunctioned'),
  @JsonValue('NotSupported')
  notsupported('NotSupported'),
  @JsonValue('Disabled')
  disabled('Disabled');

  final String? value;

  const PluginStatus(this.value);
}

enum ProcessPriorityClass {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Normal')
  normal('Normal'),
  @JsonValue('Idle')
  idle('Idle'),
  @JsonValue('High')
  high('High'),
  @JsonValue('RealTime')
  realtime('RealTime'),
  @JsonValue('BelowNormal')
  belownormal('BelowNormal'),
  @JsonValue('AboveNormal')
  abovenormal('AboveNormal');

  final String? value;

  const ProcessPriorityClass(this.value);
}

enum ProfileConditionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Equals')
  equals('Equals'),
  @JsonValue('NotEquals')
  notequals('NotEquals'),
  @JsonValue('LessThanEqual')
  lessthanequal('LessThanEqual'),
  @JsonValue('GreaterThanEqual')
  greaterthanequal('GreaterThanEqual'),
  @JsonValue('EqualsAny')
  equalsany('EqualsAny');

  final String? value;

  const ProfileConditionType(this.value);
}

enum ProfileConditionValue {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('AudioChannels')
  audiochannels('AudioChannels'),
  @JsonValue('AudioBitrate')
  audiobitrate('AudioBitrate'),
  @JsonValue('AudioProfile')
  audioprofile('AudioProfile'),
  @JsonValue('Width')
  width('Width'),
  @JsonValue('Height')
  height('Height'),
  @JsonValue('Has64BitOffsets')
  has64bitoffsets('Has64BitOffsets'),
  @JsonValue('PacketLength')
  packetlength('PacketLength'),
  @JsonValue('VideoBitDepth')
  videobitdepth('VideoBitDepth'),
  @JsonValue('VideoBitrate')
  videobitrate('VideoBitrate'),
  @JsonValue('VideoFramerate')
  videoframerate('VideoFramerate'),
  @JsonValue('VideoLevel')
  videolevel('VideoLevel'),
  @JsonValue('VideoProfile')
  videoprofile('VideoProfile'),
  @JsonValue('VideoTimestamp')
  videotimestamp('VideoTimestamp'),
  @JsonValue('IsAnamorphic')
  isanamorphic('IsAnamorphic'),
  @JsonValue('RefFrames')
  refframes('RefFrames'),
  @JsonValue('NumAudioStreams')
  numaudiostreams('NumAudioStreams'),
  @JsonValue('NumVideoStreams')
  numvideostreams('NumVideoStreams'),
  @JsonValue('IsSecondaryAudio')
  issecondaryaudio('IsSecondaryAudio'),
  @JsonValue('VideoCodecTag')
  videocodectag('VideoCodecTag'),
  @JsonValue('IsAvc')
  isavc('IsAvc'),
  @JsonValue('IsInterlaced')
  isinterlaced('IsInterlaced'),
  @JsonValue('AudioSampleRate')
  audiosamplerate('AudioSampleRate'),
  @JsonValue('AudioBitDepth')
  audiobitdepth('AudioBitDepth'),
  @JsonValue('VideoRangeType')
  videorangetype('VideoRangeType');

  final String? value;

  const ProfileConditionValue(this.value);
}

enum ProgramAudio {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Mono')
  mono('Mono'),
  @JsonValue('Stereo')
  stereo('Stereo'),
  @JsonValue('Dolby')
  dolby('Dolby'),
  @JsonValue('DolbyDigital')
  dolbydigital('DolbyDigital'),
  @JsonValue('Thx')
  thx('Thx'),
  @JsonValue('Atmos')
  atmos('Atmos');

  final String? value;

  const ProgramAudio(this.value);
}

enum RatingType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Score')
  score('Score'),
  @JsonValue('Likes')
  likes('Likes');

  final String? value;

  const RatingType(this.value);
}

enum RecommendationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('SimilarToRecentlyPlayed')
  similartorecentlyplayed('SimilarToRecentlyPlayed'),
  @JsonValue('SimilarToLikedItem')
  similartolikeditem('SimilarToLikedItem'),
  @JsonValue('HasDirectorFromRecentlyPlayed')
  hasdirectorfromrecentlyplayed('HasDirectorFromRecentlyPlayed'),
  @JsonValue('HasActorFromRecentlyPlayed')
  hasactorfromrecentlyplayed('HasActorFromRecentlyPlayed'),
  @JsonValue('HasLikedDirector')
  haslikeddirector('HasLikedDirector'),
  @JsonValue('HasLikedActor')
  haslikedactor('HasLikedActor');

  final String? value;

  const RecommendationType(this.value);
}

enum RecordingStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('New')
  $new('New'),
  @JsonValue('InProgress')
  inprogress('InProgress'),
  @JsonValue('Completed')
  completed('Completed'),
  @JsonValue('Cancelled')
  cancelled('Cancelled'),
  @JsonValue('ConflictedOk')
  conflictedok('ConflictedOk'),
  @JsonValue('ConflictedNotOk')
  conflictednotok('ConflictedNotOk'),
  @JsonValue('Error')
  error('Error');

  final String? value;

  const RecordingStatus(this.value);
}

enum RepeatMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('RepeatNone')
  repeatnone('RepeatNone'),
  @JsonValue('RepeatAll')
  repeatall('RepeatAll'),
  @JsonValue('RepeatOne')
  repeatone('RepeatOne');

  final String? value;

  const RepeatMode(this.value);
}

enum ScrollDirection {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Horizontal')
  horizontal('Horizontal'),
  @JsonValue('Vertical')
  vertical('Vertical');

  final String? value;

  const ScrollDirection(this.value);
}

enum SendCommandType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unpause')
  unpause('Unpause'),
  @JsonValue('Pause')
  pause('Pause'),
  @JsonValue('Stop')
  stop('Stop'),
  @JsonValue('Seek')
  seek('Seek');

  final String? value;

  const SendCommandType(this.value);
}

enum SeriesStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Continuing')
  continuing('Continuing'),
  @JsonValue('Ended')
  ended('Ended'),
  @JsonValue('Unreleased')
  unreleased('Unreleased');

  final String? value;

  const SeriesStatus(this.value);
}

enum SessionMessageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ForceKeepAlive')
  forcekeepalive('ForceKeepAlive'),
  @JsonValue('GeneralCommand')
  generalcommand('GeneralCommand'),
  @JsonValue('UserDataChanged')
  userdatachanged('UserDataChanged'),
  @JsonValue('Sessions')
  sessions('Sessions'),
  @JsonValue('Play')
  play('Play'),
  @JsonValue('SyncPlayCommand')
  syncplaycommand('SyncPlayCommand'),
  @JsonValue('SyncPlayGroupUpdate')
  syncplaygroupupdate('SyncPlayGroupUpdate'),
  @JsonValue('Playstate')
  playstate('Playstate'),
  @JsonValue('RestartRequired')
  restartrequired('RestartRequired'),
  @JsonValue('ServerShuttingDown')
  servershuttingdown('ServerShuttingDown'),
  @JsonValue('ServerRestarting')
  serverrestarting('ServerRestarting'),
  @JsonValue('LibraryChanged')
  librarychanged('LibraryChanged'),
  @JsonValue('UserDeleted')
  userdeleted('UserDeleted'),
  @JsonValue('UserUpdated')
  userupdated('UserUpdated'),
  @JsonValue('SeriesTimerCreated')
  seriestimercreated('SeriesTimerCreated'),
  @JsonValue('TimerCreated')
  timercreated('TimerCreated'),
  @JsonValue('SeriesTimerCancelled')
  seriestimercancelled('SeriesTimerCancelled'),
  @JsonValue('TimerCancelled')
  timercancelled('TimerCancelled'),
  @JsonValue('RefreshProgress')
  refreshprogress('RefreshProgress'),
  @JsonValue('ScheduledTaskEnded')
  scheduledtaskended('ScheduledTaskEnded'),
  @JsonValue('PackageInstallationCancelled')
  packageinstallationcancelled('PackageInstallationCancelled'),
  @JsonValue('PackageInstallationFailed')
  packageinstallationfailed('PackageInstallationFailed'),
  @JsonValue('PackageInstallationCompleted')
  packageinstallationcompleted('PackageInstallationCompleted'),
  @JsonValue('PackageInstalling')
  packageinstalling('PackageInstalling'),
  @JsonValue('PackageUninstalled')
  packageuninstalled('PackageUninstalled'),
  @JsonValue('ActivityLogEntry')
  activitylogentry('ActivityLogEntry'),
  @JsonValue('ScheduledTasksInfo')
  scheduledtasksinfo('ScheduledTasksInfo'),
  @JsonValue('ActivityLogEntryStart')
  activitylogentrystart('ActivityLogEntryStart'),
  @JsonValue('ActivityLogEntryStop')
  activitylogentrystop('ActivityLogEntryStop'),
  @JsonValue('SessionsStart')
  sessionsstart('SessionsStart'),
  @JsonValue('SessionsStop')
  sessionsstop('SessionsStop'),
  @JsonValue('ScheduledTasksInfoStart')
  scheduledtasksinfostart('ScheduledTasksInfoStart'),
  @JsonValue('ScheduledTasksInfoStop')
  scheduledtasksinfostop('ScheduledTasksInfoStop'),
  @JsonValue('KeepAlive')
  keepalive('KeepAlive');

  final String? value;

  const SessionMessageType(this.value);
}

enum SortOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Ascending')
  ascending('Ascending'),
  @JsonValue('Descending')
  descending('Descending');

  final String? value;

  const SortOrder(this.value);
}

enum SubtitleDeliveryMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const SubtitleDeliveryMethod(this.value);
}

enum SubtitlePlaybackMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Default')
  $default('Default'),
  @JsonValue('Always')
  always('Always'),
  @JsonValue('OnlyForced')
  onlyforced('OnlyForced'),
  @JsonValue('None')
  none('None'),
  @JsonValue('Smart')
  smart('Smart');

  final String? value;

  const SubtitlePlaybackMode(this.value);
}

enum SyncPlayUserAccessType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('CreateAndJoinGroups')
  createandjoingroups('CreateAndJoinGroups'),
  @JsonValue('JoinGroups')
  joingroups('JoinGroups'),
  @JsonValue('None')
  none('None');

  final String? value;

  const SyncPlayUserAccessType(this.value);
}

enum TaskCompletionStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Completed')
  completed('Completed'),
  @JsonValue('Failed')
  failed('Failed'),
  @JsonValue('Cancelled')
  cancelled('Cancelled'),
  @JsonValue('Aborted')
  aborted('Aborted');

  final String? value;

  const TaskCompletionStatus(this.value);
}

enum TaskState {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Idle')
  idle('Idle'),
  @JsonValue('Cancelling')
  cancelling('Cancelling'),
  @JsonValue('Running')
  running('Running');

  final String? value;

  const TaskState(this.value);
}

enum TonemappingAlgorithm {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('none')
  none('none'),
  @JsonValue('clip')
  clip('clip'),
  @JsonValue('linear')
  linear('linear'),
  @JsonValue('gamma')
  gamma('gamma'),
  @JsonValue('reinhard')
  reinhard('reinhard'),
  @JsonValue('hable')
  hable('hable'),
  @JsonValue('mobius')
  mobius('mobius'),
  @JsonValue('bt2390')
  bt2390('bt2390');

  final String? value;

  const TonemappingAlgorithm(this.value);
}

enum TonemappingMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('auto')
  auto('auto'),
  @JsonValue('max')
  max('max'),
  @JsonValue('rgb')
  rgb('rgb'),
  @JsonValue('lum')
  lum('lum'),
  @JsonValue('itp')
  itp('itp');

  final String? value;

  const TonemappingMode(this.value);
}

enum TonemappingRange {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('auto')
  auto('auto'),
  @JsonValue('tv')
  tv('tv'),
  @JsonValue('pc')
  pc('pc');

  final String? value;

  const TonemappingRange(this.value);
}

enum TranscodeReason {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ContainerNotSupported')
  containernotsupported('ContainerNotSupported'),
  @JsonValue('VideoCodecNotSupported')
  videocodecnotsupported('VideoCodecNotSupported'),
  @JsonValue('AudioCodecNotSupported')
  audiocodecnotsupported('AudioCodecNotSupported'),
  @JsonValue('SubtitleCodecNotSupported')
  subtitlecodecnotsupported('SubtitleCodecNotSupported'),
  @JsonValue('AudioIsExternal')
  audioisexternal('AudioIsExternal'),
  @JsonValue('SecondaryAudioNotSupported')
  secondaryaudionotsupported('SecondaryAudioNotSupported'),
  @JsonValue('VideoProfileNotSupported')
  videoprofilenotsupported('VideoProfileNotSupported'),
  @JsonValue('VideoLevelNotSupported')
  videolevelnotsupported('VideoLevelNotSupported'),
  @JsonValue('VideoResolutionNotSupported')
  videoresolutionnotsupported('VideoResolutionNotSupported'),
  @JsonValue('VideoBitDepthNotSupported')
  videobitdepthnotsupported('VideoBitDepthNotSupported'),
  @JsonValue('VideoFramerateNotSupported')
  videoframeratenotsupported('VideoFramerateNotSupported'),
  @JsonValue('RefFramesNotSupported')
  refframesnotsupported('RefFramesNotSupported'),
  @JsonValue('AnamorphicVideoNotSupported')
  anamorphicvideonotsupported('AnamorphicVideoNotSupported'),
  @JsonValue('InterlacedVideoNotSupported')
  interlacedvideonotsupported('InterlacedVideoNotSupported'),
  @JsonValue('AudioChannelsNotSupported')
  audiochannelsnotsupported('AudioChannelsNotSupported'),
  @JsonValue('AudioProfileNotSupported')
  audioprofilenotsupported('AudioProfileNotSupported'),
  @JsonValue('AudioSampleRateNotSupported')
  audiosampleratenotsupported('AudioSampleRateNotSupported'),
  @JsonValue('AudioBitDepthNotSupported')
  audiobitdepthnotsupported('AudioBitDepthNotSupported'),
  @JsonValue('ContainerBitrateExceedsLimit')
  containerbitrateexceedslimit('ContainerBitrateExceedsLimit'),
  @JsonValue('VideoBitrateNotSupported')
  videobitratenotsupported('VideoBitrateNotSupported'),
  @JsonValue('AudioBitrateNotSupported')
  audiobitratenotsupported('AudioBitrateNotSupported'),
  @JsonValue('UnknownVideoStreamInfo')
  unknownvideostreaminfo('UnknownVideoStreamInfo'),
  @JsonValue('UnknownAudioStreamInfo')
  unknownaudiostreaminfo('UnknownAudioStreamInfo'),
  @JsonValue('DirectPlayError')
  directplayerror('DirectPlayError'),
  @JsonValue('VideoRangeTypeNotSupported')
  videorangetypenotsupported('VideoRangeTypeNotSupported'),
  @JsonValue('VideoCodecTagNotSupported')
  videocodectagnotsupported('VideoCodecTagNotSupported');

  final String? value;

  const TranscodeReason(this.value);
}

enum TranscodeSeekInfo {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Auto')
  auto('Auto'),
  @JsonValue('Bytes')
  bytes('Bytes');

  final String? value;

  const TranscodeSeekInfo(this.value);
}

enum TranscodingInfoTranscodeReasons {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ContainerNotSupported')
  containernotsupported('ContainerNotSupported'),
  @JsonValue('VideoCodecNotSupported')
  videocodecnotsupported('VideoCodecNotSupported'),
  @JsonValue('AudioCodecNotSupported')
  audiocodecnotsupported('AudioCodecNotSupported'),
  @JsonValue('SubtitleCodecNotSupported')
  subtitlecodecnotsupported('SubtitleCodecNotSupported'),
  @JsonValue('AudioIsExternal')
  audioisexternal('AudioIsExternal'),
  @JsonValue('SecondaryAudioNotSupported')
  secondaryaudionotsupported('SecondaryAudioNotSupported'),
  @JsonValue('VideoProfileNotSupported')
  videoprofilenotsupported('VideoProfileNotSupported'),
  @JsonValue('VideoLevelNotSupported')
  videolevelnotsupported('VideoLevelNotSupported'),
  @JsonValue('VideoResolutionNotSupported')
  videoresolutionnotsupported('VideoResolutionNotSupported'),
  @JsonValue('VideoBitDepthNotSupported')
  videobitdepthnotsupported('VideoBitDepthNotSupported'),
  @JsonValue('VideoFramerateNotSupported')
  videoframeratenotsupported('VideoFramerateNotSupported'),
  @JsonValue('RefFramesNotSupported')
  refframesnotsupported('RefFramesNotSupported'),
  @JsonValue('AnamorphicVideoNotSupported')
  anamorphicvideonotsupported('AnamorphicVideoNotSupported'),
  @JsonValue('InterlacedVideoNotSupported')
  interlacedvideonotsupported('InterlacedVideoNotSupported'),
  @JsonValue('AudioChannelsNotSupported')
  audiochannelsnotsupported('AudioChannelsNotSupported'),
  @JsonValue('AudioProfileNotSupported')
  audioprofilenotsupported('AudioProfileNotSupported'),
  @JsonValue('AudioSampleRateNotSupported')
  audiosampleratenotsupported('AudioSampleRateNotSupported'),
  @JsonValue('AudioBitDepthNotSupported')
  audiobitdepthnotsupported('AudioBitDepthNotSupported'),
  @JsonValue('ContainerBitrateExceedsLimit')
  containerbitrateexceedslimit('ContainerBitrateExceedsLimit'),
  @JsonValue('VideoBitrateNotSupported')
  videobitratenotsupported('VideoBitrateNotSupported'),
  @JsonValue('AudioBitrateNotSupported')
  audiobitratenotsupported('AudioBitrateNotSupported'),
  @JsonValue('UnknownVideoStreamInfo')
  unknownvideostreaminfo('UnknownVideoStreamInfo'),
  @JsonValue('UnknownAudioStreamInfo')
  unknownaudiostreaminfo('UnknownAudioStreamInfo'),
  @JsonValue('DirectPlayError')
  directplayerror('DirectPlayError'),
  @JsonValue('VideoRangeTypeNotSupported')
  videorangetypenotsupported('VideoRangeTypeNotSupported'),
  @JsonValue('VideoCodecTagNotSupported')
  videocodectagnotsupported('VideoCodecTagNotSupported');

  final String? value;

  const TranscodingInfoTranscodeReasons(this.value);
}

enum TransportStreamTimestamp {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('Zero')
  zero('Zero'),
  @JsonValue('Valid')
  valid('Valid');

  final String? value;

  const TransportStreamTimestamp(this.value);
}

enum TrickplayScanBehavior {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Blocking')
  blocking('Blocking'),
  @JsonValue('NonBlocking')
  nonblocking('NonBlocking');

  final String? value;

  const TrickplayScanBehavior(this.value);
}

enum UnratedItem {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Movie')
  movie('Movie'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('Series')
  series('Series'),
  @JsonValue('Music')
  music('Music'),
  @JsonValue('Book')
  book('Book'),
  @JsonValue('LiveTvChannel')
  livetvchannel('LiveTvChannel'),
  @JsonValue('LiveTvProgram')
  livetvprogram('LiveTvProgram'),
  @JsonValue('ChannelContent')
  channelcontent('ChannelContent'),
  @JsonValue('Other')
  other('Other');

  final String? value;

  const UnratedItem(this.value);
}

enum Video3DFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HalfSideBySide')
  halfsidebyside('HalfSideBySide'),
  @JsonValue('FullSideBySide')
  fullsidebyside('FullSideBySide'),
  @JsonValue('FullTopAndBottom')
  fulltopandbottom('FullTopAndBottom'),
  @JsonValue('HalfTopAndBottom')
  halftopandbottom('HalfTopAndBottom'),
  @JsonValue('MVC')
  mvc('MVC');

  final String? value;

  const Video3DFormat(this.value);
}

enum VideoRange {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('SDR')
  sdr('SDR'),
  @JsonValue('HDR')
  hdr('HDR');

  final String? value;

  const VideoRange(this.value);
}

enum VideoRangeType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('SDR')
  sdr('SDR'),
  @JsonValue('HDR10')
  hdr10('HDR10'),
  @JsonValue('HLG')
  hlg('HLG'),
  @JsonValue('DOVI')
  dovi('DOVI'),
  @JsonValue('DOVIWithHDR10')
  doviwithhdr10('DOVIWithHDR10'),
  @JsonValue('DOVIWithHLG')
  doviwithhlg('DOVIWithHLG'),
  @JsonValue('DOVIWithSDR')
  doviwithsdr('DOVIWithSDR'),
  @JsonValue('HDR10Plus')
  hdr10plus('HDR10Plus');

  final String? value;

  const VideoRangeType(this.value);
}

enum VideoType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VideoFile')
  videofile('VideoFile'),
  @JsonValue('Iso')
  iso('Iso'),
  @JsonValue('Dvd')
  dvd('Dvd'),
  @JsonValue('BluRay')
  bluray('BluRay');

  final String? value;

  const VideoType(this.value);
}

enum AudioItemIdStreamGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdStreamGetSubtitleMethod(this.value);
}

enum AudioItemIdStreamGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdStreamGetContext(this.value);
}

enum AudioItemIdStreamHeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdStreamHeadSubtitleMethod(this.value);
}

enum AudioItemIdStreamHeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdStreamHeadContext(this.value);
}

enum AudioItemIdStreamContainerGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdStreamContainerGetSubtitleMethod(this.value);
}

enum AudioItemIdStreamContainerGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdStreamContainerGetContext(this.value);
}

enum AudioItemIdStreamContainerHeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdStreamContainerHeadSubtitleMethod(this.value);
}

enum AudioItemIdStreamContainerHeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdStreamContainerHeadContext(this.value);
}

enum AudioItemIdHls1PlaylistIdSegmentIdContainerGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdHls1PlaylistIdSegmentIdContainerGetSubtitleMethod(
      this.value);
}

enum AudioItemIdHls1PlaylistIdSegmentIdContainerGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdHls1PlaylistIdSegmentIdContainerGetContext(this.value);
}

enum AudioItemIdMainM3u8GetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdMainM3u8GetSubtitleMethod(this.value);
}

enum AudioItemIdMainM3u8GetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdMainM3u8GetContext(this.value);
}

enum AudioItemIdMasterM3u8GetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdMasterM3u8GetSubtitleMethod(this.value);
}

enum AudioItemIdMasterM3u8GetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdMasterM3u8GetContext(this.value);
}

enum AudioItemIdMasterM3u8HeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const AudioItemIdMasterM3u8HeadSubtitleMethod(this.value);
}

enum AudioItemIdMasterM3u8HeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const AudioItemIdMasterM3u8HeadContext(this.value);
}

enum VideosItemIdHls1PlaylistIdSegmentIdContainerGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdHls1PlaylistIdSegmentIdContainerGetSubtitleMethod(
      this.value);
}

enum VideosItemIdHls1PlaylistIdSegmentIdContainerGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdHls1PlaylistIdSegmentIdContainerGetContext(this.value);
}

enum VideosItemIdLiveM3u8GetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdLiveM3u8GetSubtitleMethod(this.value);
}

enum VideosItemIdLiveM3u8GetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdLiveM3u8GetContext(this.value);
}

enum VideosItemIdMainM3u8GetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdMainM3u8GetSubtitleMethod(this.value);
}

enum VideosItemIdMainM3u8GetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdMainM3u8GetContext(this.value);
}

enum VideosItemIdMasterM3u8GetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdMasterM3u8GetSubtitleMethod(this.value);
}

enum VideosItemIdMasterM3u8GetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdMasterM3u8GetContext(this.value);
}

enum VideosItemIdMasterM3u8HeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdMasterM3u8HeadSubtitleMethod(this.value);
}

enum VideosItemIdMasterM3u8HeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdMasterM3u8HeadContext(this.value);
}

enum ArtistsNameImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ArtistsNameImagesImageTypeImageIndexGetImageType(this.value);
}

enum ArtistsNameImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ArtistsNameImagesImageTypeImageIndexGetFormat(this.value);
}

enum ArtistsNameImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ArtistsNameImagesImageTypeImageIndexHeadImageType(this.value);
}

enum ArtistsNameImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ArtistsNameImagesImageTypeImageIndexHeadFormat(this.value);
}

enum BrandingSplashscreenGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const BrandingSplashscreenGetFormat(this.value);
}

enum GenresNameImagesImageTypeGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const GenresNameImagesImageTypeGetImageType(this.value);
}

enum GenresNameImagesImageTypeGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const GenresNameImagesImageTypeGetFormat(this.value);
}

enum GenresNameImagesImageTypeHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const GenresNameImagesImageTypeHeadImageType(this.value);
}

enum GenresNameImagesImageTypeHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const GenresNameImagesImageTypeHeadFormat(this.value);
}

enum GenresNameImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const GenresNameImagesImageTypeImageIndexGetImageType(this.value);
}

enum GenresNameImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const GenresNameImagesImageTypeImageIndexGetFormat(this.value);
}

enum GenresNameImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const GenresNameImagesImageTypeImageIndexHeadImageType(this.value);
}

enum GenresNameImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const GenresNameImagesImageTypeImageIndexHeadFormat(this.value);
}

enum ItemsItemIdImagesImageTypeDeleteImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeDeleteImageType(this.value);
}

enum ItemsItemIdImagesImageTypePostImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypePostImageType(this.value);
}

enum ItemsItemIdImagesImageTypeGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeGetImageType(this.value);
}

enum ItemsItemIdImagesImageTypeGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeGetFormat(this.value);
}

enum ItemsItemIdImagesImageTypeHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeHeadImageType(this.value);
}

enum ItemsItemIdImagesImageTypeHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeHeadFormat(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexDeleteImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexDeleteImageType(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexPostImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexPostImageType(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexGetImageType(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexGetFormat(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexHeadImageType(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexHeadFormat(this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountGetImageType(
      this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountGetFormat(
      this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountHeadImageType(
      this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountHeadFormat(
      this.value);
}

enum ItemsItemIdImagesImageTypeImageIndexIndexPostImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdImagesImageTypeImageIndexIndexPostImageType(this.value);
}

enum MusicGenresNameImagesImageTypeGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const MusicGenresNameImagesImageTypeGetImageType(this.value);
}

enum MusicGenresNameImagesImageTypeGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const MusicGenresNameImagesImageTypeGetFormat(this.value);
}

enum MusicGenresNameImagesImageTypeHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const MusicGenresNameImagesImageTypeHeadImageType(this.value);
}

enum MusicGenresNameImagesImageTypeHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const MusicGenresNameImagesImageTypeHeadFormat(this.value);
}

enum MusicGenresNameImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const MusicGenresNameImagesImageTypeImageIndexGetImageType(this.value);
}

enum MusicGenresNameImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const MusicGenresNameImagesImageTypeImageIndexGetFormat(this.value);
}

enum MusicGenresNameImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const MusicGenresNameImagesImageTypeImageIndexHeadImageType(this.value);
}

enum MusicGenresNameImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const MusicGenresNameImagesImageTypeImageIndexHeadFormat(this.value);
}

enum PersonsNameImagesImageTypeGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const PersonsNameImagesImageTypeGetImageType(this.value);
}

enum PersonsNameImagesImageTypeGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const PersonsNameImagesImageTypeGetFormat(this.value);
}

enum PersonsNameImagesImageTypeHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const PersonsNameImagesImageTypeHeadImageType(this.value);
}

enum PersonsNameImagesImageTypeHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const PersonsNameImagesImageTypeHeadFormat(this.value);
}

enum PersonsNameImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const PersonsNameImagesImageTypeImageIndexGetImageType(this.value);
}

enum PersonsNameImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const PersonsNameImagesImageTypeImageIndexGetFormat(this.value);
}

enum PersonsNameImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const PersonsNameImagesImageTypeImageIndexHeadImageType(this.value);
}

enum PersonsNameImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const PersonsNameImagesImageTypeImageIndexHeadFormat(this.value);
}

enum StudiosNameImagesImageTypeGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const StudiosNameImagesImageTypeGetImageType(this.value);
}

enum StudiosNameImagesImageTypeGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const StudiosNameImagesImageTypeGetFormat(this.value);
}

enum StudiosNameImagesImageTypeHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const StudiosNameImagesImageTypeHeadImageType(this.value);
}

enum StudiosNameImagesImageTypeHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const StudiosNameImagesImageTypeHeadFormat(this.value);
}

enum StudiosNameImagesImageTypeImageIndexGetImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const StudiosNameImagesImageTypeImageIndexGetImageType(this.value);
}

enum StudiosNameImagesImageTypeImageIndexGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const StudiosNameImagesImageTypeImageIndexGetFormat(this.value);
}

enum StudiosNameImagesImageTypeImageIndexHeadImageType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const StudiosNameImagesImageTypeImageIndexHeadImageType(this.value);
}

enum StudiosNameImagesImageTypeImageIndexHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const StudiosNameImagesImageTypeImageIndexHeadFormat(this.value);
}

enum UserImageGetFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const UserImageGetFormat(this.value);
}

enum UserImageHeadFormat {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Bmp')
  bmp('Bmp'),
  @JsonValue('Gif')
  gif('Gif'),
  @JsonValue('Jpg')
  jpg('Jpg'),
  @JsonValue('Png')
  png('Png'),
  @JsonValue('Webp')
  webp('Webp'),
  @JsonValue('Svg')
  svg('Svg');

  final String? value;

  const UserImageHeadFormat(this.value);
}

enum ItemsItemIdRefreshPostMetadataRefreshMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('ValidationOnly')
  validationonly('ValidationOnly'),
  @JsonValue('Default')
  $default('Default'),
  @JsonValue('FullRefresh')
  fullrefresh('FullRefresh');

  final String? value;

  const ItemsItemIdRefreshPostMetadataRefreshMode(this.value);
}

enum ItemsItemIdRefreshPostImageRefreshMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('ValidationOnly')
  validationonly('ValidationOnly'),
  @JsonValue('Default')
  $default('Default'),
  @JsonValue('FullRefresh')
  fullrefresh('FullRefresh');

  final String? value;

  const ItemsItemIdRefreshPostImageRefreshMode(this.value);
}

enum LibrariesAvailableOptionsGetLibraryContentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('unknown')
  unknown('unknown'),
  @JsonValue('movies')
  movies('movies'),
  @JsonValue('tvshows')
  tvshows('tvshows'),
  @JsonValue('music')
  music('music'),
  @JsonValue('musicvideos')
  musicvideos('musicvideos'),
  @JsonValue('trailers')
  trailers('trailers'),
  @JsonValue('homevideos')
  homevideos('homevideos'),
  @JsonValue('boxsets')
  boxsets('boxsets'),
  @JsonValue('books')
  books('books'),
  @JsonValue('photos')
  photos('photos'),
  @JsonValue('livetv')
  livetv('livetv'),
  @JsonValue('playlists')
  playlists('playlists'),
  @JsonValue('folders')
  folders('folders');

  final String? value;

  const LibrariesAvailableOptionsGetLibraryContentType(this.value);
}

enum LibraryVirtualFoldersPostCollectionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('movies')
  movies('movies'),
  @JsonValue('tvshows')
  tvshows('tvshows'),
  @JsonValue('music')
  music('music'),
  @JsonValue('musicvideos')
  musicvideos('musicvideos'),
  @JsonValue('homevideos')
  homevideos('homevideos'),
  @JsonValue('boxsets')
  boxsets('boxsets'),
  @JsonValue('books')
  books('books'),
  @JsonValue('mixed')
  mixed('mixed');

  final String? value;

  const LibraryVirtualFoldersPostCollectionType(this.value);
}

enum LiveTvChannelsGetType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TV')
  tv('TV'),
  @JsonValue('Radio')
  radio('Radio');

  final String? value;

  const LiveTvChannelsGetType(this.value);
}

enum LiveTvChannelsGetSortOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Ascending')
  ascending('Ascending'),
  @JsonValue('Descending')
  descending('Descending');

  final String? value;

  const LiveTvChannelsGetSortOrder(this.value);
}

enum LiveTvRecordingsGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('New')
  $new('New'),
  @JsonValue('InProgress')
  inprogress('InProgress'),
  @JsonValue('Completed')
  completed('Completed'),
  @JsonValue('Cancelled')
  cancelled('Cancelled'),
  @JsonValue('ConflictedOk')
  conflictedok('ConflictedOk'),
  @JsonValue('ConflictedNotOk')
  conflictednotok('ConflictedNotOk'),
  @JsonValue('Error')
  error('Error');

  final String? value;

  const LiveTvRecordingsGetStatus(this.value);
}

enum LiveTvRecordingsSeriesGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('New')
  $new('New'),
  @JsonValue('InProgress')
  inprogress('InProgress'),
  @JsonValue('Completed')
  completed('Completed'),
  @JsonValue('Cancelled')
  cancelled('Cancelled'),
  @JsonValue('ConflictedOk')
  conflictedok('ConflictedOk'),
  @JsonValue('ConflictedNotOk')
  conflictednotok('ConflictedNotOk'),
  @JsonValue('Error')
  error('Error');

  final String? value;

  const LiveTvRecordingsSeriesGetStatus(this.value);
}

enum LiveTvSeriesTimersGetSortOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Ascending')
  ascending('Ascending'),
  @JsonValue('Descending')
  descending('Descending');

  final String? value;

  const LiveTvSeriesTimersGetSortOrder(this.value);
}

enum PlaylistsPostMediaType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unknown')
  unknown('Unknown'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('Photo')
  photo('Photo'),
  @JsonValue('Book')
  book('Book');

  final String? value;

  const PlaylistsPostMediaType(this.value);
}

enum PlayingItemsItemIdPostPlayMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Transcode')
  transcode('Transcode'),
  @JsonValue('DirectStream')
  directstream('DirectStream'),
  @JsonValue('DirectPlay')
  directplay('DirectPlay');

  final String? value;

  const PlayingItemsItemIdPostPlayMethod(this.value);
}

enum PlayingItemsItemIdProgressPostPlayMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Transcode')
  transcode('Transcode'),
  @JsonValue('DirectStream')
  directstream('DirectStream'),
  @JsonValue('DirectPlay')
  directplay('DirectPlay');

  final String? value;

  const PlayingItemsItemIdProgressPostPlayMethod(this.value);
}

enum PlayingItemsItemIdProgressPostRepeatMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('RepeatNone')
  repeatnone('RepeatNone'),
  @JsonValue('RepeatAll')
  repeatall('RepeatAll'),
  @JsonValue('RepeatOne')
  repeatone('RepeatOne');

  final String? value;

  const PlayingItemsItemIdProgressPostRepeatMode(this.value);
}

enum ItemsItemIdRemoteImagesGetType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdRemoteImagesGetType(this.value);
}

enum ItemsItemIdRemoteImagesDownloadPostType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Primary')
  primary('Primary'),
  @JsonValue('Art')
  art('Art'),
  @JsonValue('Backdrop')
  backdrop('Backdrop'),
  @JsonValue('Banner')
  banner('Banner'),
  @JsonValue('Logo')
  logo('Logo'),
  @JsonValue('Thumb')
  thumb('Thumb'),
  @JsonValue('Disc')
  disc('Disc'),
  @JsonValue('Box')
  box('Box'),
  @JsonValue('Screenshot')
  screenshot('Screenshot'),
  @JsonValue('Menu')
  menu('Menu'),
  @JsonValue('Chapter')
  chapter('Chapter'),
  @JsonValue('BoxRear')
  boxrear('BoxRear'),
  @JsonValue('Profile')
  profile('Profile');

  final String? value;

  const ItemsItemIdRemoteImagesDownloadPostType(this.value);
}

enum SessionsSessionIdCommandCommandPostCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MoveUp')
  moveup('MoveUp'),
  @JsonValue('MoveDown')
  movedown('MoveDown'),
  @JsonValue('MoveLeft')
  moveleft('MoveLeft'),
  @JsonValue('MoveRight')
  moveright('MoveRight'),
  @JsonValue('PageUp')
  pageup('PageUp'),
  @JsonValue('PageDown')
  pagedown('PageDown'),
  @JsonValue('PreviousLetter')
  previousletter('PreviousLetter'),
  @JsonValue('NextLetter')
  nextletter('NextLetter'),
  @JsonValue('ToggleOsd')
  toggleosd('ToggleOsd'),
  @JsonValue('ToggleContextMenu')
  togglecontextmenu('ToggleContextMenu'),
  @JsonValue('Select')
  select('Select'),
  @JsonValue('Back')
  back('Back'),
  @JsonValue('TakeScreenshot')
  takescreenshot('TakeScreenshot'),
  @JsonValue('SendKey')
  sendkey('SendKey'),
  @JsonValue('SendString')
  sendstring('SendString'),
  @JsonValue('GoHome')
  gohome('GoHome'),
  @JsonValue('GoToSettings')
  gotosettings('GoToSettings'),
  @JsonValue('VolumeUp')
  volumeup('VolumeUp'),
  @JsonValue('VolumeDown')
  volumedown('VolumeDown'),
  @JsonValue('Mute')
  mute('Mute'),
  @JsonValue('Unmute')
  unmute('Unmute'),
  @JsonValue('ToggleMute')
  togglemute('ToggleMute'),
  @JsonValue('SetVolume')
  setvolume('SetVolume'),
  @JsonValue('SetAudioStreamIndex')
  setaudiostreamindex('SetAudioStreamIndex'),
  @JsonValue('SetSubtitleStreamIndex')
  setsubtitlestreamindex('SetSubtitleStreamIndex'),
  @JsonValue('ToggleFullscreen')
  togglefullscreen('ToggleFullscreen'),
  @JsonValue('DisplayContent')
  displaycontent('DisplayContent'),
  @JsonValue('GoToSearch')
  gotosearch('GoToSearch'),
  @JsonValue('DisplayMessage')
  displaymessage('DisplayMessage'),
  @JsonValue('SetRepeatMode')
  setrepeatmode('SetRepeatMode'),
  @JsonValue('ChannelUp')
  channelup('ChannelUp'),
  @JsonValue('ChannelDown')
  channeldown('ChannelDown'),
  @JsonValue('Guide')
  guide('Guide'),
  @JsonValue('ToggleStats')
  togglestats('ToggleStats'),
  @JsonValue('PlayMediaSource')
  playmediasource('PlayMediaSource'),
  @JsonValue('PlayTrailers')
  playtrailers('PlayTrailers'),
  @JsonValue('SetShuffleQueue')
  setshufflequeue('SetShuffleQueue'),
  @JsonValue('PlayState')
  playstate('PlayState'),
  @JsonValue('PlayNext')
  playnext('PlayNext'),
  @JsonValue('ToggleOsdMenu')
  toggleosdmenu('ToggleOsdMenu'),
  @JsonValue('Play')
  play('Play'),
  @JsonValue('SetMaxStreamingBitrate')
  setmaxstreamingbitrate('SetMaxStreamingBitrate'),
  @JsonValue('SetPlaybackOrder')
  setplaybackorder('SetPlaybackOrder');

  final String? value;

  const SessionsSessionIdCommandCommandPostCommand(this.value);
}

enum SessionsSessionIdPlayingPostPlayCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PlayNow')
  playnow('PlayNow'),
  @JsonValue('PlayNext')
  playnext('PlayNext'),
  @JsonValue('PlayLast')
  playlast('PlayLast'),
  @JsonValue('PlayInstantMix')
  playinstantmix('PlayInstantMix'),
  @JsonValue('PlayShuffle')
  playshuffle('PlayShuffle');

  final String? value;

  const SessionsSessionIdPlayingPostPlayCommand(this.value);
}

enum SessionsSessionIdPlayingCommandPostCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Stop')
  stop('Stop'),
  @JsonValue('Pause')
  pause('Pause'),
  @JsonValue('Unpause')
  unpause('Unpause'),
  @JsonValue('NextTrack')
  nexttrack('NextTrack'),
  @JsonValue('PreviousTrack')
  previoustrack('PreviousTrack'),
  @JsonValue('Seek')
  seek('Seek'),
  @JsonValue('Rewind')
  rewind('Rewind'),
  @JsonValue('FastForward')
  fastforward('FastForward'),
  @JsonValue('PlayPause')
  playpause('PlayPause');

  final String? value;

  const SessionsSessionIdPlayingCommandPostCommand(this.value);
}

enum SessionsSessionIdSystemCommandPostCommand {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MoveUp')
  moveup('MoveUp'),
  @JsonValue('MoveDown')
  movedown('MoveDown'),
  @JsonValue('MoveLeft')
  moveleft('MoveLeft'),
  @JsonValue('MoveRight')
  moveright('MoveRight'),
  @JsonValue('PageUp')
  pageup('PageUp'),
  @JsonValue('PageDown')
  pagedown('PageDown'),
  @JsonValue('PreviousLetter')
  previousletter('PreviousLetter'),
  @JsonValue('NextLetter')
  nextletter('NextLetter'),
  @JsonValue('ToggleOsd')
  toggleosd('ToggleOsd'),
  @JsonValue('ToggleContextMenu')
  togglecontextmenu('ToggleContextMenu'),
  @JsonValue('Select')
  select('Select'),
  @JsonValue('Back')
  back('Back'),
  @JsonValue('TakeScreenshot')
  takescreenshot('TakeScreenshot'),
  @JsonValue('SendKey')
  sendkey('SendKey'),
  @JsonValue('SendString')
  sendstring('SendString'),
  @JsonValue('GoHome')
  gohome('GoHome'),
  @JsonValue('GoToSettings')
  gotosettings('GoToSettings'),
  @JsonValue('VolumeUp')
  volumeup('VolumeUp'),
  @JsonValue('VolumeDown')
  volumedown('VolumeDown'),
  @JsonValue('Mute')
  mute('Mute'),
  @JsonValue('Unmute')
  unmute('Unmute'),
  @JsonValue('ToggleMute')
  togglemute('ToggleMute'),
  @JsonValue('SetVolume')
  setvolume('SetVolume'),
  @JsonValue('SetAudioStreamIndex')
  setaudiostreamindex('SetAudioStreamIndex'),
  @JsonValue('SetSubtitleStreamIndex')
  setsubtitlestreamindex('SetSubtitleStreamIndex'),
  @JsonValue('ToggleFullscreen')
  togglefullscreen('ToggleFullscreen'),
  @JsonValue('DisplayContent')
  displaycontent('DisplayContent'),
  @JsonValue('GoToSearch')
  gotosearch('GoToSearch'),
  @JsonValue('DisplayMessage')
  displaymessage('DisplayMessage'),
  @JsonValue('SetRepeatMode')
  setrepeatmode('SetRepeatMode'),
  @JsonValue('ChannelUp')
  channelup('ChannelUp'),
  @JsonValue('ChannelDown')
  channeldown('ChannelDown'),
  @JsonValue('Guide')
  guide('Guide'),
  @JsonValue('ToggleStats')
  togglestats('ToggleStats'),
  @JsonValue('PlayMediaSource')
  playmediasource('PlayMediaSource'),
  @JsonValue('PlayTrailers')
  playtrailers('PlayTrailers'),
  @JsonValue('SetShuffleQueue')
  setshufflequeue('SetShuffleQueue'),
  @JsonValue('PlayState')
  playstate('PlayState'),
  @JsonValue('PlayNext')
  playnext('PlayNext'),
  @JsonValue('ToggleOsdMenu')
  toggleosdmenu('ToggleOsdMenu'),
  @JsonValue('Play')
  play('Play'),
  @JsonValue('SetMaxStreamingBitrate')
  setmaxstreamingbitrate('SetMaxStreamingBitrate'),
  @JsonValue('SetPlaybackOrder')
  setplaybackorder('SetPlaybackOrder');

  final String? value;

  const SessionsSessionIdSystemCommandPostCommand(this.value);
}

enum SessionsSessionIdViewingPostItemType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('AggregateFolder')
  aggregatefolder('AggregateFolder'),
  @JsonValue('Audio')
  audio('Audio'),
  @JsonValue('AudioBook')
  audiobook('AudioBook'),
  @JsonValue('BasePluginFolder')
  basepluginfolder('BasePluginFolder'),
  @JsonValue('Book')
  book('Book'),
  @JsonValue('BoxSet')
  boxset('BoxSet'),
  @JsonValue('Channel')
  channel('Channel'),
  @JsonValue('ChannelFolderItem')
  channelfolderitem('ChannelFolderItem'),
  @JsonValue('CollectionFolder')
  collectionfolder('CollectionFolder'),
  @JsonValue('Episode')
  episode('Episode'),
  @JsonValue('Folder')
  folder('Folder'),
  @JsonValue('Genre')
  genre('Genre'),
  @JsonValue('ManualPlaylistsFolder')
  manualplaylistsfolder('ManualPlaylistsFolder'),
  @JsonValue('Movie')
  movie('Movie'),
  @JsonValue('LiveTvChannel')
  livetvchannel('LiveTvChannel'),
  @JsonValue('LiveTvProgram')
  livetvprogram('LiveTvProgram'),
  @JsonValue('MusicAlbum')
  musicalbum('MusicAlbum'),
  @JsonValue('MusicArtist')
  musicartist('MusicArtist'),
  @JsonValue('MusicGenre')
  musicgenre('MusicGenre'),
  @JsonValue('MusicVideo')
  musicvideo('MusicVideo'),
  @JsonValue('Person')
  person('Person'),
  @JsonValue('Photo')
  photo('Photo'),
  @JsonValue('PhotoAlbum')
  photoalbum('PhotoAlbum'),
  @JsonValue('Playlist')
  playlist('Playlist'),
  @JsonValue('PlaylistsFolder')
  playlistsfolder('PlaylistsFolder'),
  @JsonValue('Program')
  program('Program'),
  @JsonValue('Recording')
  recording('Recording'),
  @JsonValue('Season')
  season('Season'),
  @JsonValue('Series')
  series('Series'),
  @JsonValue('Studio')
  studio('Studio'),
  @JsonValue('Trailer')
  trailer('Trailer'),
  @JsonValue('TvChannel')
  tvchannel('TvChannel'),
  @JsonValue('TvProgram')
  tvprogram('TvProgram'),
  @JsonValue('UserRootFolder')
  userrootfolder('UserRootFolder'),
  @JsonValue('UserView')
  userview('UserView'),
  @JsonValue('Video')
  video('Video'),
  @JsonValue('Year')
  year('Year');

  final String? value;

  const SessionsSessionIdViewingPostItemType(this.value);
}

enum ShowsSeriesIdEpisodesGetSortBy {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Default')
  $default('Default'),
  @JsonValue('AiredEpisodeOrder')
  airedepisodeorder('AiredEpisodeOrder'),
  @JsonValue('Album')
  album('Album'),
  @JsonValue('AlbumArtist')
  albumartist('AlbumArtist'),
  @JsonValue('Artist')
  artist('Artist'),
  @JsonValue('DateCreated')
  datecreated('DateCreated'),
  @JsonValue('OfficialRating')
  officialrating('OfficialRating'),
  @JsonValue('DatePlayed')
  dateplayed('DatePlayed'),
  @JsonValue('PremiereDate')
  premieredate('PremiereDate'),
  @JsonValue('StartDate')
  startdate('StartDate'),
  @JsonValue('SortName')
  sortname('SortName'),
  @JsonValue('Name')
  name('Name'),
  @JsonValue('Random')
  random('Random'),
  @JsonValue('Runtime')
  runtime('Runtime'),
  @JsonValue('CommunityRating')
  communityrating('CommunityRating'),
  @JsonValue('ProductionYear')
  productionyear('ProductionYear'),
  @JsonValue('PlayCount')
  playcount('PlayCount'),
  @JsonValue('CriticRating')
  criticrating('CriticRating'),
  @JsonValue('IsFolder')
  isfolder('IsFolder'),
  @JsonValue('IsUnplayed')
  isunplayed('IsUnplayed'),
  @JsonValue('IsPlayed')
  isplayed('IsPlayed'),
  @JsonValue('SeriesSortName')
  seriessortname('SeriesSortName'),
  @JsonValue('VideoBitRate')
  videobitrate('VideoBitRate'),
  @JsonValue('AirTime')
  airtime('AirTime'),
  @JsonValue('Studio')
  studio('Studio'),
  @JsonValue('IsFavoriteOrLiked')
  isfavoriteorliked('IsFavoriteOrLiked'),
  @JsonValue('DateLastContentAdded')
  datelastcontentadded('DateLastContentAdded'),
  @JsonValue('SeriesDatePlayed')
  seriesdateplayed('SeriesDatePlayed'),
  @JsonValue('ParentIndexNumber')
  parentindexnumber('ParentIndexNumber'),
  @JsonValue('IndexNumber')
  indexnumber('IndexNumber'),
  @JsonValue('SimilarityScore')
  similarityscore('SimilarityScore'),
  @JsonValue('SearchScore')
  searchscore('SearchScore');

  final String? value;

  const ShowsSeriesIdEpisodesGetSortBy(this.value);
}

enum AudioItemIdUniversalGetTranscodingProtocol {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('http')
  http('http'),
  @JsonValue('hls')
  hls('hls');

  final String? value;

  const AudioItemIdUniversalGetTranscodingProtocol(this.value);
}

enum AudioItemIdUniversalHeadTranscodingProtocol {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('http')
  http('http'),
  @JsonValue('hls')
  hls('hls');

  final String? value;

  const AudioItemIdUniversalHeadTranscodingProtocol(this.value);
}

enum VideosItemIdStreamGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdStreamGetSubtitleMethod(this.value);
}

enum VideosItemIdStreamGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdStreamGetContext(this.value);
}

enum VideosItemIdStreamHeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdStreamHeadSubtitleMethod(this.value);
}

enum VideosItemIdStreamHeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdStreamHeadContext(this.value);
}

enum VideosItemIdStreamContainerGetSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdStreamContainerGetSubtitleMethod(this.value);
}

enum VideosItemIdStreamContainerGetContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdStreamContainerGetContext(this.value);
}

enum VideosItemIdStreamContainerHeadSubtitleMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Encode')
  encode('Encode'),
  @JsonValue('Embed')
  embed('Embed'),
  @JsonValue('External')
  $external('External'),
  @JsonValue('Hls')
  hls('Hls'),
  @JsonValue('Drop')
  drop('Drop');

  final String? value;

  const VideosItemIdStreamContainerHeadSubtitleMethod(this.value);
}

enum VideosItemIdStreamContainerHeadContext {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Streaming')
  streaming('Streaming'),
  @JsonValue('Static')
  $static('Static');

  final String? value;

  const VideosItemIdStreamContainerHeadContext(this.value);
}
