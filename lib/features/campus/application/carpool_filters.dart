import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/ride.dart';

final carpoolDirectionFilterProvider = StateProvider<RideDirection>((ref) => RideDirection.toCampus);

/// `null` means "no preference" — show every ride regardless of the
/// driver's own gender-preference setting.
final carpoolGenderFilterProvider = StateProvider<GenderPreference?>((ref) => null);
