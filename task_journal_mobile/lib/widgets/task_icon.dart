import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_journal_mobile/constants.dart';
import 'package:task_journal_mobile/utils/theme.dart';

class TaskIcon extends StatelessWidget {

  final String taskIcon;

  const TaskIcon({ super.key, required this.taskIcon });

  @override
  Widget build(BuildContext context) {

    Color? backgroundColor;
    switch (taskIcon) {
      case 'job':
        backgroundColor = const Color(0xFFDBE9FF);
        break;
      case 'doctor_appointment':
        backgroundColor = const Color(0xFFE80000);
        break;
      case 'mechanic':
      case 'electrician':
      case 'transport':
        backgroundColor = const Color(0xFFFFD500);
        break;
      case 'cleaning':
      case 'swimming':
        backgroundColor = const Color(0xFF3BA9FF);
        break;
      case 'gym':
        backgroundColor = const Color(0xFF878787);
        break;
      case 'basketball':
        backgroundColor = const Color(0xFFFF7E0D);
        break;
      case 'football':
        backgroundColor = const Color(0xFF00C224);
        break;
      case 'american_football':
        backgroundColor = const Color(0xFF693900);
        break;
      case 'volleyball':
        backgroundColor = const Color(0xFFFFDE21);
        break;
      case 'concert':
        backgroundColor = const Color(0xFFAB00C9);
        break;
      case 'movie':
      case 'meeting':
        backgroundColor = white;
        break;
      case 'reading':
        backgroundColor = const Color(0xFF42FFE3);
        break;
      case 'writing':
        backgroundColor = const Color(0xFFC4E856);
        break;
      case 'payment':
        backgroundColor = const Color(0xFF39D450);
        break;
      case 'message':
        backgroundColor = const Color(0xFF1AB3F0);
        break;
      case 'photography':
      case 'moving':
      case 'running':
        backgroundColor = const Color(0xFFFCB86A);
        break;
      case 'drive':
        backgroundColor = const Color(0xFF048FD4);
        break;
      case 'shopping':
        backgroundColor = const Color(0xFFD19847);
        break;
      case 'coffee':
        backgroundColor = const Color(0xFFAD6A0A);
        break;
      case 'sailing':
        backgroundColor = const Color(0xFF17E8FF);
        break;
      case 'church':
        backgroundColor = const Color(0xFFFFF175);
        break;
      case 'pets':
        backgroundColor = const Color(0xFFC48000);
        break;
      case 'plants':
        backgroundColor = const Color(0xFF228C23);
        break;
      case 'lunch':
        backgroundColor = const Color(0xFFFFEE52);
        break;
      case 'phone_call':
        backgroundColor = const Color(0xFF69C0FF);
        break;
      case 'computer':
        backgroundColor = const Color(0xFF0C9EF2);
        break;
      case 'party':
        backgroundColor = const Color(0xFFBD38FF);
        break;
      default:
        backgroundColor = black;
        break;
    }

    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: kSmallIconSize,
      child: switch (taskIcon) {
        'job' => const FaIcon(FontAwesomeIcons.suitcase, color: Color(0xFFC48000)),
        'doctor_appointment' => const FaIcon(FontAwesomeIcons.userDoctor, color: white),
        'mechanic' => const FaIcon(FontAwesomeIcons.wrench, color: Color(0xFF878787)),
        'cleaning' => const FaIcon(FontAwesomeIcons.broom, color: Color(0xFFAD6A0A)),
        'gym' => const FaIcon(FontAwesomeIcons.dumbbell, color: black),
        'swimming' => const FaIcon(FontAwesomeIcons.personSwimming, color: white),
        'running' => const FaIcon(FontAwesomeIcons.personRunning, color: white),
        'basketball' => const FaIcon(FontAwesomeIcons.basketball , color: black),
        'football' => const FaIcon(FontAwesomeIcons.futbol , color: black),
        'american_football' => const FaIcon(FontAwesomeIcons.football , color: white),
        'volleyball' => const FaIcon(FontAwesomeIcons.volleyball , color: Color(0xFF0C2F68)),
        'concert' => const FaIcon(FontAwesomeIcons.music, color: white), 
        'movie' => const FaIcon(FontAwesomeIcons.film , color: black),
        'meeting' => const FaIcon(FontAwesomeIcons.users , color: black),
        'transport' => const FaIcon(FontAwesomeIcons.truck , color: black),
        'reading' => const FaIcon(FontAwesomeIcons.bookOpenReader , color: white),
        'writing' => const FaIcon(FontAwesomeIcons.pencil , color: black),
        'payment' => const FaIcon(FontAwesomeIcons.moneyBillTransfer , color: white),
        'message' => const FaIcon(FontAwesomeIcons.message , color: white),
        'photography' => const FaIcon(FontAwesomeIcons.cameraRetro , color: black),
        'drive' => const FaIcon(FontAwesomeIcons.carSide , color: black),
        'shopping' => const FaIcon(FontAwesomeIcons.cartShopping , color: Color(0xFF878787)),
        'coffee' => const FaIcon(FontAwesomeIcons.mugHot , color: white),
        'sailing' => const FaIcon(FontAwesomeIcons.anchor , color: Color(0xFF545454)),
        'church' => const FaIcon(FontAwesomeIcons.church , color: black),
        'pets' => const FaIcon(FontAwesomeIcons.paw , color: black),
        'plants' => const FaIcon(FontAwesomeIcons.seedling , color: Color(0xFF3EC966)),
        'lunch' => const FaIcon(FontAwesomeIcons.utensils , color: Color(0xFFC6C6CC)),
        'phone_call' => const FaIcon(FontAwesomeIcons.phone , color: black),
        'computer' => const FaIcon(FontAwesomeIcons.computer , color: white),
        'moving' => const FaIcon(FontAwesomeIcons.boxesStacked , color: Color(0xFFA97835)),
        'electrician' => const FaIcon(FontAwesomeIcons.bolt , color: black),
        'party' => const FaIcon(FontAwesomeIcons.champagneGlasses , color: Color(0xFFDBE5E5)),
        _ => const FaIcon(FontAwesomeIcons.question, color: white,)
      },
    );
  }
  
}