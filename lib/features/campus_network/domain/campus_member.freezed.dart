// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PortfolioProject {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get techStack => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioProjectCopyWith<PortfolioProject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioProjectCopyWith<$Res> {
  factory $PortfolioProjectCopyWith(
    PortfolioProject value,
    $Res Function(PortfolioProject) then,
  ) = _$PortfolioProjectCopyWithImpl<$Res, PortfolioProject>;
  @useResult
  $Res call({
    String title,
    String description,
    List<String> techStack,
    String? link,
  });
}

/// @nodoc
class _$PortfolioProjectCopyWithImpl<$Res, $Val extends PortfolioProject>
    implements $PortfolioProjectCopyWith<$Res> {
  _$PortfolioProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? techStack = null,
    Object? link = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            techStack: null == techStack
                ? _value.techStack
                : techStack // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PortfolioProjectImplCopyWith<$Res>
    implements $PortfolioProjectCopyWith<$Res> {
  factory _$$PortfolioProjectImplCopyWith(
    _$PortfolioProjectImpl value,
    $Res Function(_$PortfolioProjectImpl) then,
  ) = __$$PortfolioProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String description,
    List<String> techStack,
    String? link,
  });
}

/// @nodoc
class __$$PortfolioProjectImplCopyWithImpl<$Res>
    extends _$PortfolioProjectCopyWithImpl<$Res, _$PortfolioProjectImpl>
    implements _$$PortfolioProjectImplCopyWith<$Res> {
  __$$PortfolioProjectImplCopyWithImpl(
    _$PortfolioProjectImpl _value,
    $Res Function(_$PortfolioProjectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PortfolioProject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? techStack = null,
    Object? link = freezed,
  }) {
    return _then(
      _$PortfolioProjectImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        techStack: null == techStack
            ? _value._techStack
            : techStack // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PortfolioProjectImpl implements _PortfolioProject {
  const _$PortfolioProjectImpl({
    required this.title,
    required this.description,
    required final List<String> techStack,
    this.link,
  }) : _techStack = techStack;

  @override
  final String title;
  @override
  final String description;
  final List<String> _techStack;
  @override
  List<String> get techStack {
    if (_techStack is EqualUnmodifiableListView) return _techStack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techStack);
  }

  @override
  final String? link;

  @override
  String toString() {
    return 'PortfolioProject(title: $title, description: $description, techStack: $techStack, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioProjectImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._techStack,
              _techStack,
            ) &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    const DeepCollectionEquality().hash(_techStack),
    link,
  );

  /// Create a copy of PortfolioProject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioProjectImplCopyWith<_$PortfolioProjectImpl> get copyWith =>
      __$$PortfolioProjectImplCopyWithImpl<_$PortfolioProjectImpl>(
        this,
        _$identity,
      );
}

abstract class _PortfolioProject implements PortfolioProject {
  const factory _PortfolioProject({
    required final String title,
    required final String description,
    required final List<String> techStack,
    final String? link,
  }) = _$PortfolioProjectImpl;

  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get techStack;
  @override
  String? get link;

  /// Create a copy of PortfolioProject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioProjectImplCopyWith<_$PortfolioProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CampusMember {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get faculty => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  List<String> get programmingLanguages => throw _privateConstructorUsedError;
  List<String> get certificates => throw _privateConstructorUsedError;
  List<PortfolioProject> get projects => throw _privateConstructorUsedError;
  int get volunteerHours => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get following => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  int get campusCoins => throw _privateConstructorUsedError;
  int get academicPoints => throw _privateConstructorUsedError;
  int get communityPoints => throw _privateConstructorUsedError;
  int get leadershipPoints => throw _privateConstructorUsedError;
  int get innovationPoints => throw _privateConstructorUsedError;
  String? get githubUrl => throw _privateConstructorUsedError;
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get portfolioUrl => throw _privateConstructorUsedError;

