-- Xóa các procedure nếu đã tồn tại
DROP PROCEDURE IF EXISTS Danh_sach_nhan_vien;
DROP PROCEDURE IF EXISTS Danh_sach_khach_hang;
DROP PROCEDURE IF EXISTS Thong_tin_khach_hang;
DROP PROCEDURE IF EXISTS Danh_sach_mat_hang;
DROP PROCEDURE IF EXISTS Danh_sach_hoa_don;
DROP PROCEDURE IF EXISTS Danh_sach_chi_tiet_hoa_don;
DROP PROCEDURE IF EXISTS Tong_doanh_thu;
DROP PROCEDURE IF EXISTS Thong_ke_ton_kho;
DROP PROCEDURE IF EXISTS Them_hoa_don;
DROP PROCEDURE IF EXISTS Cap_nhat_hoa_don;
DROP PROCEDURE IF EXISTS Xoa_hoa_don;
DROP PROCEDURE IF EXISTS Them_chi_tiet_hoa_don;
DROP PROCEDURE IF EXISTS Xoa_chi_tiet_hoa_don;
DROP PROCEDURE IF EXISTS Them_mat_hang;
DROP PROCEDURE IF EXISTS Cap_nhat_mat_hang;
DROP PROCEDURE IF EXISTS Xoa_mat_hang;
DROP PROCEDURE IF EXISTS Cap_nhat_khach_hang;
DROP PROCEDURE IF EXISTS Xoa_khach_hang;
DROP PROCEDURE IF EXISTS Doanh_thu_theo_thang;

DELIMITER $$

-- Procedure: Lấy danh sách nhân viên
CREATE PROCEDURE Danh_sach_nhan_vien()
BEGIN
    SELECT * FROM nhan_vien;
END $$

-- Procedure: Lấy danh sách khách hàng
CREATE PROCEDURE Danh_sach_khach_hang()
BEGIN
    SELECT * FROM khach_hang;
END $$

-- Procedure: Lấy thông tin chi tiết của một khách hàng dựa trên mã khách hàng
CREATE PROCEDURE Thong_tin_khach_hang(
    IN maKH CHAR(5)
)
BEGIN
    SELECT * 
    FROM khach_hang
    WHERE MA_KH = maKH;
END $$

-- Procedure: Lấy danh sách mặt hàng
CREATE PROCEDURE Danh_sach_mat_hang()
BEGIN
    SELECT * FROM mat_hang;
END $$

-- Procedure: Lấy danh sách hóa đơn kèm tổng tiền của mỗi hóa đơn
CREATE PROCEDURE Danh_sach_hoa_don()
BEGIN
    SELECT 
        h.*, 
        SUM(c.so_luong * m.gia_mh) AS TongTien
    FROM 
        hoa_don h
    JOIN 
        chi_tiet_hoa_don c ON h.MA_HD = c.MA_HD
    JOIN 
        mat_hang m ON c.MA_MH = m.MA_MH
    GROUP BY 
        h.MA_HD;
END $$

-- Procedure: Lấy danh sách chi tiết hóa đơn
CREATE PROCEDURE Danh_sach_chi_tiet_hoa_don()
BEGIN
    SELECT * FROM chi_tiet_hoa_don;
END $$

-- Procedure: Tính tổng doanh thu từ tất cả các hóa đơn
CREATE PROCEDURE Tong_doanh_thu()
BEGIN
    SELECT 
        SUM(c.so_luong * m.gia_mh) AS Tong_doanh_thu
    FROM 
        hoa_don h
    JOIN 
        chi_tiet_hoa_don c ON h.MA_HD = c.MA_HD
    JOIN 
        mat_hang m ON c.MA_MH = m.MA_MH;
END $$

-- Procedure: Thống kê hàng tồn kho (mặt hàng còn tồn)
CREATE PROCEDURE Thong_ke_ton_kho()
BEGIN
    SELECT 
        MA_MH, TEN_MH, SLTONKHO 
    FROM mat_hang 
    WHERE SLTONKHO > 0;
END $$

-- Procedure: Thêm hóa đơn mới
CREATE PROCEDURE Them_hoa_don(
    IN maHD CHAR(10), 
    IN ngayLap DATE, 
    IN maNV CHAR(5), 
    IN maKH CHAR(5)
)
BEGIN
    INSERT INTO hoa_don (MA_HD, NGAY_LAP, MA_NV, MA_KH) 
    VALUES (maHD, ngayLap, maNV, maKH);
END $$

