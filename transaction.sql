use db02;

SHOW CREATE TABLE hoa_don;

start transaction;
insert into khach_hang(MA_KH,TEN_KH,SDT_KH,DIA_CHI) values('KH015','Trần Văn T','0987463123','Nghệ An');
insert into nhan_vien(MA_NV,TEN_NV,CHUC_VU,SDT_NV) values('NV015','Nguyễn Thùy Linh','Nhân viên','0934532567');
insert into nhom_mat_hang(MA_NHOM,TEN_NHOM) values('N015','Thực phẩm');
rollback;

set SQL_SAFE_UPDATES = 0;

start transaction;
update khach_hang
set TEN_KH = 'AI-UET'
where DIA_CHI = 'Hà Nội';
rollback;

alter table hoa_don
add constraint FK_HOA_DON_NV foreign key (MA_NV) references NHAN_VIEN(MA_NV);

start transaction;
alter table hoa_don
drop foreign key FK_HOA_DON_NV;
rollback;

start transaction;
alter table nhom_mat_hang
drop foreign key FK_MH;
alter table nhom_mat_hang
add constraint FK_MH foreign key(MA_NHOM) references mat_hang(MA_NHOM)
on update cascade;
rollback;

start transaction;
alter table nhan_vien
modify TEN_NV varchar(100);
rollback;

/** Thêm mới đơn hàng nếu số lượng đặt hàng nhỏ hơn hoặc bằng số lượng tồn kho **/
delimiter $$
DROP PROCEDURE IF EXISTS nhap_don_hang;
create procedure nhap_don_hang(
    in p_ma_hoa_don varchar(10),
    in p_ngay_mua date,
    in p_ma_hang varchar(10),
    in p_so_luong int
)
begin
    declare ton_kho_hien_tai int;

    -- bắt đầu giao dịch
    start transaction;

    -- lấy số lượng tồn kho hiện tại, giới hạn 1 dòng
    select SL_TONKHO
    into ton_kho_hien_tai
    from mat_hang
    where MA_MH = p_ma_hang
    limit 1;

    -- kiểm tra nếu tồn kho đủ
    if ton_kho_hien_tai >= p_so_luong then
        -- thêm đơn hàng vào bảng hóa đơn
        insert into chi_tiet_hoa_don (MA_HD, MA_MH, SO_LUONG)
        values (p_ma_hoa_don, p_ma_hang, p_so_luong);

        -- cập nhật tồn kho
        update mat_hang
        set SL_TONKHO = SL_TONKHO - p_so_luong
        where MA_MH = p_ma_hang;

        -- commit giao dịch
        commit;
    else
        -- nếu không đủ tồn kho, rollback
        rollback;
        signal sqlstate '45000'
        set message_text = 'không đủ tồn kho để thêm đơn hàng';
    end if;
end$$

delimiter ;

call nhap_don_hang('HD031','2023-10-20','MH003',90);
