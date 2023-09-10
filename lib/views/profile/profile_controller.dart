import 'package:soccermadeeasy/models/pageModels/profile_page_model.dart';

import '../../commands/base_command.dart';
import '../../commands/images_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';

class ProfileController extends BaseCommand {
  // dynamic objectImageInput;
  // dynamic currentUser;
  // Map<String, dynamic> eventListDetails = {};
  // Map<String, dynamic> teamListDetails = {};

  Future<void> loadInitialData(dynamic profileDetails) async {
    print("loadInitialData Profile");
    //get current user
    String imageUrl = "";

    if (profileDetails['isMine']) {
      imageUrl = UserCommand().getProfileImage();
      profilePageModel.user = UserCommand().getAppModelUser();
      

      if (imageUrl == '') {
        String? key = profilePageModel.user['mainImageKey'];
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
            BaseCommand().userModel.profileImageUrl = imageUrl;
          }
        }
      }
    } else {
      Map<String, dynamic> findMyUserByIdResp =
          await UserCommand().findUserById(profileDetails['user']);
      print("findMyUserByIdResp: $findMyUserByIdResp");
      if (findMyUserByIdResp['success']) {
        profilePageModel.user = findMyUserByIdResp['data'];
        String? key = profilePageModel.user['mainImageKey'];
        print("key: $key");
        if (key != null) {
          Map<String, dynamic> getUserProfileImageResp =
              await ImagesCommand().getImage(key);
          print("getUserProfileImageResp: $getUserProfileImageResp");
          if (getUserProfileImageResp['success']) {
            imageUrl = getUserProfileImageResp['data']['signedUrl'];
          }
        }
      }
    }

    print("loadInitialData Profile imageUrl: $imageUrl");

    profilePageModel.objectImageInput = {
      "imageUrl": imageUrl,
      "containerType": Constants.PROFILEIMAGECIRCLE
    };

    profilePageModel.eventUserParticipants = ProfilePageModel().user['eventUserParticipants'];
    profilePageModel.teamUserParticipants = ProfilePageModel().user['teamUserParticipants'];

        
  }

  void changeImage() {
    profilePageModel.objectImageInput['imageUrl'] = 'selambaba';
  }

  @override
  Future<void> signOut();
}
