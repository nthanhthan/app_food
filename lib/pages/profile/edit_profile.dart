import 'dart:io';
import 'package:app_food/base/show_custom_snackbar.dart';
import 'package:app_food/controllers/user_controller.dart';
import 'package:app_food/routes/route_helper.dart';
import 'package:app_food/utils/colors.dart';
import 'package:app_food/widgets/app_text_field.dart';
import 'package:app_food/widgets/big_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String imageUrl = "";
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        showCustomSnackBar("Vui lòng chọn ảnh", title: "Lỗi");
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        // uploadFile();
      } else {
        showCustomSnackBar("Vui lòng chọn ảnh", title: "Lỗi");
      }
    });
  }

  Future<bool> uploadFile() async {
    if (_photo == null) {
      return false;
    }
    final fileName = _photo!.path;
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      imageUrl = await ref.getDownloadURL();
      return true;
    } catch (e) {
      showCustomSnackBar("Vui lòng thử lại", title: "Lỗi");
    }
    return false;
  }
  bool _isLoaded=true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (infoUser) {
      var nameController = TextEditingController(text: infoUser.user.name);
      var phoneController = TextEditingController(text: infoUser.user.phone);
      var emailController = TextEditingController(text: infoUser.user.email);
      var addressController = TextEditingController(text: infoUser.address);
      var photo = infoUser.user.photo.toString();
      print(photo);
      Future<bool> _editProfile() async {
        String name = nameController.text.trim();
        String email = emailController.text.trim();
        String address = addressController.text.trim();
        String phoneNumber = phoneController.text.trim();
        String urlPhoto = imageUrl.toString().trim();
        if (name.isEmpty) {
          showCustomSnackBar("Vui lòng nhập tên", title: "Tên");
        } else if (email.isEmpty) {
          showCustomSnackBar("Vui lòng nhập email", title: "Email");
        } else if (address.isEmpty) {
          showCustomSnackBar("Vui lòng nhập địa chỉ", title: "Địa chỉ");
        } else if (phoneNumber.isEmpty) {
          showCustomSnackBar("Vui lòng nhập số điện thoại",
              title: "Số điện thoại");
        } else {
          var data = {
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'avatar': urlPhoto
          };
          print(address);
          var addressUser = {
            "information": "From Foody",
            "address": address,
            "addressType": "Nhà ở",
            "lat": 0,
            "lng": 0
          };
          bool check =
              await Get.find<UserController>().editProfile(data, addressUser);
          return check;
        }
        return false;
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Chỉnh sửa cá nhân")),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: CircleAvatar(
                          radius: 90,
                          backgroundColor: AppColors.mainColor,
                          child: _photo != null || photo.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(85),
                                  child: photo.isNotEmpty
                                      ? Image.network(
                                          photo,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Text("...");
                                          },
                                        )
                                      : Image.file(
                                          _photo!,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(85)),
                                  width: 170,
                                  height: 170,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              AppTextField(
                  textController: nameController,
                  hintText: "Tên",
                  icon: Icons.person),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              AppTextField(
                  textController: phoneController,
                  hintText: "Số điện thoại",
                  icon: Icons.phone),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              AppTextField(
                textController: addressController,
                hintText: "Địa chỉ",
                icon: Icons.location_on_sharp,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              _isLoaded?Container(
                width: ScreenUtil().setWidth(250),
                height: ScreenUtil().setHeight(60),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(30)),
                    color: AppColors.mainColor),
                child: Center(
                    child: GestureDetector(
                  onTap: () async {
                      setState(() {
                         nameController = TextEditingController(text: infoUser.user.name);
                         phoneController = TextEditingController(text: infoUser.user.phone);
                         emailController = TextEditingController(text: infoUser.user.email);
                         addressController = TextEditingController(text: infoUser.address);
                        // photo = infoUser.user.photo.toString();
                        _isLoaded=false;
                      });
                    bool checkStatus = await uploadFile();
                    if (checkStatus) {
                       await _editProfile();
                      Get.toNamed(RouteHelper.profile);
                    } else {
                      showCustomSnackBar("Cập nhật thất bại", title: "Thử lại");
                    }
                  },
                  child: BigText(
                    text: "Cập nhật",
                    size: ScreenUtil().setSp(15),
                    color: Colors.white,
                  ),
                )),
              ):CircularProgressIndicator(
                color: AppColors.mainColor,
              )
            ],
          ),
        ),
      );
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