  /// Create a copy of CampusMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampusMemberCopyWith<CampusMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusMemberCopyWith<$Res> {
  factory $CampusMemberCopyWith(
    CampusMember value,
    $Res Function(CampusMember) then,
  ) = _$CampusMemberCopyWithImpl<$Res, CampusMember>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String faculty,
    String department,
    int level,
    List<String> skills,
    List<String> programmingLanguages,
    List<String> certificates,
    List<PortfolioProject> projects,
    int volunteerHours,
    int followers,
    int following,
    int xp,
    int campusCoins,
    int academicPoints,
    int communityPoints,
    int leadershipPoints,
    int innovationPoints,
    String? githubUrl,
    String? linkedinUrl,
    String? portfolioUrl,
  });
}

/// @nodoc
class _$CampusMemberCopyWithImpl<$Res, $Val extends CampusMember>
    implements $CampusMemberCopyWith<$Res> {
  _$CampusMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampusMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? faculty = null,
    Object? department = null,
    Object? level = null,
    Object? skills = null,
    Object? programmingLanguages = null,
    Object? certificates = null,
    Object? projects = null,
    Object? volunteerHours = null,
    Object? followers = null,
    Object? following = null,
    Object? xp = null,
    Object? campusCoins = null,
    Object? academicPoints = null,
    Object? communityPoints = null,
    Object? leadershipPoints = null,
    Object? innovationPoints = null,
    Object? githubUrl = freezed,
    Object? linkedinUrl = freezed,
    Object? portfolioUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            faculty: null == faculty
                ? _value.faculty
                : faculty // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            skills: null == skills
                ? _value.skills
                : skills // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            programmingLanguages: null == programmingLanguages
                ? _value.programmingLanguages
                : programmingLanguages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            certificates: null == certificates
                ? _value.certificates
                : certificates // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            projects: null == projects
                ? _value.projects
                : projects // ignore: cast_nullable_to_non_nullable
                      as List<PortfolioProject>,
            volunteerHours: null == volunteerHours
                ? _value.volunteerHours
                : volunteerHours // ignore: cast_nullable_to_non_nullable
                      as int,
            followers: null == followers
                ? _value.followers
                : followers // ignore: cast_nullable_to_non_nullable
                      as int,
            following: null == following
                ? _value.following
                : following // ignore: cast_nullable_to_non_nullable
                      as int,
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            campusCoins: null == campusCoins
                ? _value.campusCoins
                : campusCoins // ignore: cast_nullable_to_non_nullable
                      as int,
            academicPoints: null == academicPoints
                ? _value.academicPoints
                : academicPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            communityPoints: null == communityPoints
                ? _value.communityPoints
                : communityPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            leadershipPoints: null == leadershipPoints
                ? _value.leadershipPoints
                : leadershipPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            innovationPoints: null == innovationPoints
                ? _value.innovationPoints
                : innovationPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            githubUrl: freezed == githubUrl
                ? _value.githubUrl
                : githubUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            portfolioUrl: freezed == portfolioUrl
                ? _value.portfolioUrl
                : portfolioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampusMemberImplCopyWith<$Res>
    implements $CampusMemberCopyWith<$Res> {
  factory _$$CampusMemberImplCopyWith(
    _$CampusMemberImpl value,
    $Res Function(_$CampusMemberImpl) then,
  ) = __$$CampusMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String faculty,
    String department,
    int level,
    List<String> skills,
    List<String> programmingLanguages,
    List<String> certificates,
    List<PortfolioProject> projects,
    int volunteerHours,
    int followers,
    int following,
    int xp,
    int campusCoins,
    int academicPoints,
    int communityPoints,
    int leadershipPoints,
    int innovationPoints,
    String? githubUrl,
    String? linkedinUrl,
    String? portfolioUrl,
  });
}

