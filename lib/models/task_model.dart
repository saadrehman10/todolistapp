class Task {
  String? creatorId;
  String? createdAt;
  String? assigneeId;
  String? assignerId;
  int? commentCount;
  bool? isCompleted;
  String? content;
  String? description;
  Due? due;
  Null? duration;
  String? id;
  List<String>? labels;
  int? order;
  int? priority;
  String? projectId;
  String? sectionId;
  String? parentId;
  String? url;

  Task(
      {this.creatorId,
      this.createdAt,
      this.assigneeId,
      this.assignerId,
      this.commentCount,
      this.isCompleted,
      this.content,
      this.description,
      this.due,
      this.duration,
      this.id,
      this.labels,
      this.order,
      this.priority,
      this.projectId,
      this.sectionId,
      this.parentId,
      this.url});

  Task.fromJson(Map<String, dynamic> json) {
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    assigneeId = json['assignee_id'];
    assignerId = json['assigner_id'];
    commentCount = json['comment_count'];
    isCompleted = json['is_completed'];
    content = json['content'];
    description = json['description'];
    due = json['due'] != null ? Due.fromJson(json['due']) : null;
    duration = json['duration'];
    id = json['id'];
    labels = json['labels'].cast<String>();
    order = json['order'];
    priority = json['priority'];
    projectId = json['project_id'];
    sectionId = json['section_id'];
    parentId = json['parent_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creator_id'] = creatorId;
    data['created_at'] = createdAt;
    data['assignee_id'] = assigneeId;
    data['assigner_id'] = assignerId;
    data['comment_count'] = commentCount;
    data['is_completed'] = isCompleted;
    data['content'] = content;
    data['description'] = description;
    if (due != null) {
      data['due'] = due!.toJson();
    }
    data['duration'] = duration;
    data['id'] = id;
    data['labels'] = labels;
    data['order'] = order;
    data['priority'] = priority;
    data['project_id'] = projectId;
    data['section_id'] = sectionId;
    data['parent_id'] = parentId;
    data['url'] = url;
    return data;
  }

  Map<String, dynamic> toJsonForUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['description'] = description;
    data['priority'] = priority;

    if (due != null) {
      data['due_string'] = due!.string;
      data['due_date'] = due!.date;
    }
    data['label_ids'] = labels;
    data['project_id'] = projectId;
    data['section_id'] = sectionId;
    data['parent_id'] = parentId;
    data['order'] = order;

    return data;
  }
}

class Due {
  String? date;
  bool? isRecurring;
  String? datetime;
  String? string;
  String? timezone;

  Due({this.date, this.isRecurring, this.datetime, this.string, this.timezone});

  Due.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isRecurring = json['is_recurring'];
    datetime = json['datetime'];
    string = json['string'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['is_recurring'] = isRecurring;
    data['datetime'] = datetime;
    data['string'] = string;
    data['timezone'] = timezone;
    return data;
  }
}
