import 'package:flutter/material.dart';
import '../../../../common_widgets/app_cached_network_image.dart';
import '../../domain/address/address.dart';
import 'edit_button.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/utils.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key,
      required this.address,
      this.showEditButton = false,
      this.onEdit});
  final Address address;
  final bool showEditButton;
  final VoidCallback? onEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.brightGray, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: AppCachedNetworkImage(
                  imageUrl: getMapImageURL(
                      address.latitude,
                      address.longitude,
                      Directionality.of(context) == TextDirection.ltr
                          ? 'en'
                          : 'ar')),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.addressTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  address.fullName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${address.buildingNo}, ${address.streetNo}, ${address.country.countryName}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGray,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  address.phone,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midnightBlue,
                  ),
                ),
              ],
            ),
          ),
          if (showEditButton) EditButton(onPressed: onEdit!)
        ],
      ),
    );
  }
}
