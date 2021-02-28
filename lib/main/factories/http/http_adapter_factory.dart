import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/infra/infra.dart';
import 'package:http/http.dart';

HttpClient httpAdapter() => HttpAdapter(client: Client());
