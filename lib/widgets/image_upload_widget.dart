import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_colors.dart';

class ImageUploadWidget extends StatefulWidget {
  final List<String> selectedImages;
  final Function(List<String>) onImagesChanged;
  final String? label;
  final bool isOptional;

  const ImageUploadWidget({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
    this.label,
    this.isOptional = true,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        final List<String> imagePaths = images.map((image) => image.path).toList();
        widget.onImagesChanged([...widget.selectedImages, ...imagePaths]);
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    final updatedImages = List<String>.from(widget.selectedImages);
    updatedImages.removeAt(index);
    widget.onImagesChanged(updatedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
        if (widget.label != null && widget.isOptional)
          const Text(
            '(Optional)',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGray,
            ),
          ),
        const SizedBox(height: 12),
        
        // Upload area
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.borderGray,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: widget.selectedImages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 48,
                          color: AppColors.mediumGray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Click to upload images',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.mediumGray.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildImageGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: widget.selectedImages.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.selectedImages.length) {
            // Add more button
            return GestureDetector(
              onTap: _pickImages,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundGray,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderGray),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primaryCyan,
                  size: 32,
                ),
              ),
            );
          }

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(File(widget.selectedImages[index])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
