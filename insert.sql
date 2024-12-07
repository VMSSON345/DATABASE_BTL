use db02;
INSERT INTO NHOM_MAT_HANG (MA_NHOM, TEN_NHOM) VALUES
('N001', 'Điện tử'),
('N002', 'Gia dụng'),
('N003', 'Thời trang'),
('N004', 'Thực phẩm'),
('N005', 'Đồ chơi'),
('N006', 'Mỹ phẩm'),
('N007', 'Văn phòng phẩm'),
('N008', 'Thiết bị y tế'),
('N009', 'Thể thao'),
('N010', 'Sách');

INSERT INTO MAT_HANG (MA_MH, TEN_MH, GIA_MH, MA_NHOM) VALUES
('MH001', 'Tivi', 5000000, 'N001'),
('MH002', 'Tủ lạnh', 10000000, 'N002'),
('MH003', 'Áo thun', 150000, 'N003'),
('MH004', 'Bánh mì', 20000, 'N004'),
('MH005', 'Búp bê', 300000, 'N005'),
('MH006', 'Son môi', 250000, 'N006'),
('MH007', 'Bút bi', 5000, 'N007'),
('MH008', 'Máy đo huyết áp', 1200000, 'N008'),
('MH009', 'Giày chạy bộ', 900000, 'N009'),
('MH010', 'Sách giáo khoa', 50000, 'N010');

INSERT INTO NHAN_VIEN (MA_NV, TEN_NV, CHUC_VU, SDT_NV) VALUES
('NV001', 'Nguyễn Văn A', 'Quản lý', '0912345678'),
('NV002', 'Trần Thị B', 'Nhân viên', '0912345679'),
('NV003', 'Lê Văn C', 'Nhân viên', '0912345680'),
('NV004', 'Phạm Thị D', 'Thực tập', '0912345681'),
('NV005', 'Vũ Văn E', 'Nhân viên', '0912345682'),
('NV006', 'Ngô Thị F', 'Thực tập', '0912345683'),
('NV007', 'Đỗ Văn G', 'Quản lý', '0912345684'),
('NV008', 'Hoàng Thị H', 'Nhân viên', '0912345685'),
('NV009', 'Phạm Văn I', 'Thực tập', '0912345686'),
('NV010', 'Nguyễn Thị K', 'Nhân viên', '0912345687');

INSERT INTO KHACH_HANG (MA_KH, TEN_KH, SDT_KH, DIA_CHI) VALUES
('KH001', 'Nguyễn Văn X', '0987654321', 'Hà Nội'),
('KH002', 'Trần Thị Y', '0987654322', 'Hồ Chí Minh'),
('KH003', 'Lê Văn Z', '0987654323', 'Đà Nẵng'),
('KH004', 'Phạm Thị U', '0987654324', 'Cần Thơ'),
('KH005', 'Vũ Văn V', '0987654325', 'Hải Phòng'),
('KH006', 'Ngô Thị W', '0987654326', 'Bắc Giang'),
('KH007', 'Đỗ Văn Q', '0987654327', 'Nam Định'),
('KH008', 'Hoàng Thị P', '0987654328', 'Vĩnh Long'),
('KH009', 'Phạm Văn O', '0987654329', 'Lào Cai'),
('KH010', 'Nguyễn Thị N', '0987654330', 'Huế');

INSERT INTO HOA_DON (MA_HD, NGAY_LAP, MA_NV, MA_KH, TONG_TIEN) VALUES
('HD001', '2024-12-01', 'NV001', 'KH001', 1000000),
('HD002', '2024-12-02', 'NV002', 'KH002', 2000000),
('HD003', '2024-12-03', 'NV003', 'KH003', 1500000),
('HD004', '2024-12-04', 'NV004', 'KH004', 2500000),
('HD005', '2024-12-05', 'NV005', 'KH005', 3000000),
('HD006', '2024-12-06', 'NV006', 'KH006', 1000000),
('HD007', '2024-12-07', 'NV007', 'KH007', 2000000),
('HD008', '2024-12-08', 'NV008', 'KH008', 4000000),
('HD009', '2024-12-09', 'NV009', 'KH009', 5000000),
('HD010', '2024-12-10', 'NV010', 'KH010', 6000000);

INSERT INTO CHI_TIET_HOA_DON (MA_HD, MA_MH, SO_LUONG, GIA_BAN) VALUES
('HD001', 'MH001', 1, 5000000),
('HD001', 'MH002', 2, 10000000),
('HD002', 'MH003', 3, 150000),
('HD003', 'MH004', 4, 20000),
('HD004', 'MH005', 1, 300000),
('HD005', 'MH006', 2, 250000),
('HD006', 'MH007', 10, 5000),
('HD007', 'MH008', 1, 1200000),
('HD008', 'MH009', 2, 900000),
('HD009', 'MH010', 5, 50000);
