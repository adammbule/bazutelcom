import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 700;

    return Container(
      color: AppColors.footerBg,
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 24 : 48,
        vertical: 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              if (isNarrow)
                _buildMobileContent(context)
              else
                _buildDesktopContent(context),
              const SizedBox(height: 40),
              const Divider(color: Color(0xFF1E3A5F)),
              const SizedBox(height: 24),
              Text(
                '© ${DateTime.now().year} Bazu Telecom Ltd. All rights reserved.',
                style: GoogleFonts.inter(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _brandSection()),
        Expanded(child: _linkColumn(context, 'Company', [
          ('About Us', '/about'),
          ('Careers', '/careers'),
          ('Contact', '/contact'),
        ])),
        Expanded(child: _linkColumn(context, 'Services', [
          ('Our Services', '/services'),
          ('Products', '/products'),
          ('Hotspot Map', '/services'),
        ])),
        Expanded(child: _contactColumn()),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _brandSection(),
        const SizedBox(height: 32),
        _linkColumn(context, 'Company', [
          ('About Us', '/about'),
          ('Careers', '/careers'),
          ('Contact', '/contact'),
        ]),
        const SizedBox(height: 24),
        _linkColumn(context, 'Services', [
          ('Our Services', '/services'),
          ('Products', '/products'),
        ]),
        const SizedBox(height: 24),
        _contactColumn(),
      ],
    );
  }

  Widget _brandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.wifi_tethering, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              'Bazu Telecom Ltd',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Reliable internet solutions for homes, businesses, and institutions across Bungoma Town.',
          style: GoogleFonts.inter(
            color: Colors.white60,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _linkColumn(BuildContext context, String title, List<(String, String)> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, link.$2),
              child: Text(
                link.$1,
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _contactItem(Icons.location_on_outlined, 'Bungoma Town, Kenya'),
        const SizedBox(height: 10),
        _contactItem(Icons.phone_outlined, '+254 7XX XXX XXX'),
        const SizedBox(height: 10),
        _contactItem(Icons.email_outlined, 'info@bazutel.com'),
      ],
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 18),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
        ),
      ],
    );
  }
}
