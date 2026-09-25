import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/amenity_chip.dart';

class FitnessDetailScreen extends StatelessWidget {
  const FitnessDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildImageHeader(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 22),
                        SizedBox(width: 6),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '(1,232 reviews)',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mid City Gym Training',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'California, New York',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFDFE1E7),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.55,
                          letterSpacing: -0.28,
                        ),
                        children: [
                          const TextSpan(
                            text:
                            'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget tellus... ',
                          ),
                          TextSpan(
                            text: 'Read more',
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.55,
                              letterSpacing: -0.28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Amenities',
                      strutStyle: const StrutStyle(height: 1, leading: 0),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 155 / 52,
                      mainAxisExtent: 60,
                      children: const [
                        AmenityChip(icon: Icons.shower, label: 'Showers'),
                        AmenityChip(icon: Icons.lock_outline, label: 'Lockers'),
                        AmenityChip(icon: Icons.local_parking, label: 'Parking'),
                        AmenityChip(icon: Icons.wifi, label: 'Wi-Fi'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomBar()),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 360,
          width: double.infinity,
          child: Image.asset(
            'assets/images/2.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
            child: SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                      Icons.arrow_back, () => Navigator.pop(context)),
                  _circleIconButton(Icons.more_vert, () {}),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87, size: 20),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 16, 25, 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, -10),
            blurRadius: 100,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Total',
                style: TextStyle(color: AppColors.grey, fontSize: 13),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: r'$69.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' /week',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Reserve'),
          ),
        ],
      ),
    );
  }
}