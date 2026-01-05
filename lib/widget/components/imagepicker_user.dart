import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUser extends StatefulWidget {
  final ValueChanged<File?>? onChanged;

  const ImagePickerUser({super.key, this.onChanged});

  @override
  State<ImagePickerUser> createState() => _ImagePickerUserState();
}

class _ImagePickerUserState extends State<ImagePickerUser> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  Future<void> _pickImage() async {
    final XFile? image = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Chọn ảnh"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.library_add),
                  title: const Text("Thư viện ảnh"),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _picker.pickImage(source: ImageSource.gallery),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _picker.pickImage(source: ImageSource.camera),
                    );
                  },
                ),
              ],
            ),
          ),
    );

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
      widget.onChanged?.call(_profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    final double avatarSize = isTablet ? 200 : 150;

    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            color: Color(0xFFB46CFF),
            borderRadius: BorderRadius.circular(avatarSize / 2),
            border: Border.all(color: Colors.blue, width: 1.2),
          ),
          child:
              _profileImage != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(avatarSize / 2),
                    child: Image.file(_profileImage!, fit: BoxFit.cover),
                  )
                  : const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
        ),
      ),
    );
  }
}
