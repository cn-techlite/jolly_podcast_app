// To parse this JSON data, do
//
//     final podcastResponseModel = podcastResponseModelFromJson(jsonString);

class PodcastResponseModel {
  final String? message;
  final PodcastResponseModelData? data;

  PodcastResponseModel({this.message, this.data});

  PodcastResponseModel copyWith({
    String? message,
    PodcastResponseModelData? data,
  }) => PodcastResponseModel(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory PodcastResponseModel.fromJson(Map<String, dynamic> json) =>
      PodcastResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : PodcastResponseModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class PodcastResponseModelData {
  final String? message;
  final MainPodcastDataModel? data;

  PodcastResponseModelData({this.message, this.data});

  PodcastResponseModelData copyWith({
    String? message,
    MainPodcastDataModel? data,
  }) => PodcastResponseModelData(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory PodcastResponseModelData.fromJson(Map<String, dynamic> json) =>
      PodcastResponseModelData(
        message: json["message"],
        data: json["data"] == null
            ? null
            : MainPodcastDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class MainPodcastDataModel {
  final List<PodcastDataModel>? data;
  final int? currentPage;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<LinkData>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  MainPodcastDataModel({
    this.data,
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  MainPodcastDataModel copyWith({
    List<PodcastDataModel>? data,
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<LinkData>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) => MainPodcastDataModel(
    data: data ?? this.data,
    currentPage: currentPage ?? this.currentPage,
    firstPageUrl: firstPageUrl ?? this.firstPageUrl,
    from: from ?? this.from,
    lastPage: lastPage ?? this.lastPage,
    lastPageUrl: lastPageUrl ?? this.lastPageUrl,
    links: links ?? this.links,
    nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    path: path ?? this.path,
    perPage: perPage ?? this.perPage,
    prevPageUrl: prevPageUrl ?? this.prevPageUrl,
    to: to ?? this.to,
    total: total ?? this.total,
  );

  factory MainPodcastDataModel.fromJson(Map<String, dynamic> json) =>
      MainPodcastDataModel(
        data: json["data"] == null
            ? []
            : List<PodcastDataModel>.from(
                json["data"]!.map((x) => PodcastDataModel.fromJson(x)),
              ),
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<LinkData>.from(
                json["links"]!.map((x) => LinkData.fromJson(x)),
              ),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "current_page": currentPage,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null
        ? []
        : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class PodcastDataModel {
  final int? id;
  final int? podcastId;
  final String? contentUrl;
  final String? title;
  final dynamic season;
  final dynamic number;
  final String? pictureUrl;
  final String? description;
  final bool? explicit;
  final int? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? playCount;
  final int? likeCount;
  final dynamic averageRating;
  final PodcastInfo? podcast;
  final DateTime? publishedAt;

  PodcastDataModel({
    this.id,
    this.podcastId,
    this.contentUrl,
    this.title,
    this.season,
    this.number,
    this.pictureUrl,
    this.description,
    this.explicit,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.playCount,
    this.likeCount,
    this.averageRating,
    this.podcast,
    this.publishedAt,
  });

  PodcastDataModel copyWith({
    int? id,
    int? podcastId,
    String? contentUrl,
    String? title,
    dynamic season,
    dynamic number,
    String? pictureUrl,
    String? description,
    bool? explicit,
    int? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? playCount,
    int? likeCount,
    dynamic averageRating,
    PodcastInfo? podcast,
    DateTime? publishedAt,
  }) => PodcastDataModel(
    id: id ?? this.id,
    podcastId: podcastId ?? this.podcastId,
    contentUrl: contentUrl ?? this.contentUrl,
    title: title ?? this.title,
    season: season ?? this.season,
    number: number ?? this.number,
    pictureUrl: pictureUrl ?? this.pictureUrl,
    description: description ?? this.description,
    explicit: explicit ?? this.explicit,
    duration: duration ?? this.duration,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    playCount: playCount ?? this.playCount,
    likeCount: likeCount ?? this.likeCount,
    averageRating: averageRating ?? this.averageRating,
    podcast: podcast ?? this.podcast,
    publishedAt: publishedAt ?? this.publishedAt,
  );

  factory PodcastDataModel.fromJson(Map<String, dynamic> json) =>
      PodcastDataModel(
        id: json["id"],
        podcastId: json["podcast_id"],
        contentUrl: json["content_url"],
        title: json["title"],
        season: json["season"],
        number: json["number"],
        pictureUrl: json["picture_url"],
        description: json["description"],
        explicit: json["explicit"],
        duration: json["duration"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        playCount: json["play_count"],
        likeCount: json["like_count"],
        averageRating: json["average_rating"],
        podcast: json["podcast"] == null
            ? null
            : PodcastInfo.fromJson(json["podcast"]),
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "podcast_id": podcastId,
    "content_url": contentUrl,
    "title": title,
    "season": season,
    "number": number,
    "picture_url": pictureUrl,
    "description": description,
    "explicit": explicit,
    "duration": duration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "play_count": playCount,
    "like_count": likeCount,
    "average_rating": averageRating,
    "podcast": podcast?.toJson(),
    "published_at": publishedAt?.toIso8601String(),
  };
}

class PodcastInfo {
  final int? id;
  final int? userId;
  final String? title;
  final String? author;
  final dynamic categoryName;
  final String? categoryType;
  final String? pictureUrl;
  final dynamic coverPictureUrl;
  final String? description;
  final EmbeddablePlayerSettings? embeddablePlayerSettings;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PublisherInfo? publisher;

  PodcastInfo({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.categoryName,
    this.categoryType,
    this.pictureUrl,
    this.coverPictureUrl,
    this.description,
    this.embeddablePlayerSettings,
    this.createdAt,
    this.updatedAt,
    this.publisher,
  });

  PodcastInfo copyWith({
    int? id,
    int? userId,
    String? title,
    String? author,
    dynamic categoryName,
    String? categoryType,
    String? pictureUrl,
    dynamic coverPictureUrl,
    String? description,
    EmbeddablePlayerSettings? embeddablePlayerSettings,
    DateTime? createdAt,
    DateTime? updatedAt,
    PublisherInfo? publisher,
  }) => PodcastInfo(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    author: author ?? this.author,
    categoryName: categoryName ?? this.categoryName,
    categoryType: categoryType ?? this.categoryType,
    pictureUrl: pictureUrl ?? this.pictureUrl,
    coverPictureUrl: coverPictureUrl ?? this.coverPictureUrl,
    description: description ?? this.description,
    embeddablePlayerSettings:
        embeddablePlayerSettings ?? this.embeddablePlayerSettings,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    publisher: publisher ?? this.publisher,
  );

  factory PodcastInfo.fromJson(Map<String, dynamic> json) => PodcastInfo(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    author: json["author"],
    categoryName: json["category_name"],
    categoryType: json["category_type"],
    pictureUrl: json["picture_url"],
    coverPictureUrl: json["cover_picture_url"],
    description: json["description"],
    embeddablePlayerSettings: json["embeddable_player_settings"] == null
        ? null
        : EmbeddablePlayerSettings.fromJson(json["embeddable_player_settings"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    publisher: json["publisher"] == null
        ? null
        : PublisherInfo.fromJson(json["publisher"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "author": author,
    "category_name": categoryName,
    "category_type": categoryType,
    "picture_url": pictureUrl,
    "cover_picture_url": coverPictureUrl,
    "description": description,
    "embeddable_player_settings": embeddablePlayerSettings?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "publisher": publisher?.toJson(),
  };
}

class EmbeddablePlayerSettings {
  final Player? player;
  final Features? features;
  final Playlists? playlists;
  final ElementsVisiblity? elementsVisiblity;

  EmbeddablePlayerSettings({
    this.player,
    this.features,
    this.playlists,
    this.elementsVisiblity,
  });

  EmbeddablePlayerSettings copyWith({
    Player? player,
    Features? features,
    Playlists? playlists,
    ElementsVisiblity? elementsVisiblity,
  }) => EmbeddablePlayerSettings(
    player: player ?? this.player,
    features: features ?? this.features,
    playlists: playlists ?? this.playlists,
    elementsVisiblity: elementsVisiblity ?? this.elementsVisiblity,
  );

  factory EmbeddablePlayerSettings.fromJson(Map<String, dynamic> json) =>
      EmbeddablePlayerSettings(
        player: json["player"] == null ? null : Player.fromJson(json["player"]),
        features: json["features"] == null
            ? null
            : Features.fromJson(json["features"]),
        playlists: json["playlists"] == null
            ? null
            : Playlists.fromJson(json["playlists"]),
        elementsVisiblity: json["elements_visiblity"] == null
            ? null
            : ElementsVisiblity.fromJson(json["elements_visiblity"]),
      );

  Map<String, dynamic> toJson() => {
    "player": player?.toJson(),
    "features": features?.toJson(),
    "playlists": playlists?.toJson(),
    "elements_visiblity": elementsVisiblity?.toJson(),
  };
}

class ElementsVisiblity {
  final bool? like;
  final bool? logo;
  final bool? share;
  final bool? comments;
  final bool? download;

  ElementsVisiblity({
    this.like,
    this.logo,
    this.share,
    this.comments,
    this.download,
  });

  ElementsVisiblity copyWith({
    bool? like,
    bool? logo,
    bool? share,
    bool? comments,
    bool? download,
  }) => ElementsVisiblity(
    like: like ?? this.like,
    logo: logo ?? this.logo,
    share: share ?? this.share,
    comments: comments ?? this.comments,
    download: download ?? this.download,
  );

  factory ElementsVisiblity.fromJson(Map<String, dynamic> json) =>
      ElementsVisiblity(
        like: json["like"],
        logo: json["logo"],
        share: json["share"],
        comments: json["comments"],
        download: json["download"],
      );

  Map<String, dynamic> toJson() => {
    "like": like,
    "logo": logo,
    "share": share,
    "comments": comments,
    "download": download,
  };
}

class Features {
  final bool? infoIcon;
  final bool? followButton;
  final bool? giveTipButton;

  Features({this.infoIcon, this.followButton, this.giveTipButton});

  Features copyWith({
    bool? infoIcon,
    bool? followButton,
    bool? giveTipButton,
  }) => Features(
    infoIcon: infoIcon ?? this.infoIcon,
    followButton: followButton ?? this.followButton,
    giveTipButton: giveTipButton ?? this.giveTipButton,
  );

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    infoIcon: json["info_icon"],
    followButton: json["follow_button"],
    giveTipButton: json["give_tip_button"],
  );

  Map<String, dynamic> toJson() => {
    "info_icon": infoIcon,
    "follow_button": followButton,
    "give_tip_button": giveTipButton,
  };
}

class Player {
  final String? size;
  final String? theme;
  final String? width;
  final String? height;
  final String? mainColor;

  Player({this.size, this.theme, this.width, this.height, this.mainColor});

  Player copyWith({
    String? size,
    String? theme,
    String? width,
    String? height,
    String? mainColor,
  }) => Player(
    size: size ?? this.size,
    theme: theme ?? this.theme,
    width: width ?? this.width,
    height: height ?? this.height,
    mainColor: mainColor ?? this.mainColor,
  );

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    size: json["size"],
    theme: json["theme"],
    width: json["width"],
    height: json["height"],
    mainColor: json["main_color"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "theme": theme,
    "width": width,
    "height": height,
    "main_color": mainColor,
  };
}

class Playlists {
  final bool? enabled;
  final bool? playContinuously;

  Playlists({this.enabled, this.playContinuously});

  Playlists copyWith({bool? enabled, bool? playContinuously}) => Playlists(
    enabled: enabled ?? this.enabled,
    playContinuously: playContinuously ?? this.playContinuously,
  );

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
    enabled: json["enabled"],
    playContinuously: json["play_continuously"],
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled,
    "play_continuously": playContinuously,
  };
}

class PublisherInfo {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? email;
  final String? profileImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PublisherInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.companyName,
    this.email,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  PublisherInfo copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? companyName,
    String? email,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PublisherInfo(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    companyName: companyName ?? this.companyName,
    email: email ?? this.email,
    profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory PublisherInfo.fromJson(Map<String, dynamic> json) => PublisherInfo(
    id: json["id"] ?? 0,
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    companyName: json["company_name"] ?? "",
    email: json["email"] ?? "",
    profileImageUrl: json["profile_image_url"] ?? "",
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "company_name": companyName,
    "email": email,
    "profile_image_url": profileImageUrl,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class LinkData {
  final String? url;
  final String? label;
  final bool? active;

  LinkData({this.url, this.label, this.active});

  LinkData copyWith({String? url, String? label, bool? active}) => LinkData(
    url: url ?? this.url,
    label: label ?? this.label,
    active: active ?? this.active,
  );

  factory LinkData.fromJson(Map<String, dynamic> json) => LinkData(
    url: json["url"] ?? "",
    label: json["label"] ?? "",
    active: json["active"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
