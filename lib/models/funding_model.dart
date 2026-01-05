import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

class FundingSponsor {
  final String name;
  final String platform;
  final String url;
  final Color? color;
  final IconData icon;

  const FundingSponsor({
    required this.name,
    required this.platform,
    required this.url,
    this.color,
    required this.icon,
  });
}

const sponsors = <FundingSponsor>[
  FundingSponsor(
    name: 'PartyDonut',
    platform: 'Github Sponsors',
    url: 'https://github.com/sponsors/PartyDonut',
    color: Color.fromARGB(255, 198, 68, 172),
    icon: IconsaxPlusLinear.heart,
  ),
  FundingSponsor(
    name: 'jopknaapen',
    platform: 'Buy me a Coffee',
    color: Color.fromARGB(255, 255, 220, 19),
    url: 'https://buymeacoffee.com/jopknaapen',
    icon: Icons.coffee,
  ),
];
