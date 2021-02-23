import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);
  static var _t = Translations("en_us") +
      {
        "en_us":
            "Grades from 6 to 12 are currently testing, do you still want to play?",
        "vi_vn":
            "Hiện lớp 6 đến 12 đang trong giai đoạn thử nghiệm, bạn có muốn chơi không?"
      } +
      {
        "en_us": "Are you sure to logout of this account?",
        "vi_vn": "Bạn có chăc chắn muốn đăng xuất không?"
      } +
      {
        "en_us": "* In case you need help",
        "vi_vn": "* Nếu bạn cần sự trợ giúp"
      } +
      {
        "en_us": "Listen and arrange words into sentences correctly.",
        "vi_vn": "Nghe và sắp xếp từ thành câu cho đúng."
      } +
      {"en_us": "Matching pair", "vi_vn": "Nối bản dịch đúng."} +
      {"en_us": "Listen and write.", "vi_vn": "Nghe và viết lại."} +
      {
        "en_us": "Listen and complete the blank.",
        "vi_vn": "Nghe và điền từ còn thiếu vào chỗ trống."
      } +
      {
        "en_us": "Arrange words into sentences correctly.",
        "vi_vn": "Sắp xếp các từ thành câu hoàn chỉnh."
      } +
      {"en_us": "Choose the correct answer.", "vi_vn": "Chọn bản dịch đúng."} +
      {"en_us": "Translate this sentence.", "vi_vn": "Dịch câu sau."} +
      {
        "en_us": "Listen and complete the blank.",
        "vi_vn": "Nghe và chọn từ còn thiếu vào chỗ trống."
      } +
      {"en_us": "Speak out loud.", "vi_vn": "Nói câu sau."} +
      {"en_us": "Translate this sentence.", "vi_vn": "Hoàn thành bản dịch."} +
      {"en_us": "Helping", "vi_vn": "Trợ giúp"} +
      {"en_us": "Rating", "vi_vn": "Đánh giá"} +
      {"en_us": "Time reminder", "vi_vn": "Giờ nhắc nhở"} +
      {"en_us": "Understand!", "vi_vn": "Đã hiểu!"} +
      {"en_us": "Please plugin headphone for better recorder!", "vi_vn": "Sử dụng tai nghe để ghi âm tốt hơn!"} +
      {"en_us": "Logout", "vi_vn": "Đăng xuất"} +
      {"en_us": "Talk exercises", "vi_vn": "Bài tập nói"} +
      {"en_us": "Listening exercises", "vi_vn": "Bài tập nghe"} +
      {"en_us": "Cancel", "vi_vn": "Huỷ"} +
      {"en_us": "Language", "vi_vn": "Ngôn ngữ"} +
      {"en_us": "Sound", "vi_vn": "Âm thanh"} +
      {"en_us": "FontSize", "vi_vn": "Kích cỡ chữ"} +
      {"en_us": "Ratting", "vi_vn": "Đánh giá"} +
      {"en_us": "Help", "vi_vn": "Trợ giúp"} +
      {"en_us": "Setting", "vi_vn": "Cài đặt"} +
      {"en_us": "Book", "vi_vn": "Sách"} +
      {"en_us": "BOOK", "vi_vn": "SÁCH"} +
      {"en_us": "Diamond", "vi_vn": "Kim cương"} +
      {"en_us": "Unit", "vi_vn": "Đơn vị"} +
      {"en_us": "Item", "vi_vn": "Vật phẩm"} +
      {"en_us": "More App", "vi_vn": "App liên kết"} +
      {"en_us": "Practice", "vi_vn": "Luyện tập"} +
      {"en_us": "Learned", "vi_vn": "Bạn đã học"} +
      {"en_us": "Reminder", "vi_vn": "Nhắc nhở học"} +
      {
        "en_us": "Hmmm... something not right",
        "vi_vn": "Hum... có vẻ không đúng"
      } +
      {"en_us": "Please try again", "vi_vn": "Thử lại lần nữa xem"} +
      {
        "en_us": "Learning English Textbook better\nEnglish 1 - 12",
        "vi_vn": "Để học tốt sách giáo khoa\nTiếng Anh 1 - 12"
      } +
      {"en_us": "LOGIN", "vi_vn": "ĐĂNG NHẬP"} +
      {"en_us": "LEVELUP", "vi_vn": "THĂNG HẠNG"} +
      {"en_us": "CONTINUE", "vi_vn": "TIẾP TỤC"} +
      {"en_us": "START", "vi_vn": "BẮT ĐẦU"} +
      {
        "en_us": "Better try next time !",
        "vi_vn": "Hãy cố gắng hơn ở lần sau !"
      } +
      {"en_us": "GRADE", "vi_vn": "LỚP"} +
      {"en_us": "TIPS", "vi_vn": "MẸO"} +
      {"en_us": "Lessons", "vi_vn": "Bài đã học"} +
      {"en_us": "Level", "vi_vn": "Cấp độ"} +
      {"en_us": "PROMOTION", "vi_vn": "Thăng hạng"} +
      {
        "en_us": "You have completed the unit",
        "vi_vn": "Bạn đã hoàn thành Unit"
      } +
      {
        "en_us": "You have completed the lesson",
        "vi_vn": "Bạn đã hoàn thành bài học"
      } +
      {
        "en_us": "The previous results will not be saved",
        "vi_vn": "Kết quả trước đó sẽ không được lưu lại."
      } +
      {"en_us": "Quit", "vi_vn": "Thoát"} +
      {"en_us": "Do you want to quit?", "vi_vn": "Bạn có chắc không?"} +
      {"en_us": "Upcoming soon", "vi_vn": "Bài này hiện tại chưa có câu hỏi"} +
      {"en_us": "CHECK", "vi_vn": "KIỂM TRA"} +
      {"en_us": "CANNOT TALK RIGHT NOW", "vi_vn": "HIỆN CHƯA NÓI ĐƯỢC"} +
      {"en_us": "Please speak louder", "vi_vn": "Vui lòng nói lớn hơn"} +
      {"en_us": "Training reminder", "vi_vn": "Nhắc nhở luyện tập"} +
      {"en_us": "The correct answer:", "vi_vn": "Đáp án đúng:"} +
      {"en_us": "Correct.", "vi_vn": "Chính xác."} +
      {
        "en_us": "Almost Correct. Nice try.",
        "vi_vn": "Gần chính xác. Cố gắng hơn ở lần sau nhé."
      } +
      {"en_us": "PRACTICE", "vi_vn": "LUYỆN TẬP"} +
      {
        "en_us": "You have completed the practice",
        "vi_vn": "Bạn đã hoàn thành luyện tập"
      } +
      {"en_us": "CONGRATS", "vi_vn": "CHÚC MỪNG"} +
      {"en_us": "Continue", "vi_vn": "Tiếp tục"} +
      {
        "en_us": "Do you want to continue the last lesson?",
        "vi_vn": "Bạn có muốn tiếp tục phần đã chơi trước đó?"
      } +
      {"en_us": "No", "vi_vn": "Không"} +
      {"en_us": "Achievement", "vi_vn": "Thành tích"} +
      {"en_us": "Lesson", "vi_vn": "Bài"} +
      {"en_us": "Yes", "vi_vn": "Có"} +
      {"en_us": "Name", "vi_vn": "Tên"} +
      {"en_us": "Overview", "vi_vn": "Tổng Quan"} +
      {"en_us": "Accessible ability", "vi_vn": "Khả năng truy cập"} +
      {"en_us": "Language", "vi_vn": "Ngôn ngữ"};
}
