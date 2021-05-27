import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../../../../models/navigation.dart';
import '../models/app_state.dart';
import 'auth_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) =>
    AppState(authState: authStateReducer(state.authState, action));

Navigation navigation = Navigation();

LoggingMiddleware logger = LoggingMiddleware.printer();

final store = Store(appStateReducer,
    initialState: AppState.initialState(),
    middleware: [navigation.navigationMiddleware]);
