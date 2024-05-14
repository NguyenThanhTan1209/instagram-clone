class Post {
  Post({
    required this.postID,
    required this.imagesPath,
    required this.description,
    required this.location,
  });

  final int postID;
  final List<String> imagesPath;
  final String description;
  final String location;
}
