class NewsResponseModel {
  String? _status;
  int? _totalResults;
  List<Article>? _articles;

  NewsResponseModel(
      {String? status, int? totalResults, List<Article>? articles}) {
    if (status != null) {
      this._status = status;
    }
    if (totalResults != null) {
      this._totalResults = totalResults;
    }
    if (articles != null) {
      this._articles = articles;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  int? get totalResults => _totalResults;
  set totalResults(int? totalResults) => _totalResults = totalResults;
  List<Article>? get articles => _articles;
  set articles(List<Article>? articles) => _articles = articles;

  NewsResponseModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = <Article>[];
      json['articles'].forEach((v) {
        _articles!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['totalResults'] = this._totalResults;
    if (this._articles != null) {
      data['articles'] = this._articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  Source? _source;
  String? _author;
  String? _title;
  String? _description;
  String? _url;
  String? _urlToImage;
  String? _publishedAt;
  String? _content;

  Article(
      {Source? source,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content}) {
    if (source != null) {
      this._source = source;
    }
    if (author != null) {
      this._author = author;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (url != null) {
      this._url = url;
    }
    if (urlToImage != null) {
      this._urlToImage = urlToImage;
    }
    if (publishedAt != null) {
      this._publishedAt = publishedAt;
    }
    if (content != null) {
      this._content = content;
    }
  }

  Source? get source => _source;
  set source(Source? source) => _source = source;
  String? get author => _author;
  set author(String? author) => _author = author;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get url => _url;
  set url(String? url) => _url = url;
  String? get urlToImage => _urlToImage;
  set urlToImage(String? urlToImage) => _urlToImage = urlToImage;
  String? get publishedAt => _publishedAt;
  set publishedAt(String? publishedAt) => _publishedAt = publishedAt;
  String? get content => _content;
  set content(String? content) => _content = content;

  Article.fromJson(Map<String, dynamic> json) {
    _source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    _author = json['author'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
    _urlToImage = json['urlToImage'];
    _publishedAt = json['publishedAt'];
    _content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._source != null) {
      data['source'] = this._source!.toJson();
    }
    data['author'] = this._author;
    data['title'] = this._title;
    data['description'] = this._description;
    data['url'] = this._url;
    data['urlToImage'] = this._urlToImage;
    data['publishedAt'] = this._publishedAt;
    data['content'] = this._content;
    return data;
  }
}

class Source {
  String? _id;
  String? _name;

  Source({String? id, String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;

  Source.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    return data;
  }
}

extension NewsResponseModelCopyWith on NewsResponseModel {
  NewsResponseModel copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return NewsResponseModel(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }
}
