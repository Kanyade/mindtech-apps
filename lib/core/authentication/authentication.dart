import 'dart:async';
import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/core/authentication/models/get_account_request.jsn.dart';
import 'package:io_mindtechapps_hw/core/authentication/models/user_account.jsn.dart';
import 'package:io_mindtechapps_hw/core/bloc_base/base_bloc.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/http/dio_extensions.dart';
import 'package:io_mindtechapps_hw/core/services/user_preference.dart';
import 'package:io_mindtechapps_hw/core/utils/disposable_refresh_repository.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/future_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';
import 'package:rxdart/rxdart.dart';

part 'bloc/bloc.dart';
part 'bloc/event.dart';
part 'bloc/state.dart';
part 'repository.dart';
