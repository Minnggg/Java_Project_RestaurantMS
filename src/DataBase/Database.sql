-- Xóa bảng NguoiDung nếu tồn tại
DROP TABLE IF EXISTS NguoiDung;

-- Tạo bảng NguoiDung
CREATE TABLE NguoiDung (
                           ID_ND INT(8) NOT NULL,
                           Email VARCHAR(50) NOT NULL,
                           Matkhau VARCHAR(20) NOT NULL,
                           VerifyCode VARCHAR(10) DEFAULT NULL,
                           Trangthai VARCHAR(10) DEFAULT '',
                           Vaitro VARCHAR(20) NOT NULL CHECK (Vaitro IN ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly')),
                           PRIMARY KEY (ID_ND)
);

-- Xóa bảng NhanVien nếu tồn tại
DROP TABLE IF EXISTS NhanVien;

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
                          ID_NV INT(8) NOT NULL,
                          TenNV VARCHAR(50) NOT NULL,
                          NgayVL DATE NOT NULL,
                          SDT VARCHAR(50) NOT NULL,
                          Chucvu VARCHAR(50) NOT NULL CHECK (Chucvu IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly')),
                          ID_ND INT(8) DEFAULT NULL,
                          ID_NQL INT(8),
                          Tinhtrang VARCHAR(20) NOT NULL CHECK (Tinhtrang IN ('Dang lam viec','Da nghi viec')),
                          PRIMARY KEY (ID_NV),
                          FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND) ON DELETE SET NULL,
                          FOREIGN KEY (ID_NQL) REFERENCES NhanVien(ID_NV) ON DELETE SET NULL
);

-- Xóa bảng KhachHang nếu tồn tại
DROP TABLE IF EXISTS KhachHang;

-- Tạo bảng KhachHang
CREATE TABLE KhachHang (
                           ID_KH INT(8) NOT NULL,
                           TenKH VARCHAR(50) NOT NULL,
                           Ngaythamgia DATE NOT NULL,
                           Doanhso INT(10) DEFAULT 0 NOT NULL,
                           Diemtichluy INT(5) DEFAULT 0 NOT NULL,
                           ID_ND INT(8) NOT NULL,
                           PRIMARY KEY (ID_KH),
                           FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND) ON DELETE CASCADE
);

-- Xóa bảng MonAn nếu tồn tại
DROP TABLE IF EXISTS MonAn;

-- Tạo bảng MonAn
CREATE TABLE MonAn (
                       ID_MonAn INT(8) NOT NULL,
                       TenMon VARCHAR(50) NOT NULL,
                       DonGia INT(8) NOT NULL,
                       Loai VARCHAR(50) NOT NULL CHECK (Loai IN ('Aries','Taurus','Gemini','Cancer','Leo','Virgo',
                                                                 'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces')),
                       TrangThai VARCHAR(30) NOT NULL CHECK (TrangThai IN ('Dang kinh doanh','Ngung kinh doanh')),
                       PRIMARY KEY (ID_MonAn)
);

-- Xóa bảng Ban nếu tồn tại
DROP TABLE IF EXISTS Ban;

-- Tạo bảng Ban
CREATE TABLE Ban (
                     ID_Ban INT(8) NOT NULL,
                     TenBan VARCHAR(50) NOT NULL,
                     Vitri VARCHAR(50) NOT NULL,
                     Trangthai VARCHAR(50) NOT NULL CHECK (Trangthai IN ('Con trong','Dang dung bua','Da dat truoc')),
                     PRIMARY KEY (ID_Ban)
);


-- Xóa bảng nếu tồn tại
DROP TABLE IF EXISTS CTHD;
DROP TABLE IF EXISTS HoaDon;
DROP TABLE IF EXISTS Voucher;

-- Tạo bảng Voucher
CREATE TABLE Voucher (
                         Code_Voucher VARCHAR(10) NOT NULL,
                         Mota VARCHAR(50) NOT NULL,
                         Phantram INT(3) NOT NULL CHECK (Phantram > 0 AND Phantram <= 100),
                         LoaiMA VARCHAR(50) NOT NULL CHECK (LoaiMA IN ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo',
                                                                       'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces')),
                         SoLuong INT(3) NOT NULL,
                         Diem INT(8) NOT NULL,
                         PRIMARY KEY (Code_Voucher)
);

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
                        ID_HoaDon INT(8) NOT NULL,
                        ID_KH INT(8),
                        ID_Ban INT(8),
                        NgayHD DATE NOT NULL,
                        TienMonAn INT(8) NOT NULL,
                        Code_Voucher VARCHAR(10),
                        TienGiam INT(8),
                        Tongtien INT(10) NOT NULL,
                        Trangthai VARCHAR(50) NOT NULL CHECK (Trangthai IN ('Chua thanh toan','Da thanh toan')),
                        PRIMARY KEY (ID_HoaDon),
                        FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH) ON DELETE SET NULL,
                        FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban) ON DELETE SET NULL,
                        FOREIGN KEY (Code_Voucher) REFERENCES Voucher(Code_Voucher) ON DELETE SET NULL
);

-- Tạo bảng CTHD (Chi tiết hóa đơn)
CREATE TABLE CTHD (
                      ID_HoaDon INT(8) NOT NULL,
                      ID_MonAn INT(8) NOT NULL,
                      SoLuong INT(3) NOT NULL,
                      Thanhtien INT(10) NOT NULL,
                      PRIMARY KEY (ID_HoaDon, ID_MonAn),
                      FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon) ON DELETE CASCADE,
                      FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn) ON DELETE CASCADE
);


-- Xóa bảng nếu tồn tại
DROP TABLE IF EXISTS CTNK;
DROP TABLE IF EXISTS PhieuNK;
DROP TABLE IF EXISTS Kho;
DROP TABLE IF EXISTS NguyenLieu;
DROP TABLE IF EXISTS PhieuXK;

