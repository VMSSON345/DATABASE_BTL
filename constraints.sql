use db02;
-- Constraint 1: Không cho phép giá mặt hàng âm
ALTER TABLE MAT_HANG
ADD CONSTRAINT CK_GIA_MH CHECK (GIA_MH >= 0);

-- Constraint 2: Không cho phép số lượng trong chi tiết hóa đơn âm
ALTER TABLE CHI_TIET_HOA_DON
ADD CONSTRAINT CK_SO_LUONG CHECK (SO_LUONG >= 0);

-- Constraint 3: Địa chỉ khách hàng không được vượt quá 100 ký tự
ALTER TABLE KHACH_HANG
ADD CONSTRAINT CK_DIA_CHI_LENGTH CHECK (LENGTH(DIA_CHI) <= 100);

-- Constraint 4: Số điện thoại nhân viên phải có đúng 10 ký tự số
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT CK_SDT_NV CHECK (SDT_NV REGEXP '^[0-9]{10}$');

-- Constraint 5: Số điện thoại khách hàng phải có đúng 10 ký tự số
ALTER TABLE KHACH_HANG
ADD CONSTRAINT CK_SDT_KH CHECK (SDT_KH REGEXP '^[0-9]{10}$');

-- Constraint 6: Chức vụ nhân viên phải nằm trong danh sách xác định (VD: 'Quản lý', 'Nhân viên', 'Thực tập')
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT CK_CHUC_VU CHECK (CHUC_VU IN ('Quản lý', 'Nhân viên', 'Thực tập'));

-- Constraint 7: Không cho phép tên nhóm mặt hàng trống
ALTER TABLE NHOM_MAT_HANG
ADD CONSTRAINT CK_TEN_NHOM_NOT_EMPTY CHECK (LENGTH(TRIM(TEN_NHOM)) > 0);

-- Constraint 8: Không cho phép tên mặt hàng trống
ALTER TABLE MAT_HANG
ADD CONSTRAINT CK_TEN_MH_NOT_EMPTY CHECK (LENGTH(TRIM(TEN_MH)) > 0);

-- Constraint 9: Không cho phép tên nhân viên trống
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT CK_TEN_NV_NOT_EMPTY CHECK (LENGTH(TRIM(TEN_NV)) > 0);

-- Constraint 10: Số lượng tồn kho của mặt hàng không được âm
ALTER TABLE MAT_HANG
ADD CONSTRAINT CK_SL_TONKHO CHECK (SL_TONKHO >= 0);

-- Constraint 11: Mã nhóm mặt hàng phải bắt đầu bằng 'N'
ALTER TABLE NHOM_MAT_HANG
ADD CONSTRAINT CK_MA_NHOM_FORMAT CHECK (MA_NHOM LIKE 'N%');

-- Constraint 12: Mã mặt hàng phải bắt đầu bằng 'MH'
ALTER TABLE MAT_HANG
ADD CONSTRAINT CK_MA_MH_FORMAT CHECK (MA_MH LIKE 'MH%');

-- Constraint 13: Mã nhân viên phải bắt đầu bằng 'NV'
ALTER TABLE NHAN_VIEN
ADD CONSTRAINT CK_MA_NV_FORMAT CHECK (MA_NV LIKE 'NV%');

-- Constraint 14: Mã khách hàng phải bắt đầu bằng 'KH'
ALTER TABLE KHACH_HANG
ADD CONSTRAINT CK_MA_KH_FORMAT CHECK (MA_KH LIKE 'KH%');

-- Constraint 15: Mã hóa đơn phải bắt đầu bằng 'HD'
ALTER TABLE HOA_DON
ADD CONSTRAINT CK_MA_HD_FORMAT CHECK (MA_HD LIKE 'HD%');


