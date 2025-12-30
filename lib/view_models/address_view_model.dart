import 'dart:async';

import 'package:brunos_kitchen/main.dart';
import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/add_address_request.dart';
import 'package:brunos_kitchen/models/requests/address_radius_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:location/location.dart' as locator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../models/address_model.dart';
import '../models/responses/address_radius_response.dart';
import '../models/responses/all_address_reponse.dart';
import '../services/address_api_services.dart';
import '../services/api_base_helper.dart';
import '../utils/conversions.dart';
import '../utils/enums.dart';
import '../utils/images.dart';
import 'auth_view_model.dart';

class AddressViewModel with ChangeNotifier {
  final AddressApiServices _addressApiServices = AddressApiServices();
  AllAddressResponse _allAddressResponse = AllAddressResponse();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _flatHouseNumberController = TextEditingController();
  final TextEditingController _deliveryInstructionController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactNumberController =TextEditingController();
  GoogleMapsPlaces? _googleMapsPlaces;
  LatLng _initialCameraPosition = const LatLng(20.5937, 78.9629);
  Timer? _debounce;
  String _mapCountry = '';
  List<Prediction> _predictionList = [];
  double? _selectedAddressLat;
  double? _selectedAddressLng;
  final List<Marker> _markers = [];
  GoogleMapController? _googleMapController;
  locator.LocationData? myLocation;
  String? error;
  locator.Location location = locator.Location();

  // Prediction? _selectedPrediction;
  bool _isDefault = true;
  String _otherLabel = AddressLabels.other.text;
  String _selectedLabel = AddressLabels.home.text;
  AddressModel _editAddress = AddressModel();
  bool _isAddressAdd = true;
  bool _routeFromHome = true;

  TextEditingController get getContactNameController => _contactNameController;
  TextEditingController get getContactNumberController => _contactNumberController;
  TextEditingController get getStreetController => _streetController;
  TextEditingController get getAreaController => _areaController;
  TextEditingController get getFloorController => _floorController;
  TextEditingController get getFlatHouseNumberController => _flatHouseNumberController;
  TextEditingController get getDeliveryInstructionController => _deliveryInstructionController;



  void setUserNameNumber() {
    _contactNumberController.text = navigatorKey.currentContext!.read<AuthViewModel>().getAuthResponse.data!.phoneNumber!;
    _contactNameController.text = navigatorKey.currentContext!.read<AuthViewModel>().getAuthResponse.data!.fullName!;
    notifyListeners();
  }



  Timer? get getDebounce => _debounce;

  String get getMapCountry => _mapCountry;

  String get getOtherLabel => _otherLabel;

  List<Marker> get getUserMarker => _markers;

  void setOtherLabel(String value) {
    _otherLabel = value;
    notifyListeners();
  }

  LatLng get getInitialCameraPosition => _initialCameraPosition;

  void setInitialCameraPosition(LatLng value) {
    _initialCameraPosition = value;
    _selectedAddressLat = value.latitude;
    _selectedAddressLng = value.longitude;
    notifyListeners();
  }

  //Prediction? get getSelectedPrediction => _selectedPrediction;

  Future<void> setSelectedPrediction(Prediction value) async {
    EasyLoading.show(status: 'Please Wait');
    _addressController.text = value.description!;
    await getPredictionLatLng(value);
    notifyListeners();
  }

  // TextEditingController get getFullAddressController => _fullAddressController;

  GoogleMapController get getGoogleMapController => _googleMapController!;

  List<Prediction> get getPrediction => _predictionList;

  TextEditingController get getAddressController => _addressController;

  AddressModel get getEditAddress => _editAddress;

  bool get getIsAddressAdd => _isAddressAdd;

  bool get getRouteFromHome => _routeFromHome;

  AllAddressResponse get getAllAddressResponse => _allAddressResponse;

  bool get getIsDefault => _isDefault;

