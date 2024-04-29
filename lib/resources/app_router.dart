import 'package:go_router/go_router.dart';
import 'package:movies_db_app/movies/view/movies_view.dart';
import 'package:movies_db_app/pages/main_page.dart';
import 'package:movies_db_app/resources/app_routes.dart';

const String moviesPath = '/movies';

class AppRouter {
  GoRouter router = GoRouter(initialLocation: moviesPath, routes: [
    ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.moviesRoute,
            path: moviesPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoviesView(),
            ),
          )
        ])
  ]);
}
