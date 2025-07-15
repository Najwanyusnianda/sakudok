import 'package:go_router/go_router.dart';
import '../../features/documents/presentation/pages/document_list_page.dart';
import '../../features/documents/presentation/pages/add_edit_document_page.dart';

final appRouter = GoRouter(
  initialLocation: '/documents',
  routes: [
    GoRoute(
      path: '/documents',
      name: 'documents',
      builder: (context, state) => const DocumentListPage(),
      routes: [
        GoRoute(
          path: 'add',
          name: 'add-document',
          builder: (context, state) => const AddEditDocumentPage(),
        ),
        GoRoute(
          path: 'edit/:id',
          name: 'edit-document',
          builder: (context, state) => AddEditDocumentPage(
            documentId: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);
