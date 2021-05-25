import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../models/app_state.dart';
import 'auth_reducer.dart';

AppState appStateReducer(AppState state, action) =>
    AppState(authState: authStateReducer(state.authState, action));

final store = Store(appStateReducer,
    initialState: AppState.initialState(),
    middleware: [LoggingMiddleware.printer()]);
