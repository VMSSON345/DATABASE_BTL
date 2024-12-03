use db02;
-- 1. Ràng buộc NOT NULL cho cột TenMH trong bảng MatHang
ALTER TABLE MatHang
MODIFY COLUMN TenMH VARCHAR(255) NOT NULL;

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

-- 9 để MATT tự tăng
ALTER TABLE ThanhToan MODIFY MaTT INT AUTO_INCREMENT;

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

-- 20. Ràng buộc CHECK cho cột NhomHang trong bảng MatHang (Mã nhóm hàng phải tồn tại trong bảng NhomMatHang)
ALTER TABLE MatHang
ADD CONSTRAINT chk_nhomhang FOREIGN KEY (NhomHang) REFERENCES NhomMatHang(MaNhomMH);

-- 21. Ràng buộc DEFAULT cho cột NgayNhap trong bảng MatHang (Ngày nhập mặc định là ngày hiện tại)
-- ALTER TABLE MatHang
-- MODIFY COLUMN NgayNhap DATE DEFAULT DATE(NOW);

-- 22. Ràng buộc UNIQUE cho cặp MaMH, MaKH và NgayMua trong bảng MuaHang (Mỗi khách hàng mua mặt hàng chỉ một lần trong ngày)
ALTER TABLE MuaHang
ADD CONSTRAINT uq_mamh_makh_ngaymua UNIQUE (MaMH, MaKH, NgayMua);

-- 23. Ràng buộc FOREIGN KEY cho cột MaMH trong bảng MuaHang (Mặt hàng phải tồn tại trong bảng MatHang)
ALTER TABLE MuaHang
ADD CONSTRAINT fk_mua_mamh FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH);

-- 24. Ràng buộc FOREIGN KEY cho cột MaKH trong bảng MuaHang (Khách hàng phải tồn tại trong bảng KhachHang)
ALTER TABLE MuaHang
ADD CONSTRAINT fk_mua_makh FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH);

-- 25. Ràng buộc CHECK cho cột GiamGia trong bảng KhuyenMai (Giảm giá phải nằm trong khoảng từ 0 đến 100)
ALTER TABLE KhuyenMai
ADD CONSTRAINT chk_giamgia CHECK (GiamGia >= 0 AND GiamGia <= 100);

-- 26. Ràng buộc CHECK cho cột NgayBatDau trong bảng KhuyenMai (Ngày bắt đầu phải trước ngày kết thúc)
ALTER TABLE KhuyenMai
ADD CONSTRAINT chk_ngaybatdau CHECK (NgayBatDau < NgayKetThuc);

-- 27. Ràng buộc FOREIGN KEY cho cột MaMH trong bảng MatHangKhuyenMai (Mặt hàng phải tồn tại trong bảng MatHang)
ALTER TABLE MatHangKhuyenMai
ADD CONSTRAINT fk_mamh_makm FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH);

-- 28. Ràng buộc FOREIGN KEY cho cột MaKM trong bảng MatHangKhuyenMai (Khuyến mãi phải tồn tại trong bảng KhuyenMai)
ALTER TABLE MatHangKhuyenMai
ADD CONSTRAINT fk_km_mamh FOREIGN KEY (MaKM) REFERENCES KhuyenMai(MaKM);

-- 29. Ràng buộc CHECK cho cột SoTien trong bảng ThanhToan (Số tiền phải lớn hơn 0)
ALTER TABLE ThanhToan
ADD CONSTRAINT chk_sotien CHECK (SoTien > 0);

-- 30. Ràng buộc FOREIGN KEY cho cột MaHD trong bảng ThanhToan (Hóa đơn phải tồn tại trong bảng HoaDon)
ALTER TABLE ThanhToan
ADD CONSTRAINT fk_thanhtoan_mahd FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD);



