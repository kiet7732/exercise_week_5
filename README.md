# Ứng dụng Ghi chú Đơn giản

Một ứng dụng ghi chú đơn giản được xây dựng bằng Flutter, cho phép người dùng tạo, xem, sửa và xóa ghi chú một cách dễ dàng. Dữ liệu được lưu trữ cục bộ trên thiết bị, đảm bảo tính riêng tư và khả năng truy cập ngoại tuyến.


## Live Demo (Phiên bản Web)
Trải nghiệm ứng dụng trực tiếp trên Vercel:
**https://exercise-week-5-git-main-kiet7732s-projects.vercel.app/**

*Lưu ý: Vì đây là giao diện thiết kế cho Mobile, vui lòng nhấn **F12** -> chọn **Chế độ xem di động** (Ctrl+Shift+M) trên trình duyệt để có trải nghiệm tốt nhất.*
## ✨ Tính năng

-   **Quản lý Ghi chú (CRUD):** Tạo, đọc, cập nhật và xóa ghi chú một cách đầy đủ.
-   **Lưu trữ Cục bộ:** Sử dụng `sqflite` để lưu trữ dữ liệu an toàn và bền bỉ trên thiết bị của người dùng.
-   **Quản lý Trạng thái:** Áp dụng `provider` để quản lý trạng thái ứng dụng một cách hiệu quả, giúp giao diện luôn được cập nhật tức thì khi có thay đổi dữ liệu.
-   **Giao diện Người dùng Tối giản:** Thiết kế sạch sẽ, tập trung vào nội dung và trải nghiệm người dùng.
-   **Xác nhận Xóa:** Hiển thị hộp thoại xác nhận trước khi xóa một ghi chú để tránh mất dữ liệu do thao tác nhầm.
-   **Cảnh báo Thoát:** Tự động phát hiện các thay đổi chưa được lưu và hỏi người dùng có muốn lưu lại hay không khi họ cố gắng thoát khỏi màn hình chỉnh sửa.

## 🛠️ Công nghệ & Thư viện

-   **Ngôn ngữ:** Dart
-   **Framework:** Flutter
-   **Cơ sở dữ liệu:** sqflite - Để tương tác với cơ sở dữ liệu SQLite cục bộ.
-   **Quản lý Trạng thái:** provider - Để quản lý và cung cấp trạng thái cho các widget.
-   **Đường dẫn Hệ thống:** path_provider - Để lấy đường dẫn lưu trữ cơ sở dữ liệu.
-   **Định dạng Ngày/Giờ:** intl - Để hiển thị ngày cập nhật một cách thân thiện.

## 📂 Cấu trúc Dự án

Dự án được tổ chức theo cấu trúc rõ ràng, giúp dễ dàng bảo trì và mở rộng:

```
lib
├── database/
│   └── db_helper.dart      # Singleton quản lý tất cả hoạt động DB (CRUD)
├── models/
│   └── note.dart           # Model định nghĩa cấu trúc dữ liệu của một ghi chú
├── providers/
│   └── note_provider.dart  # Quản lý trạng thái và logic nghiệp vụ của ứng dụng
├── screens/
│   ├── home_page.dart      # Màn hình chính hiển thị danh sách ghi chú
│   └── note_editor_screen.dart # Màn hình tạo/chỉnh sửa ghi chú
├── widgets/
│   └── note_card.dart      # Widget tái sử dụng để hiển thị một ghi chú
└── main.dart               # Điểm khởi đầu của ứng dụng
```

## 🚀 Bắt đầu

Để chạy dự án này trên máy của bạn, hãy làm theo các bước sau:

1.  **Cài đặt Flutter:**
    Đảm bảo bạn đã cài đặt Flutter SDK. Xem hướng dẫn tại flutter.dev.

2.  **Clone Repository:**
    ```sh
    git clone https://github.com/kiet7732/exercise_week_5.git
    cd exercise_week_5
    ```

3.  **Cài đặt Dependencies:**
    Chạy lệnh sau để tải về tất cả các thư viện cần thiết:
    ```sh
    flutter pub get
    ```

4.  **Chạy ứng dụng:**
    Kết nối một thiết bị hoặc khởi động một máy ảo và chạy lệnh:
    ```sh
    flutter run
    ```
