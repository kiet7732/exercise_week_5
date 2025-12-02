import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/note_provider.dart';
import '../screens/note_editor_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Mới nhất lúc: ${DateFormat.yMd().add_jm().format(note.updatedAt)}',
        ),
        onTap: () {
          // Điều hướng đến màn hình chỉnh sửa khi nhấn vào một ghi chú
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteEditorScreen(note: note),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Hiển thị dialog xác nhận trước khi xóa
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Xóa ghi chú?'),
                content: const Text(
                  'Bạn muốn xóa ghi chú?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Thoát'),
                  ),
                  TextButton(
                    onPressed: () {
                      noteProvider.deleteNote(note.id!);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Ghi chú đã bị xóa')),
                        );
                    },
                    child: const Text('Xóa'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
