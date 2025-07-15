import 'package:fpdart/fpdart.dart';
import 'package:drift/drift.dart';
import 'package:sakudok/core/database/app_database.dart';
import '../../domain/entities/document.dart' as domain;
import '../mappers/document_mapper.dart';
import 'dart:convert';

abstract class DocumentLocalDataSource {
  Future<Either<String, List<domain.Document>>> getAllDocuments();
  Future<Either<String, domain.Document>> getDocumentById(int id);
  Future<Either<String, domain.Document>> addDocument(domain.Document document);
  Future<Either<String, domain.Document>> updateDocument(domain.Document document);
  Future<Either<String, bool>> deleteDocument(int id);
  Future<Either<String, List<domain.Document>>> searchDocuments(String query);
  Future<Either<String, List<domain.Document>>> getDocumentsByType(String type);
  Future<Either<String, List<domain.Document>>> getExpiringDocuments(int daysThreshold);
}

class DocumentLocalDataSourceImpl implements DocumentLocalDataSource {
  final AppDatabase database;

  DocumentLocalDataSourceImpl(this.database);

  @override
  Future<Either<String, List<domain.Document>>> getAllDocuments() async {
    try {
      final dbDocs = await database.getAllDocuments();
      final domainDocs = dbDocs.map(DocumentMapper.fromDb).toList();
      return right(domainDocs);
    } catch (e) {
      return left('Gagal mengambil dokumen: $e');
    }
  }

  @override
  Future<Either<String, domain.Document>> getDocumentById(int id) async {
    try {
      final dbDoc = await database.getDocumentById(id);
      if (dbDoc == null) {
        return left('Dokumen tidak ditemukan');
      }
      return right(DocumentMapper.fromDb(dbDoc));
    } catch (e) {
      return left('Gagal mengambil dokumen: $e');
    }
  }

  @override
  Future<Either<String, domain.Document>> addDocument(domain.Document document) async {
    try {
      final documentCompanion = DocumentMapper.toDbInsert(document);
      final id = await database.insertDocument(documentCompanion);
      final newDocument = document.copyWith(id: id);
      return right(newDocument);
    } catch (e) {
      return left('Gagal menambah dokumen: $e');
    }
  }

  @override
  Future<Either<String, domain.Document>> updateDocument(domain.Document document) async {
    try {
      final documentCompanion = DocumentMapper.toDbUpdate(document);
      await database.updateDocument(documentCompanion);
      return right(document.copyWith(updatedAt: DateTime.now()));
    } catch (e) {
      return left('Gagal mengupdate dokumen: $e');
    }
  }

  @override
  Future<Either<String, bool>> deleteDocument(int id) async {
    try {
      await database.deleteDocument(id);
      return right(true);
    } catch (e) {
      return left('Gagal menghapus dokumen: $e');
    }
  }

  @override
  Future<Either<String, List<domain.Document>>> searchDocuments(String query) async {
    try {
      final dbDocs = await database.searchDocuments(query);
      final domainDocs = dbDocs.map(DocumentMapper.fromDb).toList();
      return right(domainDocs);
    } catch (e) {
      return left('Gagal mencari dokumen: $e');
    }
  }

  @override
  Future<Either<String, List<domain.Document>>> getDocumentsByType(String type) async {
    try {
      final dbDocs = await database.getDocumentsByType(type);
      final domainDocs = dbDocs.map(DocumentMapper.fromDb).toList();
      return right(domainDocs);
    } catch (e) {
      return left('Gagal mengambil dokumen berdasarkan tipe: $e');
    }
  }

  @override
  Future<Either<String, List<domain.Document>>> getExpiringDocuments(int daysThreshold) async {
    try {
      final dbDocs = await database.getExpiringDocuments(daysThreshold);
      final domainDocs = dbDocs.map(DocumentMapper.fromDb).toList();
      return right(domainDocs);
    } catch (e) {
      return left('Gagal mengambil dokumen yang akan kadaluarsa: $e');
    }
  }
}
