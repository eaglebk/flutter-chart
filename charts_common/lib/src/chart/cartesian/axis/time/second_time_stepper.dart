// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../../../../../common.dart';
import '../../../../common/date_time_factory.dart' show DateTimeFactory;
import 'base_time_stepper.dart';

class SecondTimeStepper extends BaseTimeStepper{
  static const _defaultIncrements = [5, 10, 15, 20, 30];
  static const _millisecondsInSecond = 1000;

  final List<int> _allowedTickIncrements;

  SecondTimeStepper._internal(
      DateTimeFactory dateTimeFactory, List<int> increments)
      : _allowedTickIncrements = increments,
        super(dateTimeFactory);

  factory SecondTimeStepper(DateTimeFactory dateTimeFactory,
      {List<int> allowedTickIncrements}) {
    // Set the default increments if null.
    allowedTickIncrements ??= _defaultIncrements;

    // Must have at least one increment
    assert(allowedTickIncrements.isNotEmpty);
    // Increment must be between 1 and 60 inclusive.
    assert(allowedTickIncrements
        .any((increment) => increment <= 0 || increment > 60) ==
        false);

    return SecondTimeStepper._internal(dateTimeFactory, allowedTickIncrements);
  }

  @override
  int get typicalStepSizeMs => _millisecondsInSecond;

  @override
  List<int> get allowedTickIncrements => _allowedTickIncrements;

  @override
  DateTime getNextStepTime(DateTime time, int tickIncrement) {
    return time.add(Duration(seconds: tickIncrement));
  }

  @override
  DateTime getStepTimeBeforeInclusive(DateTime time, int tickIncrement) {
    final nextMinuteStart = time.millisecondsSinceEpoch +
        (60 - time.second) * _millisecondsInSecond;

    final secondsToNextMinute =
    ((nextMinuteStart - time.millisecondsSinceEpoch) / _millisecondsInSecond)
        .ceil();

    final secRemainder = secondsToNextMinute % tickIncrement;
    final rewindSeconds = secRemainder == 0 ? 0 : tickIncrement - secRemainder;

    final stepBefore = dateTimeFactory.createDateTimeFromMilliSecondsSinceEpoch(
        time.millisecondsSinceEpoch - rewindSeconds * _millisecondsInSecond);
    return stepBefore;
  }


}