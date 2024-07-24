
import 'dart:io';

import 'package:uuid/uuid.dart';

const uudi = Uuid();

class Place {
  Place({
    required this.title,
    required this.image
  }) : id = uudi.v4();

  final String id;
  final String title;
  final File image;
}