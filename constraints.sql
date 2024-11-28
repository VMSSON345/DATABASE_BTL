use db02;
-- Bảng NhomMatHang
-- Đảm bảo tên nhóm mặt hàng phải có ít nhất 3 ký tự
ALTER TABLE NhomMatHang
ADD CONSTRAINT chk_TenNhomMH CHECK (LENGTH(TenNhomMH) >= 3);

-- Bảng MatHang
-- Đảm bảo đơn giá của mặt hàng phải lớn hơn 0
ALTER TABLE MatHang
ADD CONSTRAINT chk_DonGia CHECK (DonGia > 0);

-- Đảm bảo số lượng tồn kho không được âm
ALTER TABLE MatHang
ADD CONSTRAINT chk_SoLuongTonKho CHECK (SoLuongTonKho >= 0);

-- Đảm bảo tên mặt hàng không bị trùng trong cùng một nhóm mặt hàng
ALTER TABLE MatHang
ADD CONSTRAINT uq_TenMH UNIQUE (TenMH, MaNhomMH);

-- Bảng KhachHang
-- Đảm bảo số điện thoại của khách hàng là duy nhất
ALTER TABLE KhachHang
ADD CONSTRAINT uq_SoDT UNIQUE (SoDT);

-- Đảm bảo điểm thưởng không âm
ALTER TABLE KhachHang
ADD CONSTRAINT chk_DiemThuong CHECK (DiemThuong >= 0);

-- Bảng MuaHang
-- Đảm bảo số lượng mua phải lớn hơn 0
ALTER TABLE MuaHang
ADD CONSTRAINT chk_SoLuong CHECK (SoLuong > 0);

-- Bảng NhanVien
-- Đảm bảo số điện thoại của nhân viên là duy nhất
ALTER TABLE NhanVien
ADD CONSTRAINT uq_SoDT_NV UNIQUE (SoDT);

-- Đảm bảo lương nhân viên không thấp hơn 5 triệu
ALTER TABLE NhanVien
ADD CONSTRAINT chk_Luong CHECK (Luong >= 5000000);

-- Đảm bảo tên nhân viên phải dài ít nhất 5 ký tự
ALTER TABLE NhanVien
ADD CONSTRAINT chk_TenNV CHECK (LENGTH(TenNV) >= 5);

-- Bảng HoaDon
-- Đảm bảo tổng tiền trong hóa đơn không âm
ALTER TABLE HoaDon
ADD CONSTRAINT chk_TongTien CHECK (TongTien >= 0);

-- Bảng ChiTietHoaDon
-- Đảm bảo số lượng trong chi tiết hóa đơn phải lớn hơn 0
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT chk_SoLuong_CT CHECK (SoLuong > 0);

-- Đảm bảo đơn giá trong chi tiết hóa đơn phải lớn hơn 0
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT chk_DonGia_CT CHECK (DonGia > 0);

-- Ràng buộc FOREIGN KEY bổ sung (tăng tính toàn vẹn dữ liệu)
-- Đảm bảo bảng MatHang tham chiếu đúng nhóm mặt hàng, tự động xóa mặt hàng nếu nhóm bị xóa
ALTER TABLE MatHang
ADD CONSTRAINT fk_NhomMH FOREIGN KEY (MaNhomMH) REFERENCES NhomMatHang(MaNhomMH) ON DELETE CASCADE;

-- Đảm bảo bảng MuaHang tham chiếu đúng mặt hàng, tự động xóa giao dịch nếu mặt hàng bị xóa
ALTER TABLE MuaHang
ADD CONSTRAINT fk_MH_MH FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH) ON DELETE CASCADE;

-- Đảm bảo bảng MuaHang tham chiếu đúng khách hàng, tự động xóa giao dịch nếu khách hàng bị xóa
ALTER TABLE MuaHang
ADD CONSTRAINT fk_MH_KH FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON DELETE CASCADE;

-- Đảm bảo bảng HoaDon tham chiếu đúng khách hàng, đặt NULL nếu khách hàng bị xóa
ALTER TABLE HoaDon
ADD CONSTRAINT fk_HD_KH FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH) ON DELETE SET NULL;

-- Đảm bảo bảng ChiTietHoaDon tham chiếu đúng hóa đơn, tự động xóa chi tiết nếu hóa đơn bị xóa
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT fk_CT_HD FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD) ON DELETE CASCADE;

-- Đảm bảo bảng ChiTietHoaDon tham chiếu đúng mặt hàng, tự động xóa chi tiết nếu mặt hàng bị xóa
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT fk_CT_MH FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH) ON DELETE CASCADE;

-- Ràng buộc CHECK bổ sung
-- Đảm bảo chức vụ nhân viên chỉ nhận một trong các giá trị xác định trước
ALTER TABLE NhanVien
ADD CONSTRAINT chk_ChucVu CHECK (ChucVu IN ('Quản lý', 'Nhân viên', 'Thực tập'));

-- Đảm bảo ngày lập hóa đơn không sớm hơn năm 2000
-- ALTER TABLE HoaDon
-- ADD CONSTRAINT chk_NgayLap CHECK (NgayLap >= '2000-01-01');