/// @nodoc
class __$$CampusMemberImplCopyWithImpl<$Res>
    extends _$CampusMemberCopyWithImpl<$Res, _$CampusMemberImpl>
    implements _$$CampusMemberImplCopyWith<$Res> {
  __$$CampusMemberImplCopyWithImpl(
    _$CampusMemberImpl _value,
    $Res Function(_$CampusMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampusMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? faculty = null,
    Object? department = null,
    Object? level = null,
    Object? skills = null,
    Object? programmingLanguages = null,
    Object? certificates = null,
    Object? projects = null,
    Object? volunteerHours = null,
    Object? followers = null,
    Object? following = null,
    Object? xp = null,
    Object? campusCoins = null,
    Object? academicPoints = null,
    Object? communityPoints = null,
    Object? leadershipPoints = null,
    Object? innovationPoints = null,
    Object? githubUrl = freezed,
    Object? linkedinUrl = freezed,
    Object? portfolioUrl = freezed,
  }) {
    return _then(
      _$CampusMemberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        faculty: null == faculty
            ? _value.faculty
            : faculty // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        skills: null == skills
            ? _value._skills
            : skills // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        programmingLanguages: null == programmingLanguages
            ? _value._programmingLanguages
            : programmingLanguages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        certificates: null == certificates
            ? _value._certificates
            : certificates // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        projects: null == projects
            ? _value._projects
            : projects // ignore: cast_nullable_to_non_nullable
                  as List<PortfolioProject>,
        volunteerHours: null == volunteerHours
            ? _value.volunteerHours
            : volunteerHours // ignore: cast_nullable_to_non_nullable
                  as int,
        followers: null == followers
            ? _value.followers
            : followers // ignore: cast_nullable_to_non_nullable
                  as int,
        following: null == following
            ? _value.following
            : following // ignore: cast_nullable_to_non_nullable
                  as int,
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        campusCoins: null == campusCoins
            ? _value.campusCoins
            : campusCoins // ignore: cast_nullable_to_non_nullable
                  as int,
        academicPoints: null == academicPoints
            ? _value.academicPoints
            : academicPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        communityPoints: null == communityPoints
            ? _value.communityPoints
            : communityPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        leadershipPoints: null == leadershipPoints
            ? _value.leadershipPoints
            : leadershipPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        innovationPoints: null == innovationPoints
            ? _value.innovationPoints
            : innovationPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        githubUrl: freezed == githubUrl
            ? _value.githubUrl
            : githubUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        portfolioUrl: freezed == portfolioUrl
            ? _value.portfolioUrl
            : portfolioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CampusMemberImpl implements _CampusMember {
  const _$CampusMemberImpl({
    required this.id,
    required this.fullName,
    required this.faculty,
    required this.department,
    required this.level,
    required final List<String> skills,
    required final List<String> programmingLanguages,
    required final List<String> certificates,
    required final List<PortfolioProject> projects,
    required this.volunteerHours,
    required this.followers,
    required this.following,
    required this.xp,
    required this.campusCoins,
    required this.academicPoints,
    required this.communityPoints,
    required this.leadershipPoints,
    required this.innovationPoints,
    this.githubUrl,
    this.linkedinUrl,
    this.portfolioUrl,
  }) : _skills = skills,
       _programmingLanguages = programmingLanguages,
       _certificates = certificates,
       _projects = projects;

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String faculty;
  @override
  final String department;
  @override
  final int level;
  final List<String> _skills;
  @override
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<String> _programmingLanguages;
  @override
  List<String> get programmingLanguages {
    if (_programmingLanguages is EqualUnmodifiableListView)
      return _programmingLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programmingLanguages);
  }

  final List<String> _certificates;
  @override
  List<String> get certificates {
    if (_certificates is EqualUnmodifiableListView) return _certificates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certificates);
  }

  final List<PortfolioProject> _projects;
  @override
  List<PortfolioProject> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  final int volunteerHours;
  @override
  final int followers;
  @override
  final int following;
  @override
  final int xp;
  @override
  final int campusCoins;
  @override
  final int academicPoints;
  @override
  final int communityPoints;
  @override
  final int leadershipPoints;
  @override
  final int innovationPoints;
  @override
  final String? githubUrl;
  @override
  final String? linkedinUrl;
  @override
  final String? portfolioUrl;

  @override
  String toString() {
    return 'CampusMember(id: $id, fullName: $fullName, faculty: $faculty, department: $department, level: $level, skills: $skills, programmingLanguages: $programmingLanguages, certificates: $certificates, projects: $projects, volunteerHours: $volunteerHours, followers: $followers, following: $following, xp: $xp, campusCoins: $campusCoins, academicPoints: $academicPoints, communityPoints: $communityPoints, leadershipPoints: $leadershipPoints, innovationPoints: $innovationPoints, githubUrl: $githubUrl, linkedinUrl: $linkedinUrl, portfolioUrl: $portfolioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.faculty, faculty) || other.faculty == faculty) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality().equals(
              other._programmingLanguages,
              _programmingLanguages,
            ) &&
            const DeepCollectionEquality().equals(
              other._certificates,
              _certificates,
            ) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.volunteerHours, volunteerHours) ||
                other.volunteerHours == volunteerHours) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.following, following) ||
                other.following == following) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.campusCoins, campusCoins) ||
                other.campusCoins == campusCoins) &&
            (identical(other.academicPoints, academicPoints) ||
                other.academicPoints == academicPoints) &&
            (identical(other.communityPoints, communityPoints) ||
                other.communityPoints == communityPoints) &&
            (identical(other.leadershipPoints, leadershipPoints) ||
                other.leadershipPoints == leadershipPoints) &&
            (identical(other.innovationPoints, innovationPoints) ||
                other.innovationPoints == innovationPoints) &&
            (identical(other.githubUrl, githubUrl) ||
                other.githubUrl == githubUrl) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.portfolioUrl, portfolioUrl) ||
                other.portfolioUrl == portfolioUrl));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    fullName,
    faculty,
    department,
    level,
    const DeepCollectionEquality().hash(_skills),
    const DeepCollectionEquality().hash(_programmingLanguages),
    const DeepCollectionEquality().hash(_certificates),
    const DeepCollectionEquality().hash(_projects),
    volunteerHours,
    followers,
    following,
    xp,
    campusCoins,
    academicPoints,
    communityPoints,
    leadershipPoints,
    innovationPoints,
    githubUrl,
    linkedinUrl,
    portfolioUrl,
  ]);

  /// Create a copy of CampusMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusMemberImplCopyWith<_$CampusMemberImpl> get copyWith =>
      __$$CampusMemberImplCopyWithImpl<_$CampusMemberImpl>(this, _$identity);
}

