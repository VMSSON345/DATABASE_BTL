use db02;

drop trigger if exists Xoa_chi_tiet_don_hang;
drop trigger if exists Cap_nhat_ton_kho_Insert;
drop trigger if exists Cap_nhat_ton_kho_Update;

DELIMITER $$
-- Trigger: Cập nhật tồn kho sau khi bán
CREATE TRIGGER Cap_nhat_ton_kho_Insert
BEFORE INSERT ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    DECLARE sl_ton INT;

    SELECT SL_TONKHO INTO sl_ton 
    FROM mat_hang 
    WHERE MA_MH = NEW.MA_MH;

    IF sl_ton < NEW.SO_LUONG THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Số lượng mặt hàng trong kho không đủ';
    END IF;

    UPDATE mat_hang
    SET SL_TONKHO = SL_TONKHO - NEW.SO_LUONG
    WHERE MA_MH = NEW.MA_MH;
END $$


-- Trigger: Cập nhật tồn kho sau khi sửa chi tiết hoá đơn

CREATE TRIGGER Cap_nhat_ton_kho_Update
BEFORE UPDATE ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    DECLARE delta INT;
    SET delta = NEW.SO_LUONG - OLD.SO_LUONG;

    IF (SELECT SL_TONKHO FROM mat_hang WHERE MA_MH = OLD.MA_MH) - delta < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Số lượng tồn kho không đủ để cập nhật';
    END IF;

    UPDATE mat_hang
    SET SL_TONKHO = SL_TONKHO - delta
    WHERE MA_MH = OLD.MA_MH;
END $$

-- Trigger: Bắt buộc một hoá đơn phải có ít nhất một chi tiết hoá đơn
CREATE TRIGGER Xoa_chi_tiet_hoa_don
BEFORE DELETE ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM chi_tiet_hoa_don
        WHERE MA_HD = OLD.MA_HD
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Mỗi hóa đơn phải có ít nhất 1 chi tiết hóa đơn';
    END IF;
END $$

DELIMITER ;

