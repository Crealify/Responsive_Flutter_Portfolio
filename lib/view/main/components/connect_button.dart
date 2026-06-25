import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../res/components/premium_button.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42, bottom: 4),
      child: PremiumButton(
        text: 'WHATSAPP',
        prefixIcon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 14),
        gradient: [
          Colors.pink,
          Colors.blue.shade900,
        ],
        onTap: () {
          launchUrl(Uri.parse('https://wa.me/+9779867294376'), mode: LaunchMode.externalApplication);
        },
      ),
    );
  }
}