-- Procedure: Cập nhật thông tin hóa đơn
CREATE PROCEDURE Cap_nhat_hoa_don(
    IN maHD CHAR(10),
    IN ngayLap DATE,
    IN maNV CHAR(5),
    IN maKH CHAR(5)
)
BEGIN
    UPDATE hoa_don 
    SET NGAY_LAP = ngayLap, MA_NV = maNV, MA_KH = maKH 
    WHERE MA_HD = maHD;
END $$

-- Procedure: Xóa hóa đơn
CREATE PROCEDURE Xoa_hoa_don(
    IN maHD CHAR(10)
)
BEGIN
    DELETE FROM hoa_don WHERE MA_HD = maHD;
END $$

-- Procedure: Thêm chi tiết hóa đơn
CREATE PROCEDURE Them_chi_tiet_hoa_don(
    IN maHD CHAR(10), 
    IN maMH CHAR(10), 
    IN soLuong INT
)
BEGIN
    INSERT INTO chi_tiet_hoa_don (MA_HD, MA_MH, SO_LUONG) 
    VALUES (maHD, maMH, soLuong);
END $$

-- Procedure: Xóa chi tiết hóa đơn
CREATE PROCEDURE Xoa_chi_tiet_hoa_don(
    IN maHD CHAR(10),
    IN maMH CHAR(10)
)
BEGIN
    DELETE FROM chi_tiet_hoa_don 
    WHERE MA_HD = maHD AND MA_MH = maMH;
END $$

-- Procedure: Thêm mặt hàng mới
CREATE PROCEDURE Them_mat_hang(
    IN maMH CHAR(10), 
    IN tenMH VARCHAR(50), 
    IN giaMH INT, 
    IN soLuongTonKho INT, 
    IN maNhom CHAR(5)
)
BEGIN
    INSERT INTO mat_hang (MA_MH, TEN_MH, GIA_MH, SLTONKHO, MA_NHOM) 
    VALUES (maMH, tenMH, giaMH, soLuongTonKho, maNhom);
END $$

-- Procedure: Cập nhật thông tin mặt hàng
CREATE PROCEDURE Cap_nhat_mat_hang(
    IN maMH CHAR(10), 
    IN tenMH VARCHAR(50), 
    IN giaMH INT, 
    IN soLuongTonKho INT
)
BEGIN
    UPDATE mat_hang 
    SET TEN_MH = tenMH, GIA_MH = giaMH, SLTONKHO = soLuongTonKho 
    WHERE MA_MH = maMH;
END $$

-- Procedure: Xóa mặt hàng
CREATE PROCEDURE Xoa_mat_hang(
    IN maMH CHAR(10)
)
BEGIN
    DELETE FROM mat_hang WHERE MA_MH = maMH;
END $$

-- Procedure: Cập nhật thông tin khách hàng
CREATE PROCEDURE Cap_nhat_khach_hang(
    IN maKH CHAR(5), 
    IN tenKH VARCHAR(50), 
    IN sdtKH CHAR(10), 
    IN diaChi VARCHAR(100)
)
BEGIN
    UPDATE khach_hang 
    SET TEN_KH = tenKH, SDT_KH = sdtKH, DIA_CHI = diaChi 
    WHERE MA_KH = maKH;
END $$

-- Procedure: Xóa khách hàng
CREATE PROCEDURE Xoa_khach_hang(
    IN maKH CHAR(5)
)
BEGIN
    DELETE FROM khach_hang WHERE MA_KH = maKH;
END $$

-- Procedure: Thống kê doanh thu theo tháng
CREATE PROCEDURE Doanh_thu_theo_thang(
    IN thang INT, 
    IN nam INT
)
BEGIN
    SELECT 
        MONTH(h.NGAY_LAP) AS Thang, 
        YEAR(h.NGAY_LAP) AS Nam, 
        SUM(c.SO_LUONG * m.GIA_MH) AS Doanh_Thu
    FROM hoa_don h
    JOIN chi_tiet_hoa_don c ON h.MA_HD = c.MA_HD
    JOIN mat_hang m ON c.MA_MH = m.MA_MH
    WHERE MONTH(h.NGAY_LAP) = thang AND YEAR(h.NGAY_LAP) = nam
    GROUP BY MONTH(h.NGAY_LAP), YEAR(h.NGAY_LAP);
END $$

DELIMITER ;

-- Gọi các procedure để kiểm tra
CALL Danh_sach_nhan_vien();
CALL Danh_sach_hoa_don();
CALL Danh_sach_khach_hang();
CALL Danh_sach_chi_tiet_hoa_don();
CALL Danh_sach_mat_hang();
CALL Thong_tin_khach_hang('KH001');
CALL Tong_doanh_thu();
CALL Thong_ke_ton_kho();
