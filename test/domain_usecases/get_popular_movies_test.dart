import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/domain/usecases/get_popular_movies.dart';

import 'get_trending_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main(){
  late GetPopularMovies useCase;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    useCase = GetPopularMovies(repository: mockMovieRepository);
  });

  final pMoviesList = [
    Movie(id: 1, title: "Test movies 1", overview: "Desc 1", posterPath: "/image1", year: "2021"),
    Movie(id: 2, title: "Test movies 2", overview: "Desc 2", posterPath: "/image2", year: "2022")
  ];

  test('should get a list of popular movies', () async{
    when(mockMovieRepository.getPopularMovies()).thenAnswer((realInvocation) async=> pMoviesList);

    final result = await useCase();

    expect(result, pMoviesList);

    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}