  String get getSelectedLabel => _selectedLabel;

  void setDebounce(Timer? value) {
    _debounce = value;
    notifyListeners();
  }

  void setPredictionList(List<Prediction> value) {
    _predictionList = value;
    notifyListeners();
  }

  void setEditAddress({required AddressModel value}) {
    _editAddress = value;
    //  _fullAddressController.text = _editAddress.flatHouseNumber!;
    _addressController.text = _editAddress.address!;
    _selectedLabel = _editAddress.label!;
    _isDefault = _editAddress.isDefault?? true;
    notifyListeners();
  }

  void setRouteFromHome(bool value) {
    _routeFromHome = value;
    notifyListeners();
  }

  void setIsAddressAdd(bool value) {
    _isAddressAdd = value;
    if (_isAddressAdd) {
      clearAddressData();
    }
    notifyListeners();
  }

  void setAllAddressResponse(AllAddressResponse value) {
    _allAddressResponse = value;
    notifyListeners();
  }

  void setIsDefault(bool value) {
    _isDefault = value;
    notifyListeners();
  }

  void setSelectedLabel(String value) {
    _selectedLabel = value;
    notifyListeners();
  }

  clearAddressData() {
    // _fullAddressController.clear();
    _predictionList.clear();
    _addressController.clear();
    _contactNumberController.clear();
    _contactNameController.clear();
    _streetController.clear();
    _floorController.clear();
    _areaController.clear();
    _flatHouseNumberController.clear();
    _deliveryInstructionController.clear();
    _selectedLabel = AddressLabels.home.text;
    _otherLabel = AddressLabels.other.text;
    _isDefault = true;
  }

  /*bool validateAddress() {
    if (_fullAddressController.text.isEmpty ) {
      return false;
    } else {
      return true;
    }
  }*/

  Future<bool> validateAddressDetail() async {
    if (_addressController.text.isEmpty) {
      EasyLoading.showToast('Please Select Address');
      return false;
    }
    // else if (_mapCountry != 'United Arab Emirates'){
    //   EasyLoading.showToast('Address must be of UAE');
    //   return false;
    // }
    else {
      return await callValidateAddressRadius();
    }
  }

  void setIsDefaultAddressTrueFalse(bool value) {
    _editAddress.isDefault = value;
    notifyListeners();
  }