-- Tạo bảng NguyenLieu
CREATE TABLE NguyenLieu (
                            ID_NL INT(8) NOT NULL,
                            TenNL VARCHAR(50) NOT NULL,
                            Dongia INT(8) NOT NULL,
                            Donvitinh VARCHAR(50) NOT NULL CHECK (Donvitinh IN ('g', 'kg', 'ml', 'l')),
                            PRIMARY KEY (ID_NL)
);

-- Tạo bảng Kho
CREATE TABLE Kho (
                     ID_NL INT(8) NOT NULL,
                     SLTon INT(3) DEFAULT 0 NOT NULL,
                     PRIMARY KEY (ID_NL),
                     FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL) ON DELETE CASCADE
);

-- Tạo bảng PhieuNK (Phiếu nhập kho)
CREATE TABLE PhieuNK (
                         ID_NK INT(8) NOT NULL,
                         ID_NV INT(8) NOT NULL,
                         NgayNK DATE NOT NULL,
                         Tongtien INT(10) DEFAULT 0 NOT NULL,
                         PRIMARY KEY (ID_NK),
                         FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV) ON DELETE CASCADE
);

-- Tạo bảng CTNK (Chi tiết nhập kho)
CREATE TABLE CTNK (
                      ID_NK INT(8) NOT NULL,
                      ID_NL INT(8) NOT NULL,
                      SoLuong INT(3) NOT NULL,
                      Thanhtien INT(10) NOT NULL,
                      PRIMARY KEY (ID_NK, ID_NL),
                      FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK) ON DELETE CASCADE,
                      FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL) ON DELETE CASCADE
);

-- Tạo bảng PhieuXK (Phiếu xuất kho)
CREATE TABLE PhieuXK (
                         ID_XK INT(8) NOT NULL,
                         ID_NV INT(8) NOT NULL,
                         NgayXK DATE NOT NULL,
                         PRIMARY KEY (ID_XK),
                         FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV) ON DELETE CASCADE
);
-- Xóa bảng nếu tồn tại
DROP TABLE IF EXISTS CTXK;

-- Tạo bảng CTXK
CREATE TABLE CTXK (
                      ID_XK INT(8),
                      ID_NL INT(8),
                      SoLuong INT(3) NOT NULL,  -- Thay thế CHECK bằng NOT NULL

    -- Khóa chính
                      PRIMARY KEY (ID_XK, ID_NL)
);

-- Thêm khóa ngoại
ALTER TABLE CTXK
    ADD CONSTRAINT CTXK_fk_idXK FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK);

ALTER TABLE CTXK
    ADD CONSTRAINT CTXK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

