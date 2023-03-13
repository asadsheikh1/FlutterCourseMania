import 'dart:io';
import 'dart:async';

import 'package:course_mania/constants/component.dart';
import 'package:course_mania/cubits/category_cubit.dart';
import 'package:course_mania/cubits/playlist_cubit.dart';
import 'package:course_mania/models/category_model.dart';
import 'package:course_mania/screens/tabs_screen.dart';

import 'package:course_mania/widgets/button.dart';
import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:course_mania/constants/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPlaylistScreen extends StatefulWidget {
  const AddNewPlaylistScreen({super.key});
  static const routeName = '/add-new-playlist';

  @override
  State<AddNewPlaylistScreen> createState() => _AddNewPlaylistScreenState();
}

class _AddNewPlaylistScreenState extends State<AddNewPlaylistScreen> {
  TextEditingController playlistController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  String? newCat;
  File? fileImage;

  final _formKey = GlobalKey<FormState>();

  Future<int> addPlaylist(
    String playlistName,
    String playlistDescription,
    String cost,
    String fkCategoryId,
    String fkUserId,
    String fkMerchantId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://127.0.0.1:5000/playlist/add'),
        body: {
          'playlist_name': playlistName,
          'playlist_description': playlistDescription,
          'cost': cost,
          'fk_category_id': fkCategoryId,
          'fk_user_id': fkUserId,
          'fk_merchant_id': fkMerchantId,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 202) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, List<CategoryModel>>(
      builder: (context, catState) {
        if (catState.isEmpty) {
          return const CustomCircularProgressIndicator();
        }
        return Scaffold(
          backgroundColor: kBlackColor,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: kTransparentColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListTile(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            tileColor: kHintColor.withOpacity(0.2),
                            title: Text(
                              'Add a playlist! 😀',
                              style: kTextStyle.copyWith(
                                color: kHintColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            subtitle: Text(
                              'Adding playlist made easy',
                              style: kTextStyle.copyWith(color: kWhiteColor),
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kHintColor.withOpacity(0.2),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    TabsScreen.routeName,
                                  );
                                },
                                icon: const Icon(
                                  Icons.chevron_left,
                                ),
                                color: kHintColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Enter playlist name";
                              } else {
                                return null;
                              }
                            },
                            controller: playlistController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Playlist Name',
                              hintText: 'Python 2023',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter description";
                              } else {
                                return null;
                              }
                            },
                            controller: descriptionController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Description',
                              hintText: 'Welcome to Python 2023 course',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^(\d{1,5}|\d{0,5}\.\d{1,2})$')
                                      .hasMatch(value)) {
                                return "Enter cost";
                              } else {
                                return null;
                              }
                            },
                            controller: costController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Cost',
                              hintText: '11.29',
                              floatingLabelStyle: TextStyle(color: kWhiteColor),
                              hintStyle: TextStyle(color: kTextColor),
                              labelStyle: TextStyle(color: kTextColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              BlocBuilder<CategoryCubit, List<CategoryModel>>(
                            builder: (context, catState) {
                              if (catState.isEmpty) {
                                return const CustomCircularProgressIndicator();
                              }
                              return DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return "Select category";
                                  } else {
                                    return null;
                                  }
                                },
                                hint: Text(
                                  'Select category',
                                  style: TextStyle(
                                    color: kTextColor,
                                  ),
                                ),
                                iconEnabledColor: kHintColor,
                                isExpanded: true,
                                value: newCat,
                                onChanged: (changedValue) {
                                  setState(() {
                                    newCat = changedValue;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusColor: kHintColor,
                                  hoverColor: kHintColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kHintColor,
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kHintColor,
                                      width: 0,
                                    ),
                                  ),
                                ),
                                items: [
                                  ...catState
                                      .map((category) => category.categoryName)
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: kHintColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: kHintColor),
                                ),
                                child: fileImage == null
                                    ? Icon(
                                        Icons.image,
                                        color: kHintColor,
                                        size: 34,
                                      )
                                    : Image.file(
                                        fileImage!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Expanded(
                                child: Button(
                                  buttontext: 'Pick Image',
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (pickedFile == null) {
                                      return;
                                    } else {
                                      final file = File(pickedFile.path);
                                      setState(() {
                                        fileImage = file;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Card(
            elevation: 0.0,
            color: kBlackColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          for (CategoryModel category in catState) {
                            if (category.categoryName == newCat) {
                              int playlistId = await addPlaylist(
                                playlistController.text.toString(),
                                descriptionController.text.toString(),
                                costController.text.toString(),
                                category.categoryId.toString(),
                                id!,
                                1.toString(),
                              );

                              context.read<PlaylistCubit>().playlist;

                              if (playlistId != 0) {
                                Fluttertoast.showToast(
                                  msg: "Playlist created successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: kBlackColor,
                                  textColor: kHintColor,
                                  fontSize: 16.0,
                                );
                              }
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: kHintColor.withOpacity(0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add a playlist',
                                style: kTextStyle.copyWith(
                                  color: kHintColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// import 'dart:io';

// import 'package:course_mania/cubits/category_cubit.dart';
// import 'package:course_mania/models/category_model.dart';
// import 'package:course_mania/widgets/button.dart';
// import 'package:course_mania/widgets/custom_circular_progress_indicator.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:course_mania/constants/constant.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// class AddNewPlaylistScreen extends StatefulWidget {
//   const AddNewPlaylistScreen({super.key});
//   static const routeName = '/add-new-playlist';

//   @override
//   State<AddNewPlaylistScreen> createState() => _AddNewPlaylistScreenState();
// }

// class _AddNewPlaylistScreenState extends State<AddNewPlaylistScreen> {
//   TextEditingController playlistController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController costController = TextEditingController();
//   String? newCat;
//   File? file;
//   bool isFile = false;
//   ImagePicker image = ImagePicker();
//   Uint8List? memoryImage;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBlackColor,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: kTextColor),
//         backgroundColor: kBlackColor,
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text(
//           'Add a playlist',
//           style: kTextStyle.copyWith(color: kHintColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty ||
//                             !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
//                           return "Enter playlist name";
//                         } else {
//                           return null;
//                         }
//                       },
//                       controller: playlistController,
//                       keyboardType: TextInputType.name,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         labelText: 'Playlist Name',
//                         hintText: 'Python 2023',
//                         floatingLabelStyle: TextStyle(color: kWhiteColor),
//                         hintStyle: TextStyle(color: kTextColor),
//                         labelStyle: TextStyle(color: kTextColor),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter description";
//                         } else {
//                           return null;
//                         }
//                       },
//                       controller: descriptionController,
//                       keyboardType: TextInputType.name,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         labelText: 'Description',
//                         hintText: 'Welcome to Python 2023 course',
//                         floatingLabelStyle: TextStyle(color: kWhiteColor),
//                         hintStyle: TextStyle(color: kTextColor),
//                         labelStyle: TextStyle(color: kTextColor),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty ||
//                             !RegExp(r'^(\d{1,5}|\d{0,5}\.\d{1,2})$')
//                                 .hasMatch(value)) {
//                           return "Enter cost";
//                         } else {
//                           return null;
//                         }
//                       },
//                       controller: costController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         labelText: 'Cost',
//                         hintText: '11.29',
//                         floatingLabelStyle: TextStyle(color: kWhiteColor),
//                         hintStyle: TextStyle(color: kTextColor),
//                         labelStyle: TextStyle(color: kTextColor),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: BlocBuilder<CategoryCubit, List<CategoryModel>>(
//                       builder: (context, catState) {
//                         if (catState.isEmpty) {
//                           return const CustomCircularProgressIndicator();
//                         }
//                         return DropdownButtonFormField<String>(
//                           validator: (value) {
//                             if (value == null) {
//                               return "Select category";
//                             } else {
//                               return null;
//                             }
//                           },
//                           hint: Text(
//                             'Select category',
//                             style: TextStyle(
//                               color: kTextColor,
//                             ),
//                           ),
//                           iconEnabledColor: kHintColor,
//                           isExpanded: true,
//                           value: newCat,
//                           onChanged: (changedValue) {
//                             setState(() {
//                               newCat = changedValue;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(),
//                             focusColor: kHintColor,
//                             hoverColor: kHintColor,
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: kHintColor,
//                                 width: 0,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: kHintColor,
//                                 width: 0,
//                               ),
//                             ),
//                           ),
//                           items: [
//                             ...catState.map((category) => category.categoryName)
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(
//                                 value,
//                                 style: TextStyle(
//                                   color: kHintColor,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                           width: 100,
//                           child: file == null
//                               ? const Icon(
//                                   Icons.image,
//                                 )
//                               : Image.file(
//                                   file!,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                         Expanded(
//                           child: Button(
//                             buttontext: 'Pick Image',
//                             onPressed: () async {
//                               final picker = ImagePicker();
//                               final pickedFile = await picker.pickImage(
//                                 source: ImageSource.gallery,
//                               );

//                               if (pickedFile == null) return;
//                               if (isFile) {}
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Card(
//         elevation: 0.0,
//         color: kBlackColor,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40.0),
//             topRight: Radius.circular(40.0),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       Fluttertoast.showToast(
//                         msg: "Playlist created successfully",
//                         toastLength: Toast.LENGTH_LONG,
//                         gravity: ToastGravity.BOTTOM,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: kBlackColor,
//                         textColor: kHintColor,
//                         fontSize: 16.0,
//                       );
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     child: Container(
//                       height: 55.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30.0),
//                         color: kHintColor.withOpacity(0.2),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Add a playlist',
//                             style: kTextStyle.copyWith(
//                               color: kHintColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
