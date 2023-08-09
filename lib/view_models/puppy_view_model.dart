import 'dart:io';

import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/puppy_model.dart';
import 'package:brunos_kitchen/models/requests/register_puppy_request.dart';
import 'package:brunos_kitchen/models/responses/breeds_response.dart';
import 'package:brunos_kitchen/models/responses/puppies_response.dart';
import 'package:brunos_kitchen/route_generator.dart';
import 'package:brunos_kitchen/services/puppy_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../dunmmy_data.dart';
import '../screens/logIn_screen.dart';
import '../screens/intro_slides_screen.dart';
import '../services/firebase_upload_image_service.dart';
import '../utils/date_time_formatter.dart';
import '../utils/enums.dart';
import '../utils/image_genrator.dart';
import '../utils/shared_pref .dart';

class PuppyViewModel with ChangeNotifier {
  String _routeToPuppyFrom = Screens.home.text;
  final FirebaseUploadImageService _firebaseUploadImageService =
      FirebaseUploadImageService();
  final PuppyApiServices _puppyApiServices = PuppyApiServices();
  final ImageGenerator _imageGenerator = ImageGenerator();
  PuppiesResponse _puppiesResponse = PuppiesResponse();
  PuppyModel? _puppyDetail;
  final TextEditingController _puppyNameController = TextEditingController();
  String _puppyImage = '';
  CroppedFile? _imageFile;
  String _puppyGender = Puppy.boy.text;
  bool _puppyIsSpayNeuter = true;
  final TextEditingController _puppyBreedController = TextEditingController();
  BreedsResponse _breedsResponse = BreedsResponse();
  List<BreedsData> _breedsList = [];
  String _puppyDob = 'MM   /   DD   /   YYYY';
  DateTime? _formatBirthDate;
  int _puppyCurrentWeight = 0;
  int _puppyActualWeight = 0;
  String _puppyActivityLevel = Puppy.active.text;
  String _puppyNameFieldError = '';
  String _puppyBreedFieldError = '';
  String _puppyDobFieldError = '';
  String _currentWeightFieldError = '';
  String _actualWeightFieldError = '';
  String _puppyImageFieldError = '';

  PuppyModel? get getPuppyDetail => _puppyDetail;

  void setPuppyDetail(PuppyModel value) {
    _puppyDetail = value;
    notifyListeners();
  }

  PuppiesResponse get getPuppiesResponse => _puppiesResponse;

  void setPuppiesResponse(PuppiesResponse value) {
    _puppiesResponse = value;
    notifyListeners();
  }

  int get getPuppyCurrentWeight => _puppyCurrentWeight;

  void setPuppyCurrentWeight(int value) {
    _puppyCurrentWeight = value;
    notifyListeners();
  }

  int get getPuppyActualWeight => _puppyActualWeight;

  void setPuppyActualWeight(int value) {
    _puppyActualWeight = value;
    notifyListeners();
  }

  CroppedFile? get getImageFile => _imageFile;

  void setImageFile(CroppedFile value) {
    _imageFile = value;
    notifyListeners();
  }

  List<BreedsData> get getBreedslist => _breedsList;

  void setBreedsList(List<BreedsData> value) {
    _breedsList = value;
    notifyListeners();
  }

  TextEditingController get getPuppyBreedController => _puppyBreedController;

  String get getPuppyActivityLevel => _puppyActivityLevel;

  void setPuppyActivityLevel(String value) {
    _puppyActivityLevel = value;
    notifyListeners();
  }

  String get getPuppyDob => _puppyDob;

  void setPuppyDob(DateTime value) {
    _formatBirthDate = value;
    _puppyDob = DateTimeFormatter.showDateFormat2(value);
    notifyListeners();
  }

  String get getPuppyDobFieldError => _puppyDobFieldError;

  void setPuppyDobFieldError(String value) {
    _puppyDobFieldError = value;
    notifyListeners();
  }

  String get getActualWeightFieldError => _actualWeightFieldError;

  void setActualWeightFieldError(String value) {
    _actualWeightFieldError = value;
    notifyListeners();
  }

  String get getCurrentWeightFieldError => _currentWeightFieldError;

  void setCurrentWeightFieldError(String value) {
    _currentWeightFieldError = value;
    notifyListeners();
  }

  String get getPuppyBreedFieldError => _puppyBreedFieldError;

  void setPuppyBreedFieldError(String value) {
    _puppyBreedFieldError = value;
    notifyListeners();
  }

  String get getPuppyNameFieldError => _puppyNameFieldError;

  void setPuppyNameFieldError(String value) {
    _puppyNameFieldError = value;
    notifyListeners();
  }

  String get getPuppyImageFieldError => _puppyImageFieldError;

  void setPuppyImageFieldError(String value) {
    _puppyImageFieldError = value;
    notifyListeners();
  }

  TextEditingController get getPuppyNameController => _puppyNameController;

  bool get getPuppyIsSpayNeuter => _puppyIsSpayNeuter;