  Future<void> addMarkers() async {
    _markers.clear();
    _markers.add(
      Marker(
          onDragEnd: ((newPosition) {
            updateMapCameraPosition(
                LatLng(newPosition.latitude, newPosition.longitude));
          }),
          draggable: true,
          markerId: const MarkerId("1"),
          position: _initialCameraPosition,
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 3.2),
              sampleFood1) //Icon for Marker
          ),
    );
    notifyListeners();
  }

  void getUserLocation(
    GoogleMapController cntlr,
  ) async {
    _googleMapController = cntlr;
    if (_isAddressAdd) {
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      updateMapCameraPosition(
          LatLng(myLocation!.latitude!, myLocation!.longitude!));
    } else {
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.parse(_editAddress.coordinates![0]),
                  double.parse(_editAddress.coordinates![1])),
              zoom: 15),
        ),
      );
      setInitialCameraPosition(LatLng(
          double.parse(_editAddress.coordinates![0]),
          double.parse(_editAddress.coordinates![1])));
    }
  }

  void updateMapCameraPosition(LatLng location) async {
    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15),
      ),
    );
    setInitialCameraPosition(LatLng(location.latitude, location.longitude));
    /*Placemark locationData = await convertCoordinatesToPlaces(latitude: _initialCameraPosition.latitude,  longitude: _initialCameraPosition.longitude);
    _addressController.text =
    ' ${locationData.name},${locationData.subLocality},${locationData.locality},${locationData.country}';*/
    await getMapMovement();
   // notifyListeners();
  }

  Future <void> getMapMovement ()async  {
    Placemark locationData = await convertCoordinatesToPlaces(latitude: _initialCameraPosition.latitude,  longitude: _initialCameraPosition.longitude);
    _addressController.text =
    '${locationData.name},${locationData.subLocality},${locationData.locality},${locationData.country}';
    _mapCountry = locationData.country!;
    notifyListeners();
  }



  Future<void> getPredictionLatLng(Prediction p) async {
    PlacesDetailsResponse detail =
        await _googleMapsPlaces!.getDetailsByPlaceId(p.placeId!);
    _selectedAddressLat = detail.result.geometry!.location.lat;
    _selectedAddressLng = detail.result.geometry!.location.lng;
    updateMapCameraPosition(
      LatLng(_selectedAddressLat!, _selectedAddressLng!),
    );
    EasyLoading.dismiss();
    _predictionList.clear();
  }

  void autoCompleteSearch(String value) async {
    try {
      EasyLoading.show(status: 'Searching');
      _googleMapsPlaces = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesAutocompleteResponse result = await _googleMapsPlaces!.autocomplete(
          value,
          types: [],
          strictbounds: false,
          language: "en",
          components: [Component(Component.country, "AE")]);
      setPredictionList(result.predictions);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }


  Future<bool> callValidateAddressRadius() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final AddressRadiusResponse response =
      await _addressApiServices.checkRadius(addressRadiusRequest: AddressRadiusRequest(lat: _selectedAddressLat,long:_selectedAddressLng ));
      if (response.withinRadius!) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showToast('Sorry, this address is outside of the delivery range');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callAllAddressApi() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final AllAddressResponse response =
          await _addressApiServices.allAddress();
      if (response.isSuccess!) {
        setAllAddressResponse(response);
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

  Future<bool> callCreateAddressApi() async {
    EasyLoading.show(status: 'Please wait...');
    final AddAddressRequest addAddressRequest = AddAddressRequest(
        isDefault: _isDefault,
        coordinates: [
          _selectedAddressLat.toString(),
          _selectedAddressLng.toString()
        ],
        address: _addressController.text,
        label: _selectedLabel == AddressLabels.other.text
            ? _otherLabel
            : _selectedLabel,
        flatHouseNumber: _flatHouseNumberController.text,
        street: _streetController.text,
        area: _areaController.text,
        floor: _floorController.text,
        deliveryInstruction: _deliveryInstructionController.text, contactName: _contactNameController.text, contactNumber: _contactNumberController.text);
    try {
      final BaseResponseModel response = await _addressApiServices
          .createAddress(addAddressRequest: addAddressRequest);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        callAllAddressApi();
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

  Future<bool> callDeleteAddressApi() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final BaseResponseModel response =
          await _addressApiServices.deleteAddress(addressId: _editAddress.sId!);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        callAllAddressApi();
        return true;
      } else {
        EasyLoading.showError('${_allAddressResponse.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callDefaultAddressApi() async {
    EasyLoading.show(status: 'Please wait...');
    try {
      final BaseResponseModel response = await _addressApiServices
          .defaultAddress(addressId: _editAddress.sId!);
      if (response.isSuccess!) {
        EasyLoading.dismiss();
        callAllAddressApi();
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

/*
  Future<bool> callUpdateAddressApi() async {
    EasyLoading.show(status: 'Please wait...');
    final AddressModel updatedAddress = AddressModel(
        id: _editAddress.id,
        addressType: _selectedLabel,
        fullAddress: _fullAddressController.text,
        nearbyLocations: _nearByLocationController.text,
        lat: _selectedAddressLat.toString(),
        long: _selectedAddressLng.toString(),
        isDefault: _isDefault);
    try {
      final AllAddressResponse response =
          await _addressApiServices.updateAddress(addressModel: updatedAddress);

      setAllAddressResponse(response);

      if (_allAddressResponse.status!) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${_allAddressResponse.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }
*/
}
