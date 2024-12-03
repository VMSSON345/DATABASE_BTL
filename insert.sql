use db02;
-- SET SQL_SAFE_UPDATES = 0;
INSERT INTO NhomMatHang (MaNhomMH, TenNhomMH)
VALUES (1, 'Đồ gia dụng'),
       (2, 'Thực phẩm'),
       (3, 'Đồ điện tử'),
       (4, 'Thời trang'),
       (5, 'Đồ chơi trẻ em');

INSERT INTO MatHang (MaMH, TenMH, DonViTinh, DonGia, NgayNhap, NhomHang, SoLuongTonKho)
VALUES (1, 'Nồi cơm điện', 'Cái', 500000, '2024-11-01', 1, 20),
       (2, 'Sữa tươi', 'Hộp', 15000, '2024-11-02', 2, 50),
       (3, 'Laptop', 'Chiếc', 15000000, '2024-11-03', 3, 10),
       (4, 'Áo thun', 'Cái', 200000, '2024-11-04', 4, 30),
       (5, 'Xe đồ chơi', 'Chiếc', 300000, '2024-11-05', 5, 15);

INSERT INTO KhachHang (MaKH, TenKH, DiaChi, SoDT, DiemThuong)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội', '0901234567', 100),
       (2, 'Trần Thị B', 'TP HCM', '0912345678', 200),
       (3, 'Lê Văn C', 'Đà Nẵng', '0923456789', 150),
       (4, 'Phạm Thị D', 'Hải Phòng', '0934567890', 80),
       (5, 'Hoàng Văn E', 'Cần Thơ', '0945678901', 50);

INSERT INTO NhanVien (MaNV, TenNV, ChucVu, DiaChi, SoDT, NgayVaoLam, Luong) 
VALUES 
(1, 'Nguyễn Văn X', 'Quản lý', 'Hà Nội', '0971234567', '2023-01-01', 15000000),
(2, 'Trần Thị Y', 'Nhân viên bán hàng', 'Hà Nội', '0981234567', '2023-06-01', 10000000),
(3, 'Lê Văn Z', 'Nhân viên kho', 'Đà Nẵng', '0991234567', '2024-01-01', 8000000),
(4, 'Hoàng Văn Q', 'Quản lý', 'TP HCM', '0901234568', '2022-05-01', 15000000),
(5, 'Phạm Thị K', 'Nhân viên bán hàng', 'Hải Phòng', '0911234568', '2024-07-01', 9500000);

INSERT INTO HoaDon (MaKH, MaNV, NgayLap_HD, TongTien)
VALUES (1, 1, '2024-11-05', 750000),
       (2, 2, '2024-11-06', 300000),
       (3, 3, '2024-11-07', 15000000),
       (4, 4, '2024-11-08', 200000),
       (5, 5, '2024-11-09', 450000);

INSERT INTO ChiTietHoaDon (MaHD, MaMH, SoLuong, DonGia)
VALUES (1, 1, 1, 500000),
       (2, 2, 20, 15000),
       (3, 3, 1, 15000000),
       (4, 4, 1, 200000),
       (5, 5, 3, 300000);

-- KhuyenMai
INSERT INTO KhuyenMai (MaKM, TenKM, MoTa, NgayBatDau, NgayKetThuc, GiamGia)
VALUES (1, 'Giảm giá mùa hè', 'Giảm giá 10%', '2024-06-01', '2024-06-30', 10),
       (2, 'Black Friday', 'Giảm giá 50%', '2024-11-25', '2024-11-30', 50),
       (3, 'Giảm giá cuối năm', 'Giảm giá 20%', '2024-12-15', '2024-12-31', 20),
       (4, 'Mua 1 tặng 1', 'Áp dụng đồ chơi trẻ em', '2024-01-01', '2024-01-15', 0),
       (5, 'Ưu đãi đặc biệt', 'Giảm giá 30%', '2024-03-01', '2024-03-10', 30);

INSERT INTO MatHangKhuyenMai (MaMH, MaKM)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 5),
       (5, 4);

INSERT INTO ThanhToan (MaHD, PhuongThucThanhToan, SoTien, NgayThanhToan)
VALUES 
(1, 'Tiền mặt', 750000, '2024-11-05'),
(2, 'Thẻ tín dụng', 300000, '2024-11-06'),
(3, 'Chuyển khoản', 15000000, '2024-11-07'),
(4, 'Ví điện tử', 200000, '2024-11-08'),
(5, 'Tiền mặt', 450000, '2024-11-09');

