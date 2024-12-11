-- Xóa các procedure nếu đã tồn tại
DROP PROCEDURE IF EXISTS Thong_tin_khach_hang;
DROP PROCEDURE IF EXISTS Danh_sach_mat_hang;
DROP PROCEDURE IF EXISTS Tong_doanh_thu;
DROP PROCEDURE IF EXISTS Thong_ke_ton_kho;
DROP PROCEDURE IF EXISTS Cap_nhat_mat_hang;
DROP PROCEDURE IF EXISTS Cap_nhat_khach_hang;
DROP PROCEDURE IF EXISTS Doanh_thu_theo_thang;

DELIMITER $$

-- Procedure: Lấy thông tin chi tiết của một khách hàng dựa trên mã khách hàng
CREATE PROCEDURE Thong_tin_khach_hang(
    IN maKH CHAR(5)
)
BEGIN
    SELECT * 
    FROM khach_hang
    WHERE MA_KH = maKH;
END $$

-- Procedure: Lấy danh sách mặt hàng sắp xếp theo giá
CREATE PROCEDURE Danh_sach_mat_hang()
BEGIN
    SELECT * FROM mat_hang
    ORDER BY GIA_MH;
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
CALL Thong_tin_khach_hang(KH001);
CALL Danh_sach_mat_hang();
CALL Tong_doanh_thu();
CALL Thong_ke_ton_kho();
CALL Doanh_thu_theo_thang(12,2024);