--
-- --- Tao Trigger
--
-- --Khach hang chi duoc co toi da mot hoa don co trang thai Chua thanh toan
-- CREATE OR REPLACE TRIGGER Tg_SLHD_CTT
-- BEFORE INSERT OR UPDATE OF ID_KH,TrangThai ON HoaDon
-- FOR EACH ROW
-- DECLARE
--     v_count NUMBER;
-- BEGIN
--     SELECT COUNT(*)
--     FROM HoaDon
--     WHERE ID_KH=:new.ID_KH AND TrangThai='Chua thanh toan';
--
--     IF v_count>1 THEN
--      RAISE_APPLICATION_ERROR(-20000,'Moi khach hang chi duoc co toi da mot hoa don co trang thai
--      chua thanh toan');
--     END IF;
-- END;
-- /
-- --  Trigger Thanh tien o CTHD bang SoLuong x Dongia cua mon an do
--
-- CREATE OR REPLACE TRIGGER Tg_CTHD_Thanhtien
-- BEFORE INSERT OR UPDATE OF SoLuong ON CTHD
-- FOR EACH ROW
-- DECLARE
--     gia MonAn.DonGia%TYPE;
-- BEGIN
--     SELECT DonGia
--     INTO gia
--     FROM MonAn
--     WHERE MonAn.ID_MonAn = :new.ID_MonAn;
--
--     :new.ThanhTien := :new.SoLuong * gia;
-- END;
-- /
-- --- Trigger Tien mon an o Hoa Don bang tong thanh tien o CTHD
-- CREATE OR REPLACE TRIGGER Tg_HD_TienMonAn
-- AFTER INSERT OR UPDATE OR DELETE ON CTHD
-- FOR EACH ROW
-- BEGIN
--     IF INSERTING THEN
--         UPDATE HoaDon SET TienMonAn = TienMonAn + :new.ThanhTien WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
--     END IF;
--
--     IF UPDATING THEN
--         UPDATE HoaDon SET TienMonAn = TienMonAn + :new.ThanhTien - :old.ThanhTien WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
--     END IF;
--
--     IF DELETING THEN
--         UPDATE HoaDon SET TienMonAn = TienMonAn - :old.ThanhTien WHERE HoaDon.ID_HoaDon=:old.ID_HoaDon;
--     END IF;
-- END;
-- /
-- --Trigger Tien giam o Hoa Don = tong thanh tien cua mon An duoc giam  x Phantram
-- CREATE OR REPLACE TRIGGER Tg_HD_TienGiam
-- AFTER INSERT OR UPDATE OR DELETE ON CTHD
-- FOR EACH ROW
-- DECLARE
--     v_code HoaDon.Code_Voucher%TYPE;
--     v_loaiMA Voucher.LoaiMA%TYPE;
--     MA_Loai MonAn.Loai%TYPE;
-- BEGIN
--     v_code:=NULL;
-- --Tim Code Voucher, Loai mon an duoc Ap dung Voucher tu bang Voucher
--     IF (INSERTING OR UPDATING) THEN
--         SELECT HoaDon.Code_Voucher,Voucher.LoaiMA
--         INTO v_code,v_LoaiMA
--         FROM HoaDon
--         LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
--         WHERE ID_HoaDon=:new.ID_HoaDon;
--     --Tim loai mon an cua Mon an vua duoc them vao CTHD
--         SELECT Loai
--         INTO MA_Loai
--         FROM MonAn
--         WHERE ID_MonAn = :new.ID_MonAn;
--     END IF;
--
--     IF (DELETING) THEN
--         SELECT HoaDon.Code_Voucher,Voucher.LoaiMA
--         INTO v_code,v_LoaiMA
--         FROM HoaDon
--         LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
--         WHERE ID_HoaDon=:old.ID_HoaDon;
--     --Tim loai mon an cua Mon an vua duoc xoa khoi CTHD
--         SELECT Loai
--         INTO MA_Loai
--         FROM MonAn
--         WHERE ID_MonAn = :old.ID_MonAn;
--     END IF;
--
--     IF(v_code IS NOT NULL) THEN
--         IF(v_LoaiMA='All' OR v_LoaiMA=MA_Loai) THEN
--             IF INSERTING THEN
--                 UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(:new.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
--             END IF;
--
--             IF UPDATING THEN
--                 UPDATE HoaDon SET TienGiam = TienGiam + Tinhtiengiam(:new.ThanhTien,v_code) - Tinhtiengiam(:old.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
--             END IF;
--
--             IF DELETING THEN
--                 UPDATE HoaDon SET TienGiam = TienGiam - Tinhtiengiam(:old.ThanhTien,v_code) WHERE HoaDon.ID_HoaDon=:old.ID_HoaDon;
--             END IF;
--         END IF;
--     END IF;
-- END;
-- /
-- -- Tong tien o Hoa Don = Tien mon an - Tien giam
-- CREATE OR REPLACE TRIGGER Tg_HD_Tongtien
-- AFTER INSERT OR UPDATE OF TienMonAn,TienGiam ON HoaDon
-- BEGIN
--     UPDATE HoaDon SET Tongtien= TienMonAn - TienGiam;
-- END;
-- /
-- -- Khi cap nhat Code_Voucher o HoaDon, Tinh tien giam theo thong tin cua Voucher do va giam Diem tich luy cua KH
-- CREATE OR REPLACE TRIGGER Tg_HD_DoiVoucher
-- BEFORE UPDATE OF Code_Voucher ON HoaDon
-- FOR EACH ROW
-- DECLARE
--     TongtienLoaiMonAnduocgiam number(8,0);
--     v_Diemdoi number;
--     v_Phantram number;
--     v_LoaiMA Voucher.LoaiMA%TYPE;
-- BEGIN
--     IF(:new.Code_Voucher is not null) THEN
--         SELECT Diem,Phantram,LoaiMA
--         INTO v_Diemdoi,v_Phantram,v_LoaiMA
--         FROM Voucher
--         WHERE Code_Voucher=:new.Code_Voucher;
--
--         KH_TruDTL(:new.ID_KH,v_diemdoi);
--         Voucher_GiamSL(:new.Code_Voucher);
--
--         IF(v_LoaiMA='All') THEN
--             TongtienLoaiMonAnduocgiam := :new.TienMonAn;
--         ELSE
--             SELECT SUM(Thanhtien)
--             INTO TongtienLoaiMonAnduocgiam
--             FROM CTHD
--             JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn
--             WHERE ID_HoaDon = :new.ID_HoaDon AND LOAI = v_LoaiMA;
--         END IF;
--
--         :new.Tiengiam := ROUND(TongtienLoaiMonAnduocgiam*v_Phantram/100);
--         :new.Tongtien := :new.Tienmonan-:new.Tiengiam;
--     ELSE
--         RAISE_APPLICATION_ERROR(-20000,'Voucher khong ton tai');
--     END IF;
-- END;
-- /
-- --Trigger Doanh so cua Khach hang bang tong tien cua tat ca hoa don co trang thai 'Da thanh toan'
-- --cua khach hang do
-- -- Diem tich luy cua Khach hang duoc tinh bang 0.005% Tong tien cua hoa don (1.000.000d tuong duong 50 diem)
-- CREATE OR REPLACE TRIGGER Tg_KH_DoanhsovaDTL
-- AFTER UPDATE OF Trangthai ON HoaDon
-- FOR EACH ROW
-- BEGIN
--     IF :new.Trangthai='Da thanh toan' THEN
--         UPDATE KhachHang SET Doanhso = Doanhso + :new.Tongtien WHERE ID_KH=:new.ID_KH;
--         UPDATE KhachHang SET Diemtichluy = Diemtichluy + ROUND(:new.Tongtien*0.00005)
--         WHERE ID_KH=:new.ID_KH;
--     END IF;
-- END;
-- /
-- --Trigger khi khach hang them hoa don moi, trang thai ban chuyen tu 'Con trong' sang 'Dang dung bua'
-- -- Khi trang thai don hang tro thanh 'Da thanh toan' trang thai ban chuyen tu 'Dang dung bua' sang 'Con trong'
--
-- CREATE OR REPLACE TRIGGER Tg_TrangthaiBan
-- AFTER INSERT OR UPDATE OF Trangthai ON HoaDon
-- FOR EACH ROW
-- BEGIN
--     IF(:new.Trangthai='Chua thanh toan') THEN
--         UPDATE Ban SET Trangthai='Dang dung bua' WHERE ID_Ban=:new.ID_Ban;
--     ELSE
--         UPDATE Ban SET Trangthai='Con trong' WHERE ID_Ban=:new.ID_Ban;
--     END IF;
-- END;
-- /
-- --  Trigger Thanh tien o CTNK bang SoLuong x Dongia cua nguyen lieu do
--
-- CREATE OR REPLACE TRIGGER Tg_CTNK_Thanhtien
-- BEFORE INSERT OR UPDATE OF SoLuong ON CTNK
-- FOR EACH ROW
-- DECLARE
--     gia NguyenLieu.DonGia%TYPE;
-- BEGIN
--     SELECT DonGia
--     INTO gia
--     FROM NguyenLieu
--     WHERE NguyenLieu.ID_NL = :new.ID_NL;
--
--     :new.ThanhTien := :new.SoLuong * gia;
--
-- END;
-- /
-- --Trigger Tong tien o PhieuNK bang tong thanh tien cua CTNK
-- CREATE OR REPLACE TRIGGER Tg_PNK_Tongtien
-- AFTER INSERT OR UPDATE OR DELETE ON CTNK
-- FOR EACH ROW
-- BEGIN
--     IF INSERTING THEN
--         UPDATE PhieuNK SET Tongtien = Tongtien + :new.ThanhTien WHERE PhieuNK.ID_NK = :new.ID_NK;
--     END IF;
--
--     IF UPDATING THEN
--         UPDATE PhieuNK SET Tongtien = Tongtien + :new.ThanhTien - :old.ThanhTien WHERE PhieuNK.ID_NK = :new.ID_NK;
--     END IF;
--
--     IF DELETING THEN
--         UPDATE PhieuNK SET Tongtien = Tongtien - :old.ThanhTien WHERE PhieuNK.ID_NK = :old.ID_NK;
--     END IF;
-- END;
-- /
-- --Trigger khi them CTNK tang So luong ton cua nguyen lieu trong kho
-- CREATE OR REPLACE TRIGGER Tg_Kho_ThemSLTon
-- AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTNK
-- FOR EACH ROW
-- BEGIN
--     IF INSERTING THEN
--         UPDATE Kho SET SLTon = SLTon + :new.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
--     END IF;
--
--     IF UPDATING THEN
--         UPDATE Kho SET SLTon = SLTon + :new.SoLuong - :old.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
--     END IF;
--
--     IF DELETING THEN
--         UPDATE Kho SET SLTon = SLTon - :old.SoLuong WHERE Kho.ID_NL = :old.ID_NL;
--     END IF;
-- END;
-- /
-- --Trigger khi them CTXK giam So luong ton cua nguyen lieu trong kho
-- CREATE OR REPLACE TRIGGER Tg_Kho_GiamSLTon
-- AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTXK
-- FOR EACH ROW
-- BEGIN
--     IF INSERTING THEN
--         UPDATE Kho SET SLTon = SLTon - :new.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
--     END IF;
--
--     IF UPDATING THEN
--         UPDATE Kho SET SLTon = SLTon - :new.SoLuong + :old.SoLuong WHERE Kho.ID_NL = :new.ID_NL;
--     END IF;
--
--     IF DELETING THEN
--         UPDATE Kho SET SLTon = SLTon + :old.SoLuong WHERE Kho.ID_NL = :old.ID_NL;
--     END IF;
-- END;
-- /
-- --Trigger khi them mot Nguyen Lieu moi, them NL do vao Kho
-- CREATE OR REPLACE TRIGGER Tg_Kho_ThemNL
-- AFTER INSERT ON NguyenLieu
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO Kho(ID_NL) VALUES(:new.ID_NL);
-- END;
-- /
--
-- --Procedure
-- --Procudure them mot khach hang moi voi cac thong tin tenKH , NgayTG va ID_ND
-- CREATE OR REPLACE PROCEDURE KH_ThemKH(tenKH KHACHHANG.TenKH%TYPE, NgayTG KHACHHANG.Ngaythamgia%TYPE,
-- ID_ND KHACHHANG.ID_ND%TYPE)
-- IS
--     v_ID_KH KHACHHANG.ID_KH%TYPE;
-- IS
-- BEGIN
--     --Them ma KH tiep theo
--     SELECT MIN(ID_KH)+1
--     INTO v_ID_KH
--     FROM KHACHHANG
--     WHERE ID_KH + 1 NOT IN(SELECT ID_KH FROM KHACHHANG);
--
--     INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (v_ID_KH,tenKH,TO_DATE(NgayTG,'dd-MM-YYYY'),ID_ND);
--     EXCEPTION WHEN NO_DATA_FOUND THEN
--         RAISE_APPLICATION_ERROR('Thong tin khong hop le');
-- END;
-- /
-- --Procudure them mot nhan vien moi voi cac thong tin tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang
-- CREATE OR REPLACE PROCEDURE NV_ThemNV(tenNV NHANVIEN.TenNV%TYPE, NgayVL NHANVIEN.NgayVL%TYPE, SDT NHANVIEN.SDT%TYPE,
-- Chucvu NHANVIEN.Chucvu%TYPE,ID_NQL NHANVIEN.ID_NQL%TYPE, Tinhtrang NHANVIEN.Tinhtrang%TYPE)
-- IS
--     v_ID_NV NHANVIEN.ID_NV%TYPE;
-- IS
-- BEGIN
--     --Them ma KH tiep theo
--     SELECT MIN(ID_NV)+1
--     INTO v_ID_NV
--     FROM NHANVIEN
--     WHERE ID_NV + 1 NOT IN(SELECT ID_NV FROM NHANVIEN);
--
--     INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang)
--     VALUES (v_ID_NV,tenNV,TO_DATE(NgayVL,'dd-MM-YYYY'),SDT,Chucvu,ID_NQL,Tinhtrang);
--     EXCEPTION WHEN NO_DATA_FOUND THEN
--         RAISE_APPLICATION_ERROR('Thong tin khong hop le');
-- END;
-- /
-- -- Procudure xoa mot NHANVIEN voi idNV
-- CREATE OR REPLACE PROCEDURE NV_XoaNV(idNV NHANVIEN.ID_NV%TYPE)
-- IS
--     v_count NUMBER;
--     idNQL NHANVIEN.ID_NQL%TYPE;
-- BEGIN
--     SELECT COUNT(ID_NV),ID_NQL
--     INTO v_count,ID_NQL
--     FROM NHANVIEN
--     WHERE ID_NV=idNV;
--
--     IF(v_count>0) THEN
--         IF (id_NV = idNQL) THEN
--             RAISE_APPLICATION_ERROR(-20000,'Khong the xoa QUAN LY');
--         ELSE
--             FOR cur IN (SELECT ID_NK FROM PHIEUNK
--             WHERE ID_NV=idNV
--             )
--             LOOP
--                 DELETE FROM CTNK WHERE ID_NK=cur.ID_NK;
--             END LOOP;
--
--             FOR cur IN (SELECT ID_XK FROM PHIEUXK
--             WHERE ID_NV=idNV
--             )
--             LOOP
--                 DELETE FROM CTXK WHERE ID_XK=cur.ID_XK;
--             END LOOP;
--
--             DELETE FROM PHIEUNK WHERE ID_NV=idNV;
--             DELETE FROM PHIEUNK WHERE ID_NV=idNV;
--             DELETE FROM NHANVIEN WHERE ID_NV=idNV;
--         END IF;
--     ELSE
--         RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
--     END IF;
-- END;
-- /
-- -- Procudure xoa mot KHACHHANG voi idKH
-- CREATE OR REPLACE PROCEDURE KH_XoaKH(idKH KHACHHANG.ID_KH%TYPE)
-- IS
--     v_count NUMBER;
-- BEGIN
--     SELECT COUNT(*)
--     INTO v_count
--     FROM KHACHHANG
--     WHERE ID_KH=idKH;
--
--     IF(v_count>0) THEN
--         FOR cur IN (SELECT ID_HoaDon FROM HOADON
--         WHERE ID_KH=idKH
--         )
--         LOOP
--             DELETE FROM CTHD WHERE ID_HoaDon=cur.ID_HoaDon;
--         END LOOP;
--         DELETE FROM HOADON WHERE ID_KH=idKH;
--         DELETE FROM KHACHHANG WHERE ID_KH=idKH;
--     ELSE
--         RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
--     END IF;
-- END;
-- /
--
-- -- Procedure xem thong tin KHACHHANG voi thong tin idKH
-- CREATE OR REPLACE PROCEDURE KH_XemTT(idKH KHACHHANG.ID_KH%TYPE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT TenKH,Ngaythamgia,Doanhso,Diemtichluy,ID_ND
--     FROM KHACHHANG WHERE ID_KH=idKH;
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||idKH);
--         DBMS_OUTPUT.PUT_LINE('Ten khach hang: '||cur.TenKH);
--         DBMS_OUTPUT.PUT_LINE('Ngay tham gia: '||TO_CHAR(cur.Ngaythamgia,'dd-MM-YYYY');
--         DBMS_OUTPUT.PUT_LINE('Doanh so: '||cur.Doanhso);
--         DBMS_OUTPUT.PUT_LINE('Diemtichluy: '||cur.Diemtichluy);
--         DBMS_OUTPUT.PUT_LINE('Ma nguoi dung: '||cur.ID_ND);
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
--     END LOOP;
-- END;
-- /
-- -- Procedure xem thong tin NHANVIEN voi thong tin idNV
-- CREATE OR REPLACE PROCEDURE NV_XemTT(idNV NHANVIEN.ID_NV%TYPE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT TenKH,NgayVL,SDT,Chucvu,ID_NQL
--     FROM NHANVIEN WHERE ID_NV=idNV;
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||idNV);
--         DBMS_OUTPUT.PUT_LINE('Ten nhan vien: '||cur.TenNV);
--         DBMS_OUTPUT.PUT_LINE('Ngay vao lam: '||TO_CHAR(cur.NgayVL,'dd-MM-YYYY');
--         DBMS_OUTPUT.PUT_LINE('Chuc vu: '||cur.Chucvu);
--         DBMS_OUTPUT.PUT_LINE('Ma nguoi quan ly: '||cur.ID_NQL);
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
--     END LOOP;
-- END;
-- /
--
-- -- Procedure liet ke danh sach hoa don tu ngay A den ngay B
-- CREATE OR REPLACE PROCEDURE DS_HoaDon_tuAdenB(fromA DATE, toB DATE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT ID_HOADON,ID_KH,ID_BAN,NGAYHD,TIENMONAN,TIENGIAM,TONGTIEN,TRANGTHAI
--     FROM HOADON WHERE NGAYHD BETWEEN fromA AND (toB +1);
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma hoa don: '||cur.ID_HOADON);
--         DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||cur.ID_KH);
--         DBMS_OUTPUT.PUT_LINE('Ma ban: '||cur.ID_BAN);
--         DBMS_OUTPUT.PUT_LINE('Ngay hoa don: '||TO_CHAR(cur.NgayHD,'dd-MM-YYYY');
--         DBMS_OUTPUT.PUT_LINE('Tien mon an: '||cur.TIENMONAN);
--         DBMS_OUTPUT.PUT_LINE('Tien giam: '||cur.TIENGIAM);
--         DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
--         DBMS_OUTPUT.PUT_LINE('Trang thai: '||cur.TRANGTHAI);
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
--     END LOOP;
-- END;
-- /
-- -- Procedure liet ke danh sach phieu nhap kho tu ngay A den ngay B
-- CREATE OR REPLACE PROCEDURE DS_PhieuNK_tuAdenB(fromA DATE, toB DATE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT ID_NK,ID_NV,NGAYNK,TONGTIEN
--     FROM PHIEUNK WHERE NGAYNK BETWEEN fromA AND (toB +1);
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma nhap kho: '||cur.ID_NK);
--         DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
--         DBMS_OUTPUT.PUT_LINE('Ngay nhap kho: '||TO_CHAR(cur.NGAYNK,'dd-MM-YYYY');
--         DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
--     END LOOP;
-- END;
-- /
--
-- -- Procedure liet ke danh sach phieu xuat kho tu ngay A den ngay B
-- CREATE OR REPLACE PROCEDURE DS_PhieuXK_tuAdenB(fromA DATE, toB DATE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT ID_XK,ID_NV,NGAYXK
--     FROM PHIEUXK WHERE NGAYXK BETWEEN fromA AND (toB +1);
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma xuat kho: '||cur.ID_XK);
--         DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
--         DBMS_OUTPUT.PUT_LINE('Ngay xuat kho: '||TO_CHAR(cur.NGAYXK,'dd-MM-YYYY');
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
--     END LOOP;
-- END;
-- /
-- -- Procedure xem chi tiet hoa don cua 1 hoa don
-- CREATE OR REPLACE PROCEDURE HD_XemCTHD(idHD HOADON.ID_HOADON%TYPE)
-- IS
-- BEGIN
--     FOR cur IN (SELECT ID_MONAN,SOLUONG,THANHTIEN
--     FROM CTHD WHERE ID_HOADON=idHD;
--     )
--     LOOP
--         DBMS_OUTPUT.PUT_LINE('Ma mon an: '||cur.ID_MONAN);
--         DBMS_OUTPUT.PUT_LINE('So luong: '||cur.SOLUONG);
--         DBMS_OUTPUT.PUT_LINE('Thanh tien: '||cur.THANHTIEN);
--
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--              RAISE_APPLICATION_ERROR(-20000,'Khong co chi tiet hoa don nao');
--     END LOOP;
-- END;
-- /
-- -- Procedure giam So Luong cua Voucher di 1 khi KH doi Voucher
-- CREATE OR REPLACE PROCEDURE Voucher_GiamSL(code Voucher.Code_Voucher%TYPE)
-- IS
--     v_count NUMBER;
-- BEGIN
--     SELECT COUNT(*)
--     INTO v_count
--     FROM Voucher
--     WHERE Code_Voucher=code;
--     IF(v_count>0) THEN
--         UPDATE Voucher SET SoLuong = SoLuong - 1 WHERE Code_Voucher=code;
--     ELSE
--         RAISE_APPLICATION_ERROR(-20000,'Voucher khong ton tai');
--     END IF;
-- END;
-- /
--
-- -- Procedure giam Diem tich luy cua KH khi doi Voucher
-- CREATE OR REPLACE PROCEDURE KH_TruDTL(ID KHACHHANG.ID_KH%TYPE,diemdoi NUMBER)
-- IS
--     v_count NUMBER;
-- BEGIN
--     SELECT COUNT(*)
--     INTO v_count
--     FROM KHACHHANG
--     WHERE ID_KH=ID;
--     IF(v_count>0) THEN
--         UPDATE KHACHHANG SET Diemtichluy = Diemtichluy - diemdoi WHERE ID_KH=ID;
--     ELSE
--         RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
--     END IF;
-- END;
-- /
--
-- --Fuction
-- --Fuction Tinh doanh thu hoa don theo ngay
-- CREATE OR REPLACE FUNCTION DoanhThuHD_theoNgay (ngHD DATE)
-- RETURN NUMBER
-- IS
--     v_Doanhthu NUMBER;
-- BEGIN
--     SELECT SUM(Tongtien)
--     INTO v_Doanhthu
--     FROM HOADON
--     WHERE NGAYHD=ngHD;
--
--     v_Doanhthu := NVL(v_Doanhthu,0);
--     RETURN v_Doanhthu;
-- END;
-- /
-- --Fuction Tinh chi phi nhap kho theo ngay
-- CREATE OR REPLACE FUNCTION ChiPhiNK_theoNgay (ngNK DATE)
-- RETURN NUMBER
-- IS
--     v_Chiphi NUMBER;
-- BEGIN
--     SELECT SUM(Tongtien)
--     INTO v_Chiphi
--     FROM PHIEUNK
--     WHERE NGAYNK=ngNK;
--
--     v_Chiphi := NVL(v_Chiphi,0);
--     RETURN v_Chiphi;
-- END;
-- /
-- --Fuction Tinh doanh so trung binh cua x KHACHHANG co doanh so cao nhat
-- CREATE OR REPLACE FUNCTION DoanhsoTB_TOPxKH(x INT)
-- RETURN DECIMAL
-- IS
--    v_avg DECIMAL;
-- BEGIN
--     SELECT AVG(Doanhso)
--     INTO v_avg
--     FROM (
--         SELECT Doanhso
--         FROM KHACHHANG
--         ORDER BY Doanhso DESC
--         FETCH FIRST x ROWS ONLY
--         );
--     RETURN v_avg;
-- END;
-- /
--
-- --Fuction Tinh so luong KHACHANG moi trong thang chi dinh cua nam co it nhat mot hoa don co tri gia tren x vnd
-- CREATE OR REPLACE FUNCTION SL_KH_Moi(thang NUMBER, nam NUMBER, trigiaHD NUMBER)
-- RETURN NUMBER
-- IS
--    v_count NUMBER;
-- BEGIN
--     SELECT COUNT(ID_KH)
--     INTO v_count;
--     FROM KHACHHANG
--     WHERE EXTRACT(MONTH FROM Ngaythamgia)=thang AND EXTRACT(YEAR FROM Ngaythamgia) = nam
--     AND EXISTS(SELECT *
--                FROM HOADON
--                WHERE HOADON.ID_KH=KHACHHANG.ID_KH AND TONGTIEN>trigiaHD
--                );
--     RETURN v_count;
-- END;
-- /
--
-- --Fuction Tinh tien mon an duoc giam khi them mot CTHD moi
-- CREATE OR REPLACE FUNCTION CTHD_Tinhtiengiam(Tongtien Number,Code Voucher.Code_Voucher%TYPE)
-- RETURN NUMBER
-- IS
--     Tiengiam NUMBER;
--     v_phantram NUMBER;
-- BEGIN
--     SELECT Phantram
--     INTO v_Phantram
--     FROM Voucher
--     WHERE Code_Voucher=Code;
--     Tiengiam := ROUND(Tongtien*v_Phantram/100);
--     RETURN Tiengiam;
-- END;
-- /
--Them data
SET SESSION sql_mode = '';

-- Thêm dữ liệu vào bảng NguoiDung
INSERT INTO NguoiDung (ID_ND, Email, MatKhau, Trangthai, Vaitro) VALUES
                                                                     (100, 'NVHoangViet@gmail.com', '123', 'Verified', 'Quan Ly'),
                                                                     (101, 'NVHoangPhuc@gmail.com', '123', 'Verified', 'Nhan Vien'),
                                                                     (102, 'NVAnhHong@gmail.com', '123', 'Verified', 'Nhan Vien Kho'),
                                                                     (103, 'NVQuangDinh@gmail.com', '123', 'Verified', 'Nhan Vien'),
                                                                     (104, 'KHThaoDuong@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (105, 'KHTanHieu@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (106, 'KHQuocThinh@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (107, 'KHNhuMai@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (108, 'KHBichHao@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (109, 'KHMaiQuynh@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (110, 'KHMinhQuang@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (111, 'KHThanhHang@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (112, 'KHThanhNhan@gmail.com', '123', 'Verified', 'Khach Hang'),
                                                                     (113, 'KHPhucNguyen@gmail.com', '123', 'Verified', 'Khach Hang');

-- Thêm dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (ID_NV, TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL, Tinhtrang) VALUES
                                                                                       (100, 'Nguyen Hoang Viet', '2023-05-10', '0848044725', 'Quan ly', 100, 100, 'Dang lam viec'),
                                                                                       (101, 'Nguyen Hoang Phuc', '2023-05-20', '0838033334', 'Tiep tan', 101, 100, 'Dang lam viec'),
                                                                                       (102, 'Le Thi Anh Hong', '2023-05-19', '0838033234', 'Kho', 102, 100, 'Dang lam viec'),
                                                                                       (103, 'Ho Quang Dinh', '2023-05-19', '0838033234', 'Tiep tan', 103, 100, 'Dang lam viec');

-- Nhân viên không có tài khoản
INSERT INTO NhanVien (ID_NV, TenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang) VALUES
                                                                                (104, 'Ha Thao Duong', '2023-05-10', '0838033232', 'Phuc vu', 100, 'Dang lam viec'),
                                                                                (105, 'Nguyen Quoc Thinh', '2023-05-11', '0838033734', 'Phuc vu', 100, 'Dang lam viec'),
                                                                                (106, 'Truong Tan Hieu', '2023-05-12', '0838033834', 'Phuc vu', 100, 'Dang lam viec'),
                                                                                (107, 'Nguyen Thai Bao', '2023-05-10', '0838093234', 'Phuc vu', 100, 'Dang lam viec'),
                                                                                (108, 'Tran Nhat Khang', '2023-05-11', '0838133234', 'Thu ngan', 100, 'Dang lam viec'),
                                                                                (109, 'Nguyen Ngoc Luong', '2023-05-12', '0834033234', 'Bep', 100, 'Dang lam viec');

-- Thêm dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (ID_KH, TenKH, Ngaythamgia, ID_ND) VALUES
                                                             (100, 'Ha Thao Duong', '2023-05-10', 104),
                                                             (101, 'Truong Tan Hieu', '2023-05-10', 105),
                                                             (102, 'Nguyen Quoc Thinh', '2023-05-10', 106),
                                                             (103, 'Tran Nhu Mai', '2023-05-10', 107),
                                                             (104, 'Nguyen Thi Bich Hao', '2023-05-10', 108),
                                                             (105, 'Nguyen Mai Quynh', '2023-05-11', 109),
                                                             (106, 'Hoang Minh Quang', '2023-05-11', 110),
                                                             (107, 'Nguyen Thanh Hang', '2023-05-12', 111),
                                                             (108, 'Nguyen Ngoc Thanh Nhan', '2023-05-11', 112),
                                                             (109, 'Hoang Thi Phuc Nguyen', '2023-05-12', 113);

-- Thêm dữ liệu vào bảng MonAn
INSERT INTO MonAn (ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES
                                                                  (1, 'DUI CUU NUONG XE NHO', 250000, 'Aries', 'Dang kinh doanh'),
                                                                  (2, 'BE SUON CUU NUONG GIAY BAC MONG CO', 230000, 'Aries', 'Dang kinh doanh'),
                                                                  (3, 'DUI CUU NUONG TRUNG DONG', 350000, 'Aries', 'Dang kinh doanh'),
                                                                  (4, 'CUU XOC LA CA RI', 129000, 'Aries', 'Dang kinh doanh'),
                                                                  (5, 'CUU KUNGBAO', 250000, 'Aries', 'Dang kinh doanh'),
                                                                  (6, 'BAP CUU NUONG CAY', 250000, 'Aries', 'Dang kinh doanh'),
                                                                  (7, 'CUU VIEN HAM CAY', 19000, 'Aries', 'Dang kinh doanh'),
                                                                  (8, 'SUON CONG NUONG MONG CO', 250000, 'Aries', 'Dang kinh doanh'),
                                                                  (9, 'DUI CUU LON NUONG TAI BAN', 750000, 'Aries', 'Dang kinh doanh'),
                                                                  (10, 'SUONG CUU NUONG SOT NAM', 450000, 'Aries', 'Dang kinh doanh'),
                                                                  (11, 'DUI CUU NUONG TIEU XANH', 285000, 'Aries', 'Dang kinh doanh'),
                                                                  (12, 'SUON CUU SOT PHO MAI', 450000, 'Aries', 'Dang kinh doanh'),
                                                                  (13, 'Bit tet bo My khoai tay', 179000, 'Taurus', 'Dang kinh doanh'),
                                                                  (14, 'Bo bit tet Uc', 169000, 'Taurus', 'Dang kinh doanh'),
                                                                  (15, 'Bit tet bo My BASIC', 179000, 'Taurus', 'Dang kinh doanh'),
                                                                  (16, 'My Y bo bam', 169000, 'Taurus', 'Dang kinh doanh');


insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(35,'BOSSAM', 650000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(36,'KIMCHI PANCAKE', 350000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(37,'SPICY RICE CAKE', 250000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(38,'SPICY SAUSAGE HOTPOT', 650000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(39,'SPICY PORK', 350000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(40,'MUSHROOM SPICY SILKY TOFU STEW', 350000,'Leo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(41,'Pavlova', 150000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(42,'Kesutera', 120000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(43,'Cremeschnitte', 250000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(44,'Sachertorte', 150000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(45,'Schwarzwalder Kirschtorte', 250000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(46,'New York-Style Cheesecake', 250000,'Virgo','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(47,'Cobb Salad', 150000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(48,'Salad Israeli', 120000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(49,'Salad Dau den', 120000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(50,'Waldorf Salad', 160000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(51,'Salad Gado-Gado', 200000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(52,'Nicoise Salad', 250000,'Libra','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(53,'BULGOGI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(54,'CHICKEN TERIYAKI LUNCHBOX', 350000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(55,'SPICY PORK LUNCHBOX', 350000,'Scorpio','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(56,'TOFU TERIYAKI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh');

insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(57,'Thit ngua do tuoi', 250000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(58,'Steak Thit ngua', 350000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(59,'Thit ngua ban gang', 350000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(60,'Long ngua xao dua', 150000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(61,'Thit ngua xao sa ot', 250000,'Sagittarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(62,'Ngua tang', 350000,'Sagittarius','Dang kinh doanh');

insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(63,'Thit de xong hoi', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(64,'Thit de xao rau ngo', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(65,'Thit de nuong tang', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(66,'Thit de chao', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(67,'Thit de nuong xien', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(68,'Nam de nuong/chao', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(69,'Thit de xao lan', 19000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(70,'Dui de tan thuoc bac', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(71,'Canh de ham duong quy', 199000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(72,'Chao de dau xanh', 50000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(73,'Thit de nhung me', 229000,'Capricorn','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(74,'Lau de nhu', 499000,'Capricorn','Dang kinh doanh');


insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(75,'SIGNATURE WINE', 3290000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(76,'CHILEAN WINE', 3990000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(77,'ARGENTINA WINE', 2890000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(78,'ITALIAN WINE', 5590000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(79,'AMERICAN WINE', 4990000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(80,'CLASSIC COCKTAIL', 200000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(81,'SIGNATURE COCKTAIL', 250000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(82,'MOCKTAIL', 160000,'Aquarius','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(83,'JAPANESE SAKE', 1490000,'Aquarius','Dang kinh doanh');

insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(84,'Ca Hoi Ngam Tuong', 289000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(85,'Ca Ngu Ngam Tuong', 289000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(86,'IKURA:Trung ca hoi', 189000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(87,'KARIN:Sashimi Ca Ngu', 149000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(88,'KEIKO:Sashimi Ca Hoi', 199000,'Pisces','Dang kinh doanh');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai) values(89,'CHIYO:Sashimi Bung Ca Hoi', 219000,'Pisces','Dang kinh doanh');

insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(100,'Ban T1.1','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(101,'Ban T1.2','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(102,'Ban T1.3','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(103,'Ban T1.4','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(104,'Ban T1.5','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(105,'Ban T1.6','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(106,'Ban T1.7','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(107,'Ban T1.8','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(108,'Ban T1.9','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(109,'Ban T1.10','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(110,'Ban T1.11','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(111,'Ban T1.12','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(112,'Ban T2.1','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(113,'Ban T2.2','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(114,'Ban T2.3','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(115,'Ban T2.4','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(116,'Ban T2.5','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(117,'Ban T2.6','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(118,'Ban T2.7','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(119,'Ban T2.8','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(120,'Ban T2.9','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(121,'Ban T2.10','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(122,'Ban T2.11','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(123,'Ban T2.12','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(124,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(125,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(126,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(127,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(128,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(129,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(130,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(131,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(132,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(133,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(134,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(135,'Ban T3.1','Tang 3','Con trong');

insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('loQy','20% off for Aries Menu',20,'Aries',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('pCfI','30% off for Taurus Menu',30,'Taurus',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('pApo','20% off for Gemini Menu',20,'Gemini',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('ugQx','100% off for Virgo Menu',100,'Virgo',3,500);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('nxVX','20% off for All Menu',20,'All',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('Pwyn','20% off for Cancer Menu',20,'Cancer',10,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('bjff','50% off for Leo Menu',50,'Leo',5,600);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('YPzJ','20% off for Aquarius Menu',20,'Aquarius',5,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('Y5g0','30% off for Pisces Menu',30,'Pisces',5,300);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('7hVO','60% off for Aries Menu',60,'Aries',0,1000);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('WHLm','20% off for Capricorn Menu',20,'Capricorn',0,200);
insert into Voucher(Code_Voucher, Phantram,LoaiMA,SoLuong,Diem) values ('GTsC','20% off for Leo Menu',20,'Leo',0,200);


INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (101,100,100,'10-1-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (102,104,102,'15-1-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (103,105,103,'20-1-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (104,101,101,'13-2-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (105,103,120,'12-2-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (106,104,100,'16-3-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (107,107,103,'20-3-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (108,108,101,'10-4-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (109,100,100,'20-4-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (110,103,101,'5-5-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (111,106,102,'10-5-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (112,108,103,'15-5-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (113,106,102,'20-5-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (114,108,103,'5-6-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (115,109,104,'7-6-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (116,100,105,'7-6-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (117,106,106,'10-6-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (118,102,106,'10-2-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (119,103,106,'12-2-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (120,104,106,'10-4-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (121,105,106,'12-4-2023',0,0,'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (122,107,106,'12-5-2023',0,0,'Chua thanh toan');

INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);
UPDATE HOADON SET TrangThai='Da thanh toan';

INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(115,'Thit de',130000,'kg');

INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'10-01-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'11-02-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'12-02-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'12-03-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'15-03-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'12-04-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'15-04-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'12-05-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'15-05-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'5-06-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'7-06-2023');

INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);

INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'10-01-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'11-02-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'12-03-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'13-03-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'12-04-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'13-04-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'12-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'15-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'20-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'5-06-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'10-06-2023');

INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);



