class TrendingModel {
    Links links;
    int total;
    int page;
    int pageSize;
    List<Result> results;

    TrendingModel({
        required this.links,
        required this.total,
        required this.page,
        required this.pageSize,
        required this.results,
    });

    factory TrendingModel.fromJson(Map<String, dynamic> json) {
        return TrendingModel(
            links: Links.fromJson(json['links']),
            total: json['total'],
            page: json['page'],
            pageSize: json['page_size'],
            results: (json['results'] as List<dynamic>)
                .map((resultJson) => Result.fromJson(resultJson))
                .toList(),
        );
    }

}

class Links {
    int? next;
    dynamic previous;

    Links({
        required this.next,
        required this.previous,
    });

    factory Links.fromJson(Map<String, dynamic> json) {
        return Links(
            next: json['next'],
            previous: json['previous'],
        );
    }

}

class Result {
    String thumbnail;
    int id;
    String title;
    DateTime dateAndTime;
    String slug;
    DateTime createdAt;
    String manifest;
    int liveStatus;
    String? liveManifest;
    bool isLive;
    String channelImage;
    String channelName;
    String? channelUsername;
    bool isVerified;
    String channelSlug;
    String channelSubscriber;
    int channelId;
    String type;
    String viewers;
    String duration;

    Result({
        required this.thumbnail,
        required this.id,
        required this.title,
        required this.dateAndTime,
        required this.slug,
        required this.createdAt,
        required this.manifest,
        required this.liveStatus,
        required this.liveManifest,
        required this.isLive,
        required this.channelImage,
        required this.channelName,
        required this.channelUsername,
        required this.isVerified,
        required this.channelSlug,
        required this.channelSubscriber,
        required this.channelId,
        required this.type,
        required this.viewers,
        required this.duration,
    });


    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            thumbnail: json['thumbnail'],
            id: json['id'],
            title: json['title'],
            dateAndTime: DateTime.parse(json['date_and_time']),
            slug: json['slug'],
            createdAt: DateTime.parse(json['created_at']),
            manifest: json['manifest'],
            liveStatus: json['live_status'],
            liveManifest: json['live_manifest'],
            isLive: json['is_live'],
            channelImage: json['channel_image'],
            channelName: json['channel_name'],
            channelUsername: json['channel_username'],
            isVerified: json['is_verified'],
            channelSlug: json['channel_slug'],
            channelSubscriber: json['channel_subscriber'],
            channelId: json['channel_id'],
            type: json['type'],
            viewers: json['viewers'],
            duration: json['duration'],
        );
    }

}
