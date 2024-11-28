CREATE DATABASE DB02;
use db02;
CREATE TABLE NhomMatHang (
    MaNhomMH INT PRIMARY KEY,
    TenNhomMH VARCHAR(255)
);
CREATE TABLE MatHang (
    MaMH INT PRIMARY KEY,
    TenMH VARCHAR(255),
    DonViTinh VARCHAR(50),
    DonGia DOUBLE,
    NgayNhap DATE,
    NhomHang INT,
    SoLuongTonKho INT,
    FOREIGN KEY (NhomHang) REFERENCES NhomMatHang(MaNhomMH)
);

CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY,
    TenKH VARCHAR(255),
    DiaChi VARCHAR(255),
    SoDT VARCHAR(50),
    DiemThuong INT
);
CREATE TABLE MuaHang (
    MaMH INT,
    MaKH INT,
    NgayMua DATE,
    SoLuong INT,
    PRIMARY KEY (MaMH, MaKH, NgayMua),
    FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    TenNV VARCHAR(255),
    ChucVu VARCHAR(100),
    DiaChi VARCHAR(255),
    SoDT VARCHAR(50),
    NgayVaoLam DATE
);
ALTER TABLE NhanVien
ADD COLUMN Luong DOUBLE;

CREATE TABLE HoaDon (
    MaHD INT PRIMARY KEY AUTO_INCREMENT,
    MaKH INT,
    MaNV INT, 
    NgayLap_HD DATE,
    TongTien DOUBLE,
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) 
);

CREATE TABLE ChiTietHoaDon (
    MaHD INT,
    MaMH INT,
    SoLuong INT,
    DonGia DOUBLE,
    PRIMARY KEY (MaHD, MaMH),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH)
);
CREATE TABLE KhuyenMai (
    MaKM INT PRIMARY KEY,
    TenKM VARCHAR(255),
    MoTa TEXT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    GiamGia DOUBLE
);
CREATE TABLE MatHangKhuyenMai (
    MaMH INT,
    MaKM INT,
    PRIMARY KEY (MaMH, MaKM),
    FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH),
    FOREIGN KEY (MaKM) REFERENCES KhuyenMai(MaKM)
);
CREATE TABLE ThanhToan (
    MaTT INT PRIMARY KEY,
    MaHD INT,
    PhuongThucThanhToan VARCHAR(100),
    SoTien DOUBLE,
    NgayThanhToan DATE,
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
);
