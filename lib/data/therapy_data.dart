import 'package:flutter/material.dart';

const List<Map<String, dynamic>> nonpharmacologicalTherapies = [
  {
    'title': 'Terapi Mind Body & Relaksasi',
    'icon': Icons.self_improvement,
    'color': Colors.purple,
  },
  {
    'title': 'Terapi Fisik dan Sentuhan',
    'icon': Icons.music_note,
    'color': Colors.blue,
  },
  {
    'title': 'Terapi Herbal',
    'icon': Icons.sentiment_very_satisfied,
    'color': Colors.orange,
  },
  {
    'title': 'Terapi Spiritual',
    'icon': Icons.sentiment_very_satisfied,
    'color': Colors.orange,
  },
];

const List<Map<String, dynamic>> pharmacologicalTherapies = [
  {'title': 'Obat', 'icon': Icons.spa_outlined, 'color': Colors.pink},
];

const Map<String, List<Map<String, String>>> subTherapyMap = {
  'Terapi Mind Body & Relaksasi': [
    {
      'title': 'Yoga & Meditasi',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Pernapasan Dalam',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Terapi Musik',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Terapi Tawa',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
  ],
  'Terapi Fisik dan Sentuhan': [
    {
      'title': 'Pijat Relaksasi',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Akupuntur',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Refleksiologi',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
  ],
  'Terapi Herbal': [
    {
      'title': 'Seledri',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Bawang Putih',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Daun Salam',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
  ],
  'Terapi Spiritual': [
    {
      'title': 'Ibadah',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Murotal',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
  ],
  'Obat': [
    {
      'title': 'ACE Inhibitor',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'title': 'Beta Blocker',
      'doctor': 'Dr. Joni Jono',
      'description':
          'Lorem health care dolor sit amet, consectetur adipiscing elit.',
    },
  ],
};
