import 'story.dart';

class StoryAlbum {
  StoryAlbum({
    required this.userID,
    required this.albumName,
    required this.stories,
  });

  final int userID;
  final String albumName;
  final List<Story> stories;
}
