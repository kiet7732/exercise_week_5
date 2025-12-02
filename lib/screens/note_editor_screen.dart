import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/note.dart';
import '../../providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  // note có thể là null (khi tạo mới) hoặc có giá trị (khi chỉnh sửa)
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // Lưu trữ giá trị ban đầu để kiểm tra thay đổi
  String _initialTitle = '';
  String _initialContent = '';

  bool get _isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    // Nếu là chỉnh sửa, điền thông tin cũ vào các trường
    if (_isEditing) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    _initialTitle = _titleController.text;
    _initialContent = _contentController.text;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// Kiểm tra xem người dùng đã thay đổi nội dung hay chưa
  bool _hasChanges() {
    return _titleController.text != _initialTitle || _contentController.text != _initialContent;
  }

  void _saveNote() {
    // Kiểm tra xem form có hợp lệ không
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final content = _contentController.text;
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

      if (_isEditing) {
        // Cập nhật ghi chú hiện có
        final updatedNote = widget.note!.copyWith(
          title: title,
          content: content,
        );
        noteProvider.updateNote(updatedNote);
      } else {
        // Thêm ghi chú mới
        noteProvider.addNote(title, content);
      }
      // Quay lại màn hình trước đó
      Navigator.of(context).pop();
    }
  }

  /// Xử lý khi người dùng nhấn nút quay lại
  Future<bool> _onWillPop() async {
    if (_hasChanges()) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lưu thay đổi?'),
          content: const Text('Bạn có muốn lưu các thay đổi trước khi thoát không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Ở lại màn hình
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Thoát không lưu
              child: const Text('Bỏ qua'),
            ),
            TextButton(
              onPressed: () {
                _saveNote();
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true; // Nếu không có thay đổi, cho phép thoát
  }

  @override
  Widget build(BuildContext context) {
    // Bọc toàn bộ Scaffold trong WillPopScope để xử lý sự kiện back
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Sửa Ghi Chú' : 'Thêm Ghi Chú'),
          actions: [
            IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: 'Tiêu đề',
                    border: InputBorder.none,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TextFormField(
                    controller: _contentController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Nội dung...',
                      border: InputBorder.none,
                    ),
                    maxLines: null, // Cho phép nhiều dòng
                    expands: true, // Mở rộng để lấp đầy không gian
                    keyboardType: TextInputType.multiline,
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng nhập nội dung' : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
