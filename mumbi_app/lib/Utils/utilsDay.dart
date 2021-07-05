// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/foundation.dart';

/// Example event class.
class Event {
   String dateTime;
  Event({@required this.dateTime});

  String toString() => this.dateTime;
}
