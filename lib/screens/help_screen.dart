import 'package:brunos_kitchen/utils/custom_colors.dart';
import 'package:brunos_kitchen/utils/images.dart';
import 'package:brunos_kitchen/widgets/brunos_footer.dart';
import 'package:brunos_kitchen/widgets/custom_scaffold.dart';
import 'package:brunos_kitchen/widgets/web_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/address_model.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
import '../utils/url_launcher.dart';
import '../view_models/address_view_model.dart';
import '../view_models/faqs_blogs_news_view_model.dart';
import '../widgets/app_bar_with_back_widget.dart';
import '../widgets/dialogs/discription_dialog.dart';

const List<String> bronosLocation = ['24.4905605', '54.39445'];

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
/*  static Future<void> openDefaultMap(BuildContext context) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(double.parse(bronosLocation[0]), double.parse(bronosLocation[1])),
      title: "Bruno's Kitchen",
    );
  }*/

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressViewModel>().setIsAddressAdd(false);
      context.read<AddressViewModel>().setEditAddress(
              value: AddressModel(
            coordinates: bronosLocation,
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    return Consumer<FaqsBlogsNewsViewModel>(
        builder: (_, faqsBlogsNewsViewModel, __) {
      return SafeArea(
        child: CustomScaffold(
          appBar: const AppBarWithBackWidget(
            heading: 'Get Help',
            showPuppy: false,
            showCart: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0)
                      .w,
                  child: WebSizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*  WebViewWidget(
                              controller: faqsBlogsNewsViewModel.getWebViewController,
                            ),*/
                        black24w500Centre(data: 'Contact us'),
                        SizedBox(
                          height: 20.h,
                        ),
                        /*  lightBlack14w400Centre(
                            left: true,
                            data:
                                'We’d love to hear from you – please use the form to send us your message or ideas. Or simply pop in for a cup of fresh tea and a cookie:'),
                        SizedBox(
                          height: 20.h,
                        ),*/
                        TextField(
                          controller: faqsBlogsNewsViewModel.getComment,
                          onChanged: (text) {},
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: 'Your Comment',
                            contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15.0)
                                .w,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        customButton(
                          colored: true,
                          text: 'Submit',
                          onPressed: () async {
                            if (faqsBlogsNewsViewModel.validateComment()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              await faqsBlogsNewsViewModel.callAddCommentApi();
                              faqsBlogsNewsViewModel.clearComment();
                            } else {
                              descriptionDialog(
                                  context: context,
                                  description: 'Kindly fill Comment',
                                  height: 160.h,
                                  title: 'Alert');
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: 160.h,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: GoogleMap(
                                  zoomControlsEnabled: false,
                                  //liteModeEnabled: true,
                                  //myLocationEnabled: true,
                                  //myLocationButtonEnabled: true,
                                  // mapType: MapType.terrain,
                                  onCameraMove: (position) {
                                    context
                                        .watch<AddressViewModel>()
                                        .setInitialCameraPosition(LatLng(
                                            position.target.latitude,
                                            position.target.longitude));
                                  },
                                  onCameraIdle: () {
                                    context
                                        .watch<AddressViewModel>()
                                        .getMapMovement();
                                  },
                                  initialCameraPosition: CameraPosition(
                                      target: context
                                          .watch<AddressViewModel>()
                                          .getInitialCameraPosition),
                                  markers: <Marker>{
                                    Marker(
                                      /* onDragEnd: ((newPosition) {
                                        addressViewModel.updateMapCameraPosition(LatLng(
                                            newPosition.latitude, newPosition.longitude));
                                      }),*/
                                      //draggable: false,
                                      markerId: const MarkerId("1"),
                                      position: LatLng(
                                          double.parse(context
                                              .watch<AddressViewModel>()
                                              .getEditAddress
                                              .coordinates![0]),
                                          double.parse(context
                                              .watch<AddressViewModel>()
                                              .getEditAddress
                                              .coordinates![1])),
                                      icon:
                                          BitmapDescriptor.defaultMarkerWithHue(
                                              BitmapDescriptor.hueOrange),
                                      infoWindow: const InfoWindow(
                                        title: '',
                                      ),
                                    )
                                  },
                                  onMapCreated: context
                                      .watch<AddressViewModel>()
                                      .getUserLocation,
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: 170.w,
                                height: 150.h,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: customButton(
                                    colored: true,
                                    text: 'View Location',
                                    onPressed: () async {
                                      urlLauncher(url: addressLocation);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        black16w500(
                            data:
                                'Shop no.17, Paragon Bay Mall, Marina Square\nAl Reem Island, Abu Dhabi, UAE',
                            align: TextAlign.center),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri.parse(
                                'https://wa.me/${Contact.phone.text}?text=Hi');
                            await urlLauncher(url: launchUri);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                whatsAppIcon,
                                width: 18.h,
                                color: CustomColors.blackColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              black16w500(data: Contact.phone.text),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: Contact.email.text,
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Get Help',
                              }),
                            );
                            await urlLauncher(url: emailLaunchUri);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                color: CustomColors.blackColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              black16w500(data: Contact.email.text),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            // final Uri webUrl = Uri.parse(Contact.webUrl.text);
                            urlLauncher(url: webUrl);
                            /*  if (!await launchUrl(webUrl)) {
                              throw Exception('Could not launch $webUrl');
                            }*/
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.language,
                                color: CustomColors.blackColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              black16w500(data: 'www.brunos.kitchen'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        /*customButton(
                          colored: false,
                          text: 'Call Now',
                          icon: Icons.phone,
                          onPressed: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: Contact.phone.text,
                            );
                            await launchUrl(launchUri);
                          },
                        ),*/
                      ],
                    ),
                  ),
                ),
                BrunosFooter(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
