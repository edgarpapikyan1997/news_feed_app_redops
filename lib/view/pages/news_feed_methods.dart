import '../../models/post_model/post_model.dart';

void checkForAnyAlert({required List<PostModel> postModels}) {
  List<PostModel> newPostModel = [];
  for (var i = 0; i < postModels.length; ++i) {
    if (postModels[i].alert != null) {
      newPostModel.add(postModels[i]);
      postModels.removeAt(i);
      i--; // Adjust the index after removal
    }
  }
  postModels.insertAll(0, newPostModel);
}