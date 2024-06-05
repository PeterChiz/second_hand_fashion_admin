# second_hand_fashion_admin
https://secondhandfashionapp.web.app

## Getting Started

Điều kiện để chạy app:
SDK version không quá lỗi thời tầm 3.0.5 trở lên

Cách chạy hết pubspec:
-Click vào terminal trên Android Studio => gõ "flutter pub get"

Định cấu hình Firebase:
-Tạo một dự án Firebase mới trên Firebase Console.
-Theo dõi hướng dẫn trong tài liệu Firebase để thiết lập Firebase trong dự án Flutter của bạn.
-Chạy ứng dụng của bạn trên second_hand_fashion_app: Để khởi chạy ứng dụng Flutter, hãy sử dụng lệnh sau: "flutter run"
-Kết nối firebase tới project chạy lệnh sau: "flutterfire configure"

Hướng dẫn khắc phục vấn đề hình ảnh không hiển thị trong Flutter web:
-Đầu tiên, bạn cần kết nối và kích hoạt Firebase Auth, Firestore, và Storage.
-Thêm chỉ mục vào Firestore bằng cách truy cập vào bảng điều khiển Firebase của dự án của bạn.
-Chọn cơ sở dữ liệu Firestore và sau đó chọn chỉ mục từ menu trên cùng. Nhấp vào nút Thêm chỉ mục trong tab tổng hợp.
-Collection Id = Images
-Các trường để chỉ mục: mediaCategory = Tăng dần createdAt = Giảm dần _ name _ = Giảm dần 
--Lưu ý:
-Trong tên, có hai dấu gạch dưới ở đầu và cuối và không có khoảng trắng giữa tên và dấu gạch dưới.
-Phạm vi truy vấn = Collection
-Chờ đợi cho đến khi chỉ mục được kích hoạt.
--Kích hoạt CORS:
-Đăng nhập vào bảng điều khiển Google Cloud của bạn: https://console.cloud.google.com/home.
-Nhấp vào “Kích hoạt Google Cloud Shell” ở góc trên bên phải.
-Ở phía dưới cửa sổ của bạn, một terminal shell sẽ được hiển thị, nơi gcloud và gsutil đã sẵn sàng. 
-Thực hiện lệnh dưới đây. Nó tạo ra một tệp json cần thiết để thiết lập cấu hình cors cho bucket của bạn. 
-Cấu hình này sẽ cho phép mọi miền truy cập vào bucket của bạn bằng các yêu cầu XHR trong trình duyệt.
echo ‘[{“origin”: [“*”],“responseHeader”: [“Content-Type”],“method”: [“GET”, “HEAD”],“maxAgeSeconds”: 3600}]’ > cors-config.json
-Nếu bạn muốn hạn chế quyền truy cập đến một hoặc nhiều miền cụ thể, thêm URL của chúng vào mảng, ví dụ: echo ‘[{“origin”: [“https://yourdomain.com”],“responseHeader”: [“Content-Type”],“method”: [“GET”, “HEAD”],“maxAgeSeconds”: 3600}]’ > cors-config.json 
-Thay thế YOUR_BUCKET_NAME bằng tên bucket thực tế của bạn trong lệnh sau để cập nhật cài đặt cors từ bucket của bạn: gsutil cors set cors-config.json gs://YOUR_BUCKET_NAME 
-Để kiểm tra xem mọi thứ đã hoạt động như mong đợi hay không, bạn có thể lấy cài đặt cors của một bucket với lệnh sau: gsutil cors get gs://YOUR_BUCKET_NAME


