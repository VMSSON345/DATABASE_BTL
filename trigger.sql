DELIMITER $$
-- Trigger: Cập nhật tồn kho sau khi bán
CREATE TRIGGER Cap_nhat_ton_kho_Insert
AFTER INSERT ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    UPDATE mat_hang
    SET SLTONKHO = SLTONKHO - NEW.SO_LUONG
    WHERE MA_MH = NEW.MA_MH;
END $$

-- Trigger: Cập nhật tồn kho sau khi sửa chi tiết hoá đơn
CREATE TRIGGER Cap_nhat_ton_kho_Update
AFTER UPDATE ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    UPDATE mat_hang
    SET SLTONKHO = SLTONKHO + (OLD.SO_LUONG - NEW.SO_LUONG)
    WHERE MA_MH = OLD.MA_MH;
END $$
DELIMITER ;
