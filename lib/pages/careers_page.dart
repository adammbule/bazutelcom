import 'package:flutter/material.dart';
import '../widgets/page_layout.dart';
import '../widgets/page_hero.dart';
import '../widgets/job_card.dart';
import '../widgets/section_title.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        const PageHero(
          title: 'Careers at Bazu Telecom',
          subtitle: 'Join our growing team and help connect Bungoma to the world.',
          compact: true,
        ),
        SectionContainer(
          child: Column(
            children: [
              const SectionTitle(
                'Open Positions',
                subtitle: 'We\'re looking for motivated interns to grow with us.',
              ),
              const SizedBox(height: 40),
              JobCard(
                title: 'Network Technician Intern',
                description:
                    'Responsible for fiber installation, WiFi hotspot setup, and network configurations.',
                onApply: () => Navigator.pushNamed(
                  context,
                  '/apply',
                  arguments: 'Network Technician Intern',
                ),
              ),
              JobCard(
                title: 'Sales & Marketing Intern',
                description:
                    'Help connect customers in Bungoma to high-speed fiber and hotspot services.',
                onApply: () => Navigator.pushNamed(
                  context,
                  '/apply',
                  arguments: 'Sales & Marketing Intern',
                ),
              ),
              JobCard(
                title: 'Customer Experience Intern',
                description:
                    'Offer customer assistance, ticketing, and service coordination.',
                onApply: () => Navigator.pushNamed(
                  context,
                  '/apply',
                  arguments: 'Customer Experience Intern',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
