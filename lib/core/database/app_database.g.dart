// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathsMeta = const VerificationMeta(
    'filePaths',
  );
  @override
  late final GeneratedColumn<String> filePaths = GeneratedColumn<String>(
    'file_paths',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasReminderMeta = const VerificationMeta(
    'hasReminder',
  );
  @override
  late final GeneratedColumn<bool> hasReminder = GeneratedColumn<bool>(
    'has_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderDateMeta = const VerificationMeta(
    'reminderDate',
  );
  @override
  late final GeneratedColumn<DateTime> reminderDate = GeneratedColumn<DateTime>(
    'reminder_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderNoteMeta = const VerificationMeta(
    'reminderNote',
  );
  @override
  late final GeneratedColumn<String> reminderNote = GeneratedColumn<String>(
    'reminder_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEncryptedMeta = const VerificationMeta(
    'isEncrypted',
  );
  @override
  late final GeneratedColumn<bool> isEncrypted = GeneratedColumn<bool>(
    'is_encrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_encrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bundleIdMeta = const VerificationMeta(
    'bundleId',
  );
  @override
  late final GeneratedColumn<int> bundleId = GeneratedColumn<int>(
    'bundle_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    type,
    filePaths,
    createdAt,
    updatedAt,
    description,
    hasReminder,
    reminderDate,
    reminderNote,
    isEncrypted,
    tags,
    bundleId,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('file_paths')) {
      context.handle(
        _filePathsMeta,
        filePaths.isAcceptableOrUnknown(data['file_paths']!, _filePathsMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('has_reminder')) {
      context.handle(
        _hasReminderMeta,
        hasReminder.isAcceptableOrUnknown(
          data['has_reminder']!,
          _hasReminderMeta,
        ),
      );
    }
    if (data.containsKey('reminder_date')) {
      context.handle(
        _reminderDateMeta,
        reminderDate.isAcceptableOrUnknown(
          data['reminder_date']!,
          _reminderDateMeta,
        ),
      );
    }
    if (data.containsKey('reminder_note')) {
      context.handle(
        _reminderNoteMeta,
        reminderNote.isAcceptableOrUnknown(
          data['reminder_note']!,
          _reminderNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_encrypted')) {
      context.handle(
        _isEncryptedMeta,
        isEncrypted.isAcceptableOrUnknown(
          data['is_encrypted']!,
          _isEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('bundle_id')) {
      context.handle(
        _bundleIdMeta,
        bundleId.isAcceptableOrUnknown(data['bundle_id']!, _bundleIdMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      filePaths: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_paths'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      hasReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_reminder'],
      )!,
      reminderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_date'],
      ),
      reminderNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_note'],
      ),
      isEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_encrypted'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      bundleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bundle_id'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final String title;
  final String type;
  final String filePaths;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;
  final bool hasReminder;
  final DateTime? reminderDate;
  final String? reminderNote;
  final bool isEncrypted;
  final String? tags;
  final int? bundleId;
  final String metadata;
  const Document({
    required this.id,
    required this.title,
    required this.type,
    required this.filePaths,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    required this.hasReminder,
    this.reminderDate,
    this.reminderNote,
    required this.isEncrypted,
    this.tags,
    this.bundleId,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['file_paths'] = Variable<String>(filePaths);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['has_reminder'] = Variable<bool>(hasReminder);
    if (!nullToAbsent || reminderDate != null) {
      map['reminder_date'] = Variable<DateTime>(reminderDate);
    }
    if (!nullToAbsent || reminderNote != null) {
      map['reminder_note'] = Variable<String>(reminderNote);
    }
    map['is_encrypted'] = Variable<bool>(isEncrypted);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || bundleId != null) {
      map['bundle_id'] = Variable<int>(bundleId);
    }
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      filePaths: Value(filePaths),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      hasReminder: Value(hasReminder),
      reminderDate: reminderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDate),
      reminderNote: reminderNote == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderNote),
      isEncrypted: Value(isEncrypted),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      bundleId: bundleId == null && nullToAbsent
          ? const Value.absent()
          : Value(bundleId),
      metadata: Value(metadata),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      filePaths: serializer.fromJson<String>(json['filePaths']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      description: serializer.fromJson<String?>(json['description']),
      hasReminder: serializer.fromJson<bool>(json['hasReminder']),
      reminderDate: serializer.fromJson<DateTime?>(json['reminderDate']),
      reminderNote: serializer.fromJson<String?>(json['reminderNote']),
      isEncrypted: serializer.fromJson<bool>(json['isEncrypted']),
      tags: serializer.fromJson<String?>(json['tags']),
      bundleId: serializer.fromJson<int?>(json['bundleId']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'filePaths': serializer.toJson<String>(filePaths),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'description': serializer.toJson<String?>(description),
      'hasReminder': serializer.toJson<bool>(hasReminder),
      'reminderDate': serializer.toJson<DateTime?>(reminderDate),
      'reminderNote': serializer.toJson<String?>(reminderNote),
      'isEncrypted': serializer.toJson<bool>(isEncrypted),
      'tags': serializer.toJson<String?>(tags),
      'bundleId': serializer.toJson<int?>(bundleId),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  Document copyWith({
    int? id,
    String? title,
    String? type,
    String? filePaths,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> description = const Value.absent(),
    bool? hasReminder,
    Value<DateTime?> reminderDate = const Value.absent(),
    Value<String?> reminderNote = const Value.absent(),
    bool? isEncrypted,
    Value<String?> tags = const Value.absent(),
    Value<int?> bundleId = const Value.absent(),
    String? metadata,
  }) => Document(
    id: id ?? this.id,
    title: title ?? this.title,
    type: type ?? this.type,
    filePaths: filePaths ?? this.filePaths,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    description: description.present ? description.value : this.description,
    hasReminder: hasReminder ?? this.hasReminder,
    reminderDate: reminderDate.present ? reminderDate.value : this.reminderDate,
    reminderNote: reminderNote.present ? reminderNote.value : this.reminderNote,
    isEncrypted: isEncrypted ?? this.isEncrypted,
    tags: tags.present ? tags.value : this.tags,
    bundleId: bundleId.present ? bundleId.value : this.bundleId,
    metadata: metadata ?? this.metadata,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      filePaths: data.filePaths.present ? data.filePaths.value : this.filePaths,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      description: data.description.present
          ? data.description.value
          : this.description,
      hasReminder: data.hasReminder.present
          ? data.hasReminder.value
          : this.hasReminder,
      reminderDate: data.reminderDate.present
          ? data.reminderDate.value
          : this.reminderDate,
      reminderNote: data.reminderNote.present
          ? data.reminderNote.value
          : this.reminderNote,
      isEncrypted: data.isEncrypted.present
          ? data.isEncrypted.value
          : this.isEncrypted,
      tags: data.tags.present ? data.tags.value : this.tags,
      bundleId: data.bundleId.present ? data.bundleId.value : this.bundleId,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('filePaths: $filePaths, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('description: $description, ')
          ..write('hasReminder: $hasReminder, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('reminderNote: $reminderNote, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('tags: $tags, ')
          ..write('bundleId: $bundleId, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    type,
    filePaths,
    createdAt,
    updatedAt,
    description,
    hasReminder,
    reminderDate,
    reminderNote,
    isEncrypted,
    tags,
    bundleId,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.filePaths == this.filePaths &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.description == this.description &&
          other.hasReminder == this.hasReminder &&
          other.reminderDate == this.reminderDate &&
          other.reminderNote == this.reminderNote &&
          other.isEncrypted == this.isEncrypted &&
          other.tags == this.tags &&
          other.bundleId == this.bundleId &&
          other.metadata == this.metadata);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> type;
  final Value<String> filePaths;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> description;
  final Value<bool> hasReminder;
  final Value<DateTime?> reminderDate;
  final Value<String?> reminderNote;
  final Value<bool> isEncrypted;
  final Value<String?> tags;
  final Value<int?> bundleId;
  final Value<String> metadata;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.filePaths = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.description = const Value.absent(),
    this.hasReminder = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.reminderNote = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    this.tags = const Value.absent(),
    this.bundleId = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String type,
    required String filePaths,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.description = const Value.absent(),
    this.hasReminder = const Value.absent(),
    this.reminderDate = const Value.absent(),
    this.reminderNote = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    this.tags = const Value.absent(),
    this.bundleId = const Value.absent(),
    this.metadata = const Value.absent(),
  }) : title = Value(title),
       type = Value(type),
       filePaths = Value(filePaths);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? filePaths,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? description,
    Expression<bool>? hasReminder,
    Expression<DateTime>? reminderDate,
    Expression<String>? reminderNote,
    Expression<bool>? isEncrypted,
    Expression<String>? tags,
    Expression<int>? bundleId,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (filePaths != null) 'file_paths': filePaths,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (description != null) 'description': description,
      if (hasReminder != null) 'has_reminder': hasReminder,
      if (reminderDate != null) 'reminder_date': reminderDate,
      if (reminderNote != null) 'reminder_note': reminderNote,
      if (isEncrypted != null) 'is_encrypted': isEncrypted,
      if (tags != null) 'tags': tags,
      if (bundleId != null) 'bundle_id': bundleId,
      if (metadata != null) 'metadata': metadata,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? type,
    Value<String>? filePaths,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? description,
    Value<bool>? hasReminder,
    Value<DateTime?>? reminderDate,
    Value<String?>? reminderNote,
    Value<bool>? isEncrypted,
    Value<String?>? tags,
    Value<int?>? bundleId,
    Value<String>? metadata,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      filePaths: filePaths ?? this.filePaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      hasReminder: hasReminder ?? this.hasReminder,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderNote: reminderNote ?? this.reminderNote,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      tags: tags ?? this.tags,
      bundleId: bundleId ?? this.bundleId,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (filePaths.present) {
      map['file_paths'] = Variable<String>(filePaths.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (hasReminder.present) {
      map['has_reminder'] = Variable<bool>(hasReminder.value);
    }
    if (reminderDate.present) {
      map['reminder_date'] = Variable<DateTime>(reminderDate.value);
    }
    if (reminderNote.present) {
      map['reminder_note'] = Variable<String>(reminderNote.value);
    }
    if (isEncrypted.present) {
      map['is_encrypted'] = Variable<bool>(isEncrypted.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (bundleId.present) {
      map['bundle_id'] = Variable<int>(bundleId.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('filePaths: $filePaths, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('description: $description, ')
          ..write('hasReminder: $hasReminder, ')
          ..write('reminderDate: $reminderDate, ')
          ..write('reminderNote: $reminderNote, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('tags: $tags, ')
          ..write('bundleId: $bundleId, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

class $BundlesTable extends Bundles with TableInfo<$BundlesTable, Bundle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BundlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateMeta = const VerificationMeta(
    'template',
  );
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
    'template',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    template,
    groupId,
    createdAt,
    updatedAt,
    isDefault,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bundle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('template')) {
      context.handle(
        _templateMeta,
        template.isAcceptableOrUnknown(data['template']!, _templateMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bundle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bundle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      template: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $BundlesTable createAlias(String alias) {
    return $BundlesTable(attachedDatabase, alias);
  }
}

class Bundle extends DataClass implements Insertable<Bundle> {
  final int id;
  final String name;
  final String? description;
  final String? template;
  final int? groupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDefault;
  const Bundle({
    required this.id,
    required this.name,
    this.description,
    this.template,
    this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || template != null) {
      map['template'] = Variable<String>(template);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  BundlesCompanion toCompanion(bool nullToAbsent) {
    return BundlesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      template: template == null && nullToAbsent
          ? const Value.absent()
          : Value(template),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDefault: Value(isDefault),
    );
  }

  factory Bundle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bundle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      template: serializer.fromJson<String?>(json['template']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'template': serializer.toJson<String?>(template),
      'groupId': serializer.toJson<int?>(groupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  Bundle copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> template = const Value.absent(),
    Value<int?> groupId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDefault,
  }) => Bundle(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    template: template.present ? template.value : this.template,
    groupId: groupId.present ? groupId.value : this.groupId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDefault: isDefault ?? this.isDefault,
  );
  Bundle copyWithCompanion(BundlesCompanion data) {
    return Bundle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      template: data.template.present ? data.template.value : this.template,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bundle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('template: $template, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    template,
    groupId,
    createdAt,
    updatedAt,
    isDefault,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bundle &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.template == this.template &&
          other.groupId == this.groupId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDefault == this.isDefault);
}

class BundlesCompanion extends UpdateCompanion<Bundle> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> template;
  final Value<int?> groupId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDefault;
  const BundlesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.template = const Value.absent(),
    this.groupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  BundlesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.template = const Value.absent(),
    this.groupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDefault = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Bundle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? template,
    Expression<int>? groupId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (template != null) 'template': template,
      if (groupId != null) 'group_id': groupId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  BundlesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? template,
    Value<int?>? groupId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDefault,
  }) {
    return BundlesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      template: template ?? this.template,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundlesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('template: $template, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $BundleDocumentsTable extends BundleDocuments
    with TableInfo<$BundleDocumentsTable, BundleDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BundleDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bundleIdMeta = const VerificationMeta(
    'bundleId',
  );
  @override
  late final GeneratedColumn<int> bundleId = GeneratedColumn<int>(
    'bundle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bundles (id)',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<int> documentId = GeneratedColumn<int>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bundleId, documentId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundle_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<BundleDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bundle_id')) {
      context.handle(
        _bundleIdMeta,
        bundleId.isAcceptableOrUnknown(data['bundle_id']!, _bundleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bundleIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BundleDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BundleDocument(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bundleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bundle_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $BundleDocumentsTable createAlias(String alias) {
    return $BundleDocumentsTable(attachedDatabase, alias);
  }
}

class BundleDocument extends DataClass implements Insertable<BundleDocument> {
  final int id;
  final int bundleId;
  final int documentId;
  final DateTime addedAt;
  const BundleDocument({
    required this.id,
    required this.bundleId,
    required this.documentId,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bundle_id'] = Variable<int>(bundleId);
    map['document_id'] = Variable<int>(documentId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  BundleDocumentsCompanion toCompanion(bool nullToAbsent) {
    return BundleDocumentsCompanion(
      id: Value(id),
      bundleId: Value(bundleId),
      documentId: Value(documentId),
      addedAt: Value(addedAt),
    );
  }

  factory BundleDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BundleDocument(
      id: serializer.fromJson<int>(json['id']),
      bundleId: serializer.fromJson<int>(json['bundleId']),
      documentId: serializer.fromJson<int>(json['documentId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bundleId': serializer.toJson<int>(bundleId),
      'documentId': serializer.toJson<int>(documentId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  BundleDocument copyWith({
    int? id,
    int? bundleId,
    int? documentId,
    DateTime? addedAt,
  }) => BundleDocument(
    id: id ?? this.id,
    bundleId: bundleId ?? this.bundleId,
    documentId: documentId ?? this.documentId,
    addedAt: addedAt ?? this.addedAt,
  );
  BundleDocument copyWithCompanion(BundleDocumentsCompanion data) {
    return BundleDocument(
      id: data.id.present ? data.id.value : this.id,
      bundleId: data.bundleId.present ? data.bundleId.value : this.bundleId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BundleDocument(')
          ..write('id: $id, ')
          ..write('bundleId: $bundleId, ')
          ..write('documentId: $documentId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bundleId, documentId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BundleDocument &&
          other.id == this.id &&
          other.bundleId == this.bundleId &&
          other.documentId == this.documentId &&
          other.addedAt == this.addedAt);
}

class BundleDocumentsCompanion extends UpdateCompanion<BundleDocument> {
  final Value<int> id;
  final Value<int> bundleId;
  final Value<int> documentId;
  final Value<DateTime> addedAt;
  const BundleDocumentsCompanion({
    this.id = const Value.absent(),
    this.bundleId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  BundleDocumentsCompanion.insert({
    this.id = const Value.absent(),
    required int bundleId,
    required int documentId,
    this.addedAt = const Value.absent(),
  }) : bundleId = Value(bundleId),
       documentId = Value(documentId);
  static Insertable<BundleDocument> custom({
    Expression<int>? id,
    Expression<int>? bundleId,
    Expression<int>? documentId,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bundleId != null) 'bundle_id': bundleId,
      if (documentId != null) 'document_id': documentId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  BundleDocumentsCompanion copyWith({
    Value<int>? id,
    Value<int>? bundleId,
    Value<int>? documentId,
    Value<DateTime>? addedAt,
  }) {
    return BundleDocumentsCompanion(
      id: id ?? this.id,
      bundleId: bundleId ?? this.bundleId,
      documentId: documentId ?? this.documentId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bundleId.present) {
      map['bundle_id'] = Variable<int>(bundleId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<int>(documentId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundleDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('bundleId: $bundleId, ')
          ..write('documentId: $documentId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $BundleGroupsTable extends BundleGroups
    with TableInfo<$BundleGroupsTable, BundleGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BundleGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconName,
    colorHex,
    displayOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundle_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<BundleGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BundleGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BundleGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BundleGroupsTable createAlias(String alias) {
    return $BundleGroupsTable(attachedDatabase, alias);
  }
}

class BundleGroup extends DataClass implements Insertable<BundleGroup> {
  final int id;
  final String name;
  final String? iconName;
  final String? colorHex;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BundleGroup({
    required this.id,
    required this.name,
    this.iconName,
    this.colorHex,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    map['display_order'] = Variable<int>(displayOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BundleGroupsCompanion toCompanion(bool nullToAbsent) {
    return BundleGroupsCompanion(
      id: Value(id),
      name: Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
      displayOrder: Value(displayOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BundleGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BundleGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String?>(iconName),
      'colorHex': serializer.toJson<String?>(colorHex),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BundleGroup copyWith({
    int? id,
    String? name,
    Value<String?> iconName = const Value.absent(),
    Value<String?> colorHex = const Value.absent(),
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BundleGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    iconName: iconName.present ? iconName.value : this.iconName,
    colorHex: colorHex.present ? colorHex.value : this.colorHex,
    displayOrder: displayOrder ?? this.displayOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BundleGroup copyWithCompanion(BundleGroupsCompanion data) {
    return BundleGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BundleGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    iconName,
    colorHex,
    displayOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BundleGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.colorHex == this.colorHex &&
          other.displayOrder == this.displayOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BundleGroupsCompanion extends UpdateCompanion<BundleGroup> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> iconName;
  final Value<String?> colorHex;
  final Value<int> displayOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BundleGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BundleGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.iconName = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<BundleGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<String>? colorHex,
    Expression<int>? displayOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (colorHex != null) 'color_hex': colorHex,
      if (displayOrder != null) 'display_order': displayOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BundleGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? iconName,
    Value<String?>? colorHex,
    Value<int>? displayOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BundleGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundleGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('colorHex: $colorHex, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $BundlesTable bundles = $BundlesTable(this);
  late final $BundleDocumentsTable bundleDocuments = $BundleDocumentsTable(
    this,
  );
  late final $BundleGroupsTable bundleGroups = $BundleGroupsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    documents,
    bundles,
    bundleDocuments,
    bundleGroups,
  ];
}

typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required String title,
      required String type,
      required String filePaths,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> description,
      Value<bool> hasReminder,
      Value<DateTime?> reminderDate,
      Value<String?> reminderNote,
      Value<bool> isEncrypted,
      Value<String?> tags,
      Value<int?> bundleId,
      Value<String> metadata,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> type,
      Value<String> filePaths,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> description,
      Value<bool> hasReminder,
      Value<DateTime?> reminderDate,
      Value<String?> reminderNote,
      Value<bool> isEncrypted,
      Value<String?> tags,
      Value<int?> bundleId,
      Value<String> metadata,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BundleDocumentsTable, List<BundleDocument>>
  _bundleDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bundleDocuments,
    aliasName: $_aliasNameGenerator(
      db.documents.id,
      db.bundleDocuments.documentId,
    ),
  );

  $$BundleDocumentsTableProcessedTableManager get bundleDocumentsRefs {
    final manager = $$BundleDocumentsTableTableManager(
      $_db,
      $_db.bundleDocuments,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bundleDocumentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePaths => $composableBuilder(
    column: $table.filePaths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasReminder => $composableBuilder(
    column: $table.hasReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderNote => $composableBuilder(
    column: $table.reminderNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bundleId => $composableBuilder(
    column: $table.bundleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bundleDocumentsRefs(
    Expression<bool> Function($$BundleDocumentsTableFilterComposer f) f,
  ) {
    final $$BundleDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePaths => $composableBuilder(
    column: $table.filePaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasReminder => $composableBuilder(
    column: $table.hasReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderNote => $composableBuilder(
    column: $table.reminderNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bundleId => $composableBuilder(
    column: $table.bundleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get filePaths =>
      $composableBuilder(column: $table.filePaths, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasReminder => $composableBuilder(
    column: $table.hasReminder,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reminderDate => $composableBuilder(
    column: $table.reminderDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderNote => $composableBuilder(
    column: $table.reminderNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get bundleId =>
      $composableBuilder(column: $table.bundleId, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  Expression<T> bundleDocumentsRefs<T extends Object>(
    Expression<T> Function($$BundleDocumentsTableAnnotationComposer a) f,
  ) {
    final $$BundleDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool bundleDocumentsRefs})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> filePaths = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> hasReminder = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<String?> reminderNote = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<int?> bundleId = const Value.absent(),
                Value<String> metadata = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                title: title,
                type: type,
                filePaths: filePaths,
                createdAt: createdAt,
                updatedAt: updatedAt,
                description: description,
                hasReminder: hasReminder,
                reminderDate: reminderDate,
                reminderNote: reminderNote,
                isEncrypted: isEncrypted,
                tags: tags,
                bundleId: bundleId,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String type,
                required String filePaths,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> hasReminder = const Value.absent(),
                Value<DateTime?> reminderDate = const Value.absent(),
                Value<String?> reminderNote = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<int?> bundleId = const Value.absent(),
                Value<String> metadata = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                title: title,
                type: type,
                filePaths: filePaths,
                createdAt: createdAt,
                updatedAt: updatedAt,
                description: description,
                hasReminder: hasReminder,
                reminderDate: reminderDate,
                reminderNote: reminderNote,
                isEncrypted: isEncrypted,
                tags: tags,
                bundleId: bundleId,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bundleDocumentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bundleDocumentsRefs) db.bundleDocuments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bundleDocumentsRefs)
                    await $_getPrefetchedData<
                      Document,
                      $DocumentsTable,
                      BundleDocument
                    >(
                      currentTable: table,
                      referencedTable: $$DocumentsTableReferences
                          ._bundleDocumentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DocumentsTableReferences(
                            db,
                            table,
                            p0,
                          ).bundleDocumentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.documentId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool bundleDocumentsRefs})
    >;
typedef $$BundlesTableCreateCompanionBuilder =
    BundlesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> template,
      Value<int?> groupId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDefault,
    });
typedef $$BundlesTableUpdateCompanionBuilder =
    BundlesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> template,
      Value<int?> groupId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDefault,
    });

final class $$BundlesTableReferences
    extends BaseReferences<_$AppDatabase, $BundlesTable, Bundle> {
  $$BundlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BundleDocumentsTable, List<BundleDocument>>
  _bundleDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bundleDocuments,
    aliasName: $_aliasNameGenerator(db.bundles.id, db.bundleDocuments.bundleId),
  );

  $$BundleDocumentsTableProcessedTableManager get bundleDocumentsRefs {
    final manager = $$BundleDocumentsTableTableManager(
      $_db,
      $_db.bundleDocuments,
    ).filter((f) => f.bundleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bundleDocumentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BundlesTableFilterComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bundleDocumentsRefs(
    Expression<bool> Function($$BundleDocumentsTableFilterComposer f) f,
  ) {
    final $$BundleDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.bundleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BundlesTableOrderingComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BundlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<int> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  Expression<T> bundleDocumentsRefs<T extends Object>(
    Expression<T> Function($$BundleDocumentsTableAnnotationComposer a) f,
  ) {
    final $$BundleDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.bundleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BundlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BundlesTable,
          Bundle,
          $$BundlesTableFilterComposer,
          $$BundlesTableOrderingComposer,
          $$BundlesTableAnnotationComposer,
          $$BundlesTableCreateCompanionBuilder,
          $$BundlesTableUpdateCompanionBuilder,
          (Bundle, $$BundlesTableReferences),
          Bundle,
          PrefetchHooks Function({bool bundleDocumentsRefs})
        > {
  $$BundlesTableTableManager(_$AppDatabase db, $BundlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BundlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BundlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BundlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> template = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => BundlesCompanion(
                id: id,
                name: name,
                description: description,
                template: template,
                groupId: groupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> template = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => BundlesCompanion.insert(
                id: id,
                name: name,
                description: description,
                template: template,
                groupId: groupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDefault: isDefault,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BundlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bundleDocumentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bundleDocumentsRefs) db.bundleDocuments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bundleDocumentsRefs)
                    await $_getPrefetchedData<
                      Bundle,
                      $BundlesTable,
                      BundleDocument
                    >(
                      currentTable: table,
                      referencedTable: $$BundlesTableReferences
                          ._bundleDocumentsRefsTable(db),
                      managerFromTypedResult: (p0) => $$BundlesTableReferences(
                        db,
                        table,
                        p0,
                      ).bundleDocumentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bundleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BundlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BundlesTable,
      Bundle,
      $$BundlesTableFilterComposer,
      $$BundlesTableOrderingComposer,
      $$BundlesTableAnnotationComposer,
      $$BundlesTableCreateCompanionBuilder,
      $$BundlesTableUpdateCompanionBuilder,
      (Bundle, $$BundlesTableReferences),
      Bundle,
      PrefetchHooks Function({bool bundleDocumentsRefs})
    >;
typedef $$BundleDocumentsTableCreateCompanionBuilder =
    BundleDocumentsCompanion Function({
      Value<int> id,
      required int bundleId,
      required int documentId,
      Value<DateTime> addedAt,
    });
typedef $$BundleDocumentsTableUpdateCompanionBuilder =
    BundleDocumentsCompanion Function({
      Value<int> id,
      Value<int> bundleId,
      Value<int> documentId,
      Value<DateTime> addedAt,
    });

final class $$BundleDocumentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $BundleDocumentsTable, BundleDocument> {
  $$BundleDocumentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BundlesTable _bundleIdTable(_$AppDatabase db) =>
      db.bundles.createAlias(
        $_aliasNameGenerator(db.bundleDocuments.bundleId, db.bundles.id),
      );

  $$BundlesTableProcessedTableManager get bundleId {
    final $_column = $_itemColumn<int>('bundle_id')!;

    final manager = $$BundlesTableTableManager(
      $_db,
      $_db.bundles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bundleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias(
        $_aliasNameGenerator(db.bundleDocuments.documentId, db.documents.id),
      );

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<int>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BundleDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BundlesTableFilterComposer get bundleId {
    final $$BundlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableFilterComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BundlesTableOrderingComposer get bundleId {
    final $$BundlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableOrderingComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$BundlesTableAnnotationComposer get bundleId {
    final $$BundlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableAnnotationComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BundleDocumentsTable,
          BundleDocument,
          $$BundleDocumentsTableFilterComposer,
          $$BundleDocumentsTableOrderingComposer,
          $$BundleDocumentsTableAnnotationComposer,
          $$BundleDocumentsTableCreateCompanionBuilder,
          $$BundleDocumentsTableUpdateCompanionBuilder,
          (BundleDocument, $$BundleDocumentsTableReferences),
          BundleDocument,
          PrefetchHooks Function({bool bundleId, bool documentId})
        > {
  $$BundleDocumentsTableTableManager(
    _$AppDatabase db,
    $BundleDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BundleDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BundleDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BundleDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bundleId = const Value.absent(),
                Value<int> documentId = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => BundleDocumentsCompanion(
                id: id,
                bundleId: bundleId,
                documentId: documentId,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bundleId,
                required int documentId,
                Value<DateTime> addedAt = const Value.absent(),
              }) => BundleDocumentsCompanion.insert(
                id: id,
                bundleId: bundleId,
                documentId: documentId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BundleDocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bundleId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bundleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bundleId,
                                referencedTable:
                                    $$BundleDocumentsTableReferences
                                        ._bundleIdTable(db),
                                referencedColumn:
                                    $$BundleDocumentsTableReferences
                                        ._bundleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable:
                                    $$BundleDocumentsTableReferences
                                        ._documentIdTable(db),
                                referencedColumn:
                                    $$BundleDocumentsTableReferences
                                        ._documentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BundleDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BundleDocumentsTable,
      BundleDocument,
      $$BundleDocumentsTableFilterComposer,
      $$BundleDocumentsTableOrderingComposer,
      $$BundleDocumentsTableAnnotationComposer,
      $$BundleDocumentsTableCreateCompanionBuilder,
      $$BundleDocumentsTableUpdateCompanionBuilder,
      (BundleDocument, $$BundleDocumentsTableReferences),
      BundleDocument,
      PrefetchHooks Function({bool bundleId, bool documentId})
    >;
typedef $$BundleGroupsTableCreateCompanionBuilder =
    BundleGroupsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> iconName,
      Value<String?> colorHex,
      Value<int> displayOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BundleGroupsTableUpdateCompanionBuilder =
    BundleGroupsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> iconName,
      Value<String?> colorHex,
      Value<int> displayOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BundleGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $BundleGroupsTable> {
  $$BundleGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BundleGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $BundleGroupsTable> {
  $$BundleGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BundleGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BundleGroupsTable> {
  $$BundleGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BundleGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BundleGroupsTable,
          BundleGroup,
          $$BundleGroupsTableFilterComposer,
          $$BundleGroupsTableOrderingComposer,
          $$BundleGroupsTableAnnotationComposer,
          $$BundleGroupsTableCreateCompanionBuilder,
          $$BundleGroupsTableUpdateCompanionBuilder,
          (
            BundleGroup,
            BaseReferences<_$AppDatabase, $BundleGroupsTable, BundleGroup>,
          ),
          BundleGroup,
          PrefetchHooks Function()
        > {
  $$BundleGroupsTableTableManager(_$AppDatabase db, $BundleGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BundleGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BundleGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BundleGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
                Value<String?> colorHex = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BundleGroupsCompanion(
                id: id,
                name: name,
                iconName: iconName,
                colorHex: colorHex,
                displayOrder: displayOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> iconName = const Value.absent(),
                Value<String?> colorHex = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BundleGroupsCompanion.insert(
                id: id,
                name: name,
                iconName: iconName,
                colorHex: colorHex,
                displayOrder: displayOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BundleGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BundleGroupsTable,
      BundleGroup,
      $$BundleGroupsTableFilterComposer,
      $$BundleGroupsTableOrderingComposer,
      $$BundleGroupsTableAnnotationComposer,
      $$BundleGroupsTableCreateCompanionBuilder,
      $$BundleGroupsTableUpdateCompanionBuilder,
      (
        BundleGroup,
        BaseReferences<_$AppDatabase, $BundleGroupsTable, BundleGroup>,
      ),
      BundleGroup,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$BundlesTableTableManager get bundles =>
      $$BundlesTableTableManager(_db, _db.bundles);
  $$BundleDocumentsTableTableManager get bundleDocuments =>
      $$BundleDocumentsTableTableManager(_db, _db.bundleDocuments);
  $$BundleGroupsTableTableManager get bundleGroups =>
      $$BundleGroupsTableTableManager(_db, _db.bundleGroups);
}