abstract class _CampusMember implements CampusMember {
  const factory _CampusMember({
    required final String id,
    required final String fullName,
    required final String faculty,
    required final String department,
    required final int level,
    required final List<String> skills,
    required final List<String> programmingLanguages,
    required final List<String> certificates,
    required final List<PortfolioProject> projects,
    required final int volunteerHours,
    required final int followers,
    required final int following,
    required final int xp,
    required final int campusCoins,
    required final int academicPoints,
    required final int communityPoints,
    required final int leadershipPoints,
    required final int innovationPoints,
    final String? githubUrl,
    final String? linkedinUrl,
    final String? portfolioUrl,
  }) = _$CampusMemberImpl;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get faculty;
  @override
  String get department;
  @override
  int get level;
  @override
  List<String> get skills;
  @override
  List<String> get programmingLanguages;
  @override
  List<String> get certificates;
  @override
  List<PortfolioProject> get projects;
  @override
  int get volunteerHours;
  @override
  int get followers;
  @override
  int get following;
  @override
  int get xp;
  @override
  int get campusCoins;
  @override
  int get academicPoints;
  @override
  int get communityPoints;
  @override
  int get leadershipPoints;
  @override
  int get innovationPoints;
  @override
  String? get githubUrl;
  @override
  String? get linkedinUrl;
  @override
  String? get portfolioUrl;

  /// Create a copy of CampusMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampusMemberImplCopyWith<_$CampusMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
