import 'package:flutter/material.dart';
import '../../../models/note.dart';
import '../../../database/db_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  /// Tải tất cả ghi chú từ cơ sở dữ liệu và cập nhật trạng thái.
  Future<void> loadNotes() async {
    _notes = await DatabaseHelper.instance.readAll();
    // Thông báo cho các widget đang lắng nghe về sự thay đổi dữ liệu.
    notifyListeners();
  }

  /// Thêm một ghi chú mới.
  Future<void> addNote(String title, String content) async {
    final now = DateTime.now();
    final newNote = Note(
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
    await DatabaseHelper.instance.create(newNote);
    // Tải lại danh sách để cập nhật UI.
    await loadNotes();
  }

  /// Cập nhật một ghi chú hiện có.
  Future<void> updateNote(Note note) async {
    final updatedNote = note.copyWith(updatedAt: DateTime.now());
    await DatabaseHelper.instance.update(updatedNote);
    // Tải lại danh sách để cập nhật UI.
    await loadNotes();
  }

  /// Xóa một ghi chú.
  Future<void> deleteNote(int id) async {
    await DatabaseHelper.instance.delete(id);
    // Tải lại danh sách để cập nhật UI.
    await loadNotes();
  }
}
