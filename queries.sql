USE DB02;

/*** Query using inner join ***/
-- Truy vấn khách hàng có ngày đặt trước ngày 5 tháng 12 năm 2024
select kh.TEN_KH, kh.SDT_KH, hd.NGAY_LAP from khach_hang kh
inner join hoa_don hd on hd.MA_KH = kh.MA_KH
where hd.NGAY_LAP < '2024-12-05';

-- Truy vấn nhóm mặt hàng là Đồ chơi và Đồ gia dụng và tổng số lượng tồn kho của những mặt hàng đó 
select nmh.TEN_NHOM, sum(mh.SL_TONKHO) as total from nhom_mat_hang nmh
inner join mat_hang mh on mh.MA_NHOM = nmh.MA_NHOM 
group by nmh.TEN_NHOM
having nmh.TEN_NHOM = 'Đồ chơi' or nmh.TEN_NHOM = 'Đồ gia dụng';

/*** Query using outer join ***/
-- 	
(select kh.TEN_KH, kh.SDT_KH, hd.MA_HD from khach_hang kh
left join hoa_don hd on kh.MA_KH = hd.MA_KH)
union
(select kh.TEN_KH, kh.SDT_KH, hd.MA_HD from khach_hang kh	
right join hoa_don hd on kh.MA_KH = hd.MA_KH);

-- Truy vấn tất cả nhân viên và tất cả đơn hàng
(select nv.TEN_NV, nv.CHUC_VU, nv.SDT_NV, hd.MA_HD from nhan_vien nv
left join hoa_don hd on hd.MA_NV = nv.MA_NV)
union
(select nv.TEN_NV, nv.CHUC_VU, nv.SDT_NV, hd.MA_HD from nhan_vien nv
right join hoa_don hd on hd.MA_NV = nv.MA_NV);

/*** Subquery in where ***/
-- Truy vấn sản phẩm có số lượng tồn kho lớn hơn trung bình số lượng tồn kho
select TEN_MH, GIA_MH, SL_TONKHO from mat_hang
where SL_TONKHO > (select avg(SL_TONKHO) from mat_hang);

-- Truy vấn những đơn hàng do nhân viên thực tập phụ trách 
select MA_HD, MA_NV from hoa_don
where MA_NV in (select MA_NV from nhan_vien
				where CHUC_VU = 'Thực tập');

/** Subquery in from **/
-- Truy vấn mã đơn hàng có số lượng đặt hàng lớn hoặc bằng 3 
select MA_HD, SO_LUONG 
from (
	select MA_HD, sum(SO_LUONG) as SO_LUONG from chi_tiet_hoa_don
    group by MA_HD) as total
where SO_LUONG >= 3;

-- Truy vấn tổng doanh thu của từng nhân viên 
select 
    nv.TEN_NV as nhan_vien,
    doanhthu.doanh_thu
from 
    (select 
         hd.MA_NV,
         sum(cthd.SO_LUONG * mh.GIA_MH) as doanh_thu
     from chi_tiet_hoa_don cthd
     join hoa_don hd on cthd.MA_HD = hd.MA_HD
     join mat_hang mh on cthd.MA_MH = mh.MA_MH
     group by hd.MA_NV) as doanhthu
join nhan_vien nv on doanhthu.MA_NV = nv.MA_NV
order by doanhthu.doanh_thu desc;

/*** Query using group by and aggregate functions ***/
-- Truy vấn các đơn hàng có giá trị lớn hơn 1 triệu đồng  
select ct.MA_HD, sum(ct.SO_LUONG * mh.GIA_MH) as Tổng_tiền from chi_tiet_hoa_don ct
join mat_hang mh on mh.MA_MH = ct.MA_MH
group by ct.MA_HD
having Tổng_tiền > 1000000;

-- Truy vấn tổng số đơn hàng của mỗi khách hàng 
select kh.TEN_KH, count(hd.MA_HD) as total from khach_hang kh
join hoa_don hd on hd.MA_KH = kh.MA_KH
group by kh.TEN_KH;