  void setPuppyIsSpayNeuter(bool value) {
    _puppyIsSpayNeuter = value;
    notifyListeners();
  }

  String get getPuppyGender => _puppyGender;

  void setPuppyGender(String value) {
    _puppyGender = value;
    notifyListeners();
  }

  String get getRouteToPuppyFrom => _routeToPuppyFrom;

  void setRouteToPuppyFrom(String value) {
    _routeToPuppyFrom = value;
    notifyListeners();
  }

  bool puppyBreedValidation() {
    if (_puppyBreedController.text.isEmpty) {
      setPuppyBreedFieldError('Please Enter Pet Breed');
      return false;
    } else {
      setPuppyBreedFieldError('');
      return true;
    }
  }

  bool puppyDobValidation() {
    if (_puppyDob.isEmpty) {
      setPuppyDobFieldError('Please Select Pet BirthDay');
      return false;
    } else {
      setPuppyDobFieldError('');
      return true;
    }
  }

  bool puppyCurrentWeightValidation() {
    if (_puppyCurrentWeight == 0) {
      setCurrentWeightFieldError('Please Select Pet Current Weight');
      return false;
    } else {
      setCurrentWeightFieldError('');
      return true;
    }
  }

  bool puppyActualWeightValidation() {
    if (_puppyActualWeight == 0) {
      setActualWeightFieldError('Please Select Pet Actual Weight');
      return false;
    } else {
      setActualWeightFieldError('');
      return true;
    }
  }

  bool puppyNameValidation() {
    if (_puppyNameController.text.isEmpty) {
      setPuppyNameFieldError('Please Enter Pet Name');
      return false;
    } else {
      setPuppyNameFieldError('');
      return true;
    }
  }

  bool puppyImageValidation() {
    if (_imageFile == null) {
      setPuppyImageFieldError('Please Enter Pet Image');
      return false;
    } else {
      setPuppyImageFieldError('');
      return true;
    }
  }

  bool puppyCreationValidation() {
    if (puppyNameValidation() && puppyImageValidation()) {
      return true;
    } else {
      return false;
    }
  }

  bool puppyAdditionalCreationValidation() {
    if (puppyBreedValidation() &&
        puppyDobValidation() &&
        puppyCurrentWeightValidation() &&
        puppyActualWeightValidation()) {
      return true;
    } else {
      return false;
    }
  }

  void clearPuppyData() {
    _puppyNameController.clear();
    _puppyImage = '';
    _imageFile = null;
    _puppyGender = Puppy.boy.text;
    _puppyIsSpayNeuter = true;
    _puppyBreedController.clear();
    _breedsList.clear();
    _puppyDob = 'MM   /   DD   /   YYYY';
    _puppyCurrentWeight = 0;
    _puppyActualWeight = 0;
    _puppyActivityLevel = Puppy.active.text;
    _puppyNameFieldError = '';
    _puppyBreedFieldError = '';
    _puppyDobFieldError = '';
    _currentWeightFieldError = '';
    _actualWeightFieldError = '';
    _puppyImageFieldError = '';
  }

  void searchBreeds(String query) {
    final suggestions = _breedsResponse.data!.where((breed) {
      return breed.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setBreedsList(suggestions);
  }

  Future<void> getAndUpLoadImage({required bool fromCamera}) async {
    setImageFile(await _imageGenerator.createImageFile(fromCamera: fromCamera));
    EasyLoading.show(status: 'Generating Image please wait...');

    // _farmDetail.imageUrl = url;
    // notifyListeners();
    EasyLoading.dismiss();
  }

  Future<bool> callRegisterPuppyApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    final puppyBirthDate = DateTimeFormatter.dateToTimeStamp(_formatBirthDate!);

    if (_imageFile != null) {
      try {
        _puppyImage = await _firebaseUploadImageService.upLoadImageFile(
            mFileImage: _imageFile!, fileName: _puppyNameController.text);
        print(_puppyImage);
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
    try {
      final RegisterPuppyRequest registerPuppyRequest = RegisterPuppyRequest(
          name: _puppyNameController.text,
          media: _puppyImage,
          gender: _puppyGender,
          isSpayNeuter: _puppyIsSpayNeuter,
          breed: _puppyBreedController.text,
          bornOnDate: puppyBirthDate,
          currentWeight: _puppyCurrentWeight,
          actualWeight: _puppyActualWeight,
          activityLevel: _puppyActivityLevel);
      final BaseResponseModel response = await _puppyApiServices.addPuppyApi(
          registerPuppyRequest: registerPuppyRequest);
      if (response.isSuccess!) {
        //  setImageSlider();
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callPuppyBreedsApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final BreedsResponse response = await _puppyApiServices.allBreedsApi();
      if (response.isSuccess!) {
        _breedsResponse = response;
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callPuppiesApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final PuppiesResponse response = await _puppyApiServices.puppiesApi();
      setPuppiesResponse(response);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }
}
