import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_db_app/core/domain/entities/media.dart';
import 'package:movies_db_app/core/presentation/components/error_screen.dart';
import 'package:movies_db_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_db_app/core/utils/enums.dart';
import 'package:movies_db_app/movies/movies_bloc/movies_bloc.dart';
import 'package:movies_db_app/movies/movies_bloc/movies_event.dart';
import 'package:movies_db_app/movies/movies_bloc/movies_state.dart';
import 'package:movies_db_app/services/service_locator.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              switch (state.status) {
                case RequestStatus.loading:
                  return const LoadingIndicator();
                case RequestStatus.loaded:
                  return MoviesWidget(
                    popularMovies: state.movies[0],
                    topRatedMovies: state.movies[1],
                  );
                case RequestStatus.error:
                  return ErrorScreen(
                    onTryAgainPressed: () {
                      context.read<MoviesBloc>().add(GetMoviesEvent());
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MoviesWidget extends StatelessWidget {
  final List<Media> popularMovies;
  final List<Media> topRatedMovies;

  const MoviesWidget({
    super.key,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal ListView
          Container(
            height: 120, // Set a specific height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  margin: const EdgeInsets.all(8),
                  child: Center(
                    child: Text('$index -> ${popularMovies[index].title}'),
                  ),
                );
              },
            ),
          ),

          // Vertical ListView
          Container(
            color: Colors.yellow,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: topRatedMovies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index ->> ${topRatedMovies[index].title}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
