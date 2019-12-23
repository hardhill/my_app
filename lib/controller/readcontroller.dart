import 'dart:async';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';

List reads = [
  {'title': 'Большое яблоко', 'author': 'Криворучко С.П.', 'year': '2001'},
  {'title': 'Падение с небес', 'author': 'Кириллов А.П.', 'year': '2000'},
  {'title': 'Каменное болото', 'author': 'Васильева З.Ф.', 'year': '1997'},
  {'title': 'Бег как смысл поэмы', 'author': 'Занудин М.Н.', 'year': '2002'}
];

class ReadsController extends ResourceController {
  @Operation.get()
  Future<Response> getAllRead() async {
    return Response.ok(reads);
  }

  @Operation.get('id')
  Future<Response> getReadById(@Bind.path('id') int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: 'Data not found by ID');
    }
    final body = await reads[id];
    return Response.ok(body);
  }

  @Operation.post()
  Future<Response> createNewRead() async {
    final Map<String, dynamic> body = request.body.as();
    reads.add(body);
    return Response.ok(body);
  }

  @Operation.put('id')
  Future<Response> updateRead(@Bind.path('id') int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: 'Item not found');
    }
    final Map<String, dynamic> body = request.body.as();
    reads[id] = body;
    return Response.ok('Update data of reads');
  }

  @Operation.delete('id')
  Future<Response> deleteRead(@Bind.path('id') int id) async {
    if (id < 0 || id > reads.length - 1) {
      return Response.notFound(body: 'Item not found');
    }
    await reads.removeAt(id);
    return Response.ok('Delete data');
  }
}
