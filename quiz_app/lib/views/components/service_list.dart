class ListService {
  final String name;
  final String imgURL;
  final String description;

  ListService({
    this.name,
    this.imgURL,
    this.description,
  });
}

List<ListService> listService = [
  ListService(
    name: 'Phát Triển Web',
    imgURL: '',
    description:
        'Thiết kế website. Bảo trì & nâng cấp website. Quản trị & và cập nhật website. Tư vấn giải pháp quảng bá bằng website.',
  ),
  ListService(
    name: 'Phát Triển phần mềm ứng dụng',
    imgURL: '',
    description:
        'Phần mềm quản lý hồ sơ trực tuyến. Phần mềm quản lý nhân sự, bán hàng. Tư vấn giải pháp và phát triển các hệ thống quản trị doanh nghiệp theo yêu cầu.',
  ),
  ListService(
    name: 'Cho thuê phòng máy',
    imgURL: '',
    description:
        'Trung tâm có 8 phòng thực hành được trang bị 320 máy tính cấu hình mạnh. Các phòng máy được kết nối Intenet tốc độ cao đảm bảo cho việc giảng dạy và tổ chức kiểm tra. Phòng đa chức năng là phòng chuyên tổ chức hội nghị, hội thảo với sức chứa từ 20 – 140 đại biểu. Phòng được trang bị hiện đại: hệ thống video conference, hệ thống dịch đa ngôn ngữ (4 kênh), hệ thống xuất dữ liệu tại vị trí bất kỳ phục vụ tham luận,… Tất cả đều cho thuê khi có yêu cầu.',
  ),
];
