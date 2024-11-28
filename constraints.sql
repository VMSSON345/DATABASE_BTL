-- 1. Ràng buộc NOT NULL cho cột TenMH trong bảng MatHang
ALTER TABLE MatHang
MODIFY COLUMN TenMH VARCHAR(100) NOT NULL;

-- 2. Ràng buộc NOT NULL cho cột DonViTinh trong bảng MatHang
ALTER TABLE MatHang
MODIFY COLUMN DonViTinh VARCHAR(50) NOT NULL;

-- 3. Ràng buộc CHECK cho cột DonGia trong bảng MatHang (giá trị lớn hơn 0)
ALTER TABLE MatHang
ADD CONSTRAINT chk_dongia CHECK (DonGia > 0);

-- 4. Ràng buộc CHECK cho cột SoLuongTonKho trong bảng MatHang (số lượng tồn kho không âm)
ALTER TABLE MatHang
ADD CONSTRAINT chk_soluongtonkho CHECK (SoLuongTonKho >= 0);

-- 5. Ràng buộc DEFAULT cho cột DiemThuong trong bảng KhachHang
ALTER TABLE KhachHang
ALTER COLUMN DiemThuong SET DEFAULT 0;

-- 6. Ràng buộc UNIQUE cho cột SoDT trong bảng KhachHang (Số điện thoại phải duy nhất)
ALTER TABLE KhachHang
ADD CONSTRAINT uq_sdt UNIQUE (SoDT);

-- 7. Ràng buộc UNIQUE cho cột SoDT trong bảng NhanVien (Số điện thoại phải duy nhất)
ALTER TABLE NhanVien
ADD CONSTRAINT uq_sdt_nv UNIQUE (SoDT);

-- 8. Ràng buộc CHECK cho cột Luong trong bảng NhanVien (Lương phải lớn hơn 0)
ALTER TABLE NhanVien
ADD CONSTRAINT chk_luong CHECK (Luong > 0);

-- 9. Ràng buộc CHECK cho cột SoDT trong bảng NhanVien (Số điện thoại phải có định dạng hợp lệ)
ALTER TABLE NhanVien
ADD CONSTRAINT chk_sdt_nv CHECK (SoDT LIKE '0[0-9]%');

-- 10. Ràng buộc CHECK cho cột TongTien trong bảng HoaDon (Tổng tiền phải lớn hơn 0)
ALTER TABLE HoaDon
ADD CONSTRAINT chk_tongtien CHECK (TongTien > 0);

-- 11. Ràng buộc UNIQUE cho cột MaKH trong bảng HoaDon (Mỗi hóa đơn phải có khách hàng duy nhất)
ALTER TABLE HoaDon
ADD CONSTRAINT uq_makh UNIQUE (MaKH);

-- 12. Ràng buộc UNIQUE cho cột MaNV trong bảng HoaDon (Mỗi hóa đơn phải có nhân viên duy nhất)
ALTER TABLE HoaDon
ADD CONSTRAINT uq_manv UNIQUE (MaNV);

-- 13. Ràng buộc FOREIGN KEY cho cột MaKH trong bảng HoaDon (Khách hàng phải tồn tại trong bảng KhachHang)
ALTER TABLE HoaDon
ADD CONSTRAINT fk_hd_makh FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH);

-- 14. Ràng buộc FOREIGN KEY cho cột MaNV trong bảng HoaDon (Nhân viên phải tồn tại trong bảng NhanVien)
ALTER TABLE HoaDon
ADD CONSTRAINT fk_hd_manv FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV);

-- 15. Ràng buộc FOREIGN KEY cho cột MaMH trong bảng ChiTietHoaDon (Mặt hàng phải tồn tại trong bảng MatHang)
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT fk_cthd_mamh FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH);

-- 16. Ràng buộc FOREIGN KEY cho cột MaHD trong bảng ChiTietHoaDon (Hóa đơn phải tồn tại trong bảng HoaDon)
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT fk_cthd_mahd FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD);

-- 17. Ràng buộc CHECK cho cột SoLuong trong bảng ChiTietHoaDon (Số lượng phải lớn hơn 0)
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT chk_soluong_cthd CHECK (SoLuong > 0);

-- 18. Ràng buộc CHECK cho cột DonGia trong bảng ChiTietHoaDon (Đơn giá phải lớn hơn 0)
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT chk_dongia_cthd CHECK (DonGia > 0);

-- 19. Ràng buộc UNIQUE cho cặp MaHD và MaMH trong bảng ChiTietHoaDon (Mỗi hóa đơn chỉ có một mặt hàng duy nhất)
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT uq_mahd_mamh UNIQUE (MaHD, MaMH);

-- 20. Ràng buộc CHECK cho cột MaNhomMH trong bảng MatHang (Mã nhóm mặt hàng phải tồn tại trong bảng NhomMatHang)
ALTER TABLE MatHang
ADD CONSTRAINT chk_manhommh FOREIGN KEY (MaNhomMH) REFERENCES NhomMatHang(MaNhomMH);


-- 21. Ràng buộc FOREIGN KEY cho cột MaMH trong bảng MuaHang (Mặt hàng phải tồn tại trong bảng MatHang)
ALTER TABLE MuaHang
ADD CONSTRAINT fk_mua_mamh FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH);

-- 22. Ràng buộc FOREIGN KEY cho cột MaKH trong bảng MuaHang (Khách hàng phải tồn tại trong bảng KhachHang)
ALTER TABLE MuaHang
ADD CONSTRAINT fk_mua_makh FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH);
