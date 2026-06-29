import 'package:dio/dio.dart';
import 'package:ppkd_b6/tugas14/models/got_character.dart';
import 'package:ppkd_b6/tugas14/models/got_books.dart';
import 'package:ppkd_b6/tugas14/models/got_houses.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://thronesapi.com/api/v2')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/Characters')
  Future<List<GotCharacter>> getCharacters();

  @GET('/Characters/{id}')
  Future<GotCharacter> getCharacterById(@Path('id') int id);

  @GET('https://www.anapioficeandfire.com/api/books')
  Future<List<GotBooks>> getBooks();

  @GET('https://www.anapioficeandfire.com/api/houses')
  Future<List<GotHouses>> getHouses();
}
