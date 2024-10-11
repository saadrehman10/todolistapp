class Project {
  String? id;
  String? name;
  int? commentCount;
  int? order;
  String? color;
  bool? isShared;
  bool? isFavorite;
  String? parentId;
  bool? isInboxProject;
  bool? isTeamInbox;
  String? viewStyle;
  String? url;

  Project(
      {this.id,
      this.name,
      this.commentCount,
      this.order,
      this.color,
      this.isShared,
      this.isFavorite,
      this.parentId,
      this.isInboxProject,
      this.isTeamInbox,
      this.viewStyle,
      this.url});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commentCount = json['comment_count'];
    order = json['order'];
    color = json['color'];
    isShared = json['is_shared'];
    isFavorite = json['is_favorite'];
    parentId = json['parent_id'];
    isInboxProject = json['is_inbox_project'];
    isTeamInbox = json['is_team_inbox'];
    viewStyle = json['view_style'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['comment_count'] = commentCount;
    data['order'] = order;
    data['color'] = color;
    data['is_shared'] = isShared;
    data['is_favorite'] = isFavorite;
    data['parent_id'] = parentId;
    data['is_inbox_project'] = isInboxProject;
    data['is_team_inbox'] = isTeamInbox;
    data['view_style'] = viewStyle;
    data['url'] = url;
    return data;
  }
}
