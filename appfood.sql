-- =============================================================
-- BÀI TẬP SQL - APP FOOD
-- Tạo database, table, column và dữ liệu theo sơ đồ diagram
-- Hệ quản trị: MySQL (chạy trên TablePlus)
-- =============================================================

DROP DATABASE IF EXISTS appfood;
CREATE DATABASE appfood
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE appfood;

-- =============================================================
-- 1. TẠO TABLE
-- =============================================================

-- ---------- user ----------
CREATE TABLE `user` (
    user_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email     VARCHAR(100),
    password  VARCHAR(100)
);

-- ---------- restaurant ----------
CREATE TABLE restaurant (
    res_id   INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(100),
    image    VARCHAR(255),
    `desc`   VARCHAR(255)
);

-- ---------- like_res ----------
CREATE TABLE like_res (
    user_id   INT,
    res_id    INT,
    date_like DATETIME,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (res_id)  REFERENCES restaurant (res_id)
);

-- ---------- rate_res ----------
CREATE TABLE rate_res (
    user_id   INT,
    res_id    INT,
    amount    INT,
    date_rate DATETIME,
    PRIMARY KEY (user_id, res_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (res_id)  REFERENCES restaurant (res_id)
);

-- ---------- food_type ----------
CREATE TABLE food_type (
    type_id   INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100)
);

-- ---------- food ----------
CREATE TABLE food (
    food_id   INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(100),
    image     VARCHAR(255),
    price     FLOAT,
    `desc`    VARCHAR(255),
    type_id   INT,
    FOREIGN KEY (type_id) REFERENCES food_type (type_id)
);

-- ---------- sub_food ----------
CREATE TABLE sub_food (
    sub_id    INT AUTO_INCREMENT PRIMARY KEY,
    sub_name  VARCHAR(100),
    sub_price FLOAT,
    food_id   INT,
    FOREIGN KEY (food_id) REFERENCES food (food_id)
);

-- ---------- order ----------
CREATE TABLE `order` (
    user_id    INT,
    food_id    INT,
    amount     INT,
    code       VARCHAR(50),
    arr_sub_id VARCHAR(255),
    PRIMARY KEY (user_id, food_id),
    FOREIGN KEY (user_id) REFERENCES `user` (user_id),
    FOREIGN KEY (food_id) REFERENCES food (food_id)
);

-- =============================================================
-- 2. THÊM DỮ LIỆU
-- =============================================================

-- ---------- user ----------
INSERT INTO `user` (user_id, full_name, email, password) VALUES
(1,  'Nguyen Van An',   'an.nguyen@gmail.com',    '123456'),
(2,  'Tran Thi Binh',   'binh.tran@gmail.com',    '123456'),
(3,  'Le Minh Cuong',   'cuong.le@gmail.com',     '123456'),
(4,  'Pham Thu Dung',   'dung.pham@gmail.com',    '123456'),
(5,  'Hoang Van Em',    'em.hoang@gmail.com',     '123456'),
(6,  'Vu Thi Giang',    'giang.vu@gmail.com',     '123456'),
(7,  'Do Minh Hai',     'hai.do@gmail.com',       '123456'),
(8,  'Bui Thi Lan',     'lan.bui@gmail.com',      '123456'),
(9,  'Ngo Van Khoa',    'khoa.ngo@gmail.com',     '123456'),
(10, 'Dang Thi Mai',    'mai.dang@gmail.com',     '123456');

-- ---------- restaurant ----------
INSERT INTO restaurant (res_id, res_name, image, `desc`) VALUES
(1, 'Com Tam Sai Gon',     'com-tam.jpg',   'Com tam suon bi cha chuan vi Sai Gon'),
(2, 'Pho Ha Noi',          'pho.jpg',       'Pho bo gia truyen Ha Noi'),
(3, 'Bun Cha Huong Lien',  'bun-cha.jpg',   'Bun cha than thanh, noi tieng Ha Noi'),
(4, 'Pizza 4Ps',           'pizza.jpg',     'Pizza phong cach Nhat - Y'),
(5, 'Lau Thai Tomyum',     'lau-thai.jpg',  'Lau Thai chua cay dam da');

-- ---------- food_type ----------
INSERT INTO food_type (type_id, type_name) VALUES
(1, 'Com'),
(2, 'Pho - Bun'),
(3, 'Pizza'),
(4, 'Lau'),
(5, 'Do uong');

-- ---------- food ----------
INSERT INTO food (food_id, food_name, image, price, `desc`, type_id) VALUES
(1, 'Com tam suon bi cha', 'com-tam-suon.jpg',  55000,  'Com tam suon nuong, bi, cha trung',  1),
(2, 'Com ga xoi mo',       'com-ga.jpg',        50000,  'Com ga da gion, an kem goi',         1),
(3, 'Pho bo tai',          'pho-bo.jpg',        60000,  'Pho bo tai nuoc dung ninh xuong',    2),
(4, 'Bun cha Ha Noi',      'bun-cha-hn.jpg',    65000,  'Bun cha thit nuong an kem nem ran',  2),
(5, 'Pizza hai san',       'pizza-hai-san.jpg', 199000, 'Pizza hai san de vien pho mai',      3),
(6, 'Lau Thai chua cay',   'lau-thai-cc.jpg',   350000, 'Lau Thai cho 2-3 nguoi',             4),
(7, 'Tra dao cam sa',      'tra-dao.jpg',       35000,  'Tra dao cam sa mat lanh',            5),
(8, 'Nuoc ep cam',         'nuoc-cam.jpg',      40000,  'Nuoc ep cam nguyen chat',            5);

-- ---------- sub_food ----------
INSERT INTO sub_food (sub_id, sub_name, sub_price, food_id) VALUES
(1,  'Them suon',        20000, 1),
(2,  'Them trung op la', 10000, 1),
(3,  'Them ga',          25000, 2),
(4,  'Them banh pho',    15000, 3),
(5,  'Them bo vien',     20000, 3),
(6,  'Them nem ran',     25000, 4),
(7,  'Them pho mai',     30000, 5),
(8,  'Them nam',         30000, 6),
(9,  'Them hai san',     80000, 6),
(10, 'Them tran chau',   10000, 7);

-- ---------- like_res ----------
-- So luot like theo user: u1=5, u2=4, u3=3, u4=2, u5=2, u6=1, u7=1
-- So luot like theo nha hang: res1=7, res2=5, res3=3, res4=2, res5=1
-- User 8, 9, 10 khong like nha hang nao
INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2024-01-05 09:15:00'),
(1, 2, '2024-01-06 10:20:00'),
(1, 3, '2024-01-07 11:30:00'),
(1, 4, '2024-01-08 12:40:00'),
(1, 5, '2024-01-09 13:50:00'),
(2, 1, '2024-01-10 08:00:00'),
(2, 2, '2024-01-11 09:10:00'),
(2, 3, '2024-01-12 10:20:00'),
(2, 4, '2024-01-13 11:30:00'),
(3, 1, '2024-01-14 14:00:00'),
(3, 2, '2024-01-15 15:10:00'),
(3, 3, '2024-01-16 16:20:00'),
(4, 1, '2024-01-17 17:00:00'),
(4, 2, '2024-01-18 18:10:00'),
(5, 1, '2024-01-19 19:00:00'),
(5, 2, '2024-01-20 20:10:00'),
(6, 1, '2024-01-21 08:30:00'),
(7, 1, '2024-01-22 09:40:00');

-- ---------- rate_res ----------
-- User 8, 9, 10 khong danh gia nha hang nao
INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2024-02-01 09:00:00'),
(1, 2, 4, '2024-02-02 10:00:00'),
(1, 3, 5, '2024-02-03 11:00:00'),
(2, 1, 4, '2024-02-04 12:00:00'),
(2, 3, 3, '2024-02-05 13:00:00'),
(3, 2, 5, '2024-02-06 14:00:00'),
(4, 1, 3, '2024-02-07 15:00:00'),
(5, 4, 4, '2024-02-08 16:00:00'),
(6, 1, 5, '2024-02-09 17:00:00'),
(7, 5, 2, '2024-02-10 18:00:00');

-- ---------- order ----------
-- So don hang theo user: u2=5, u1=3, u3=2, u5=2, u4=1, u6=1
-- User 7, 8, 9, 10 khong dat hang
INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) VALUES
(1, 1, 2, 'DH001', '1,2'),
(1, 2, 1, 'DH002', '3'),
(1, 3, 1, 'DH003', '4,5'),
(2, 1, 3, 'DH004', '1'),
(2, 3, 2, 'DH005', '5'),
(2, 4, 1, 'DH006', '6'),
(2, 5, 1, 'DH007', '7'),
(2, 6, 1, 'DH008', '8,9'),
(3, 1, 1, 'DH009', '2'),
(3, 2, 2, 'DH010', '3'),
(4, 7, 4, 'DH011', '10'),
(5, 3, 1, 'DH012', '4'),
(5, 4, 2, 'DH013', '6'),
(6, 1, 1, 'DH014', '1,2');

-- =============================================================
-- 3. CÁC CÂU TRUY VẤN THEO YÊU CẦU
-- =============================================================

-- -------------------------------------------------------------
-- Cau 1: Tim 5 nguoi da like nha hang nhieu nhat
-- -------------------------------------------------------------
SELECT
    u.user_id,
    u.full_name,
    u.email,
    COUNT(lr.res_id) AS so_luot_like
FROM `user` u
INNER JOIN like_res lr ON u.user_id = lr.user_id
GROUP BY u.user_id, u.full_name, u.email
ORDER BY so_luot_like DESC
LIMIT 5;

-- -------------------------------------------------------------
-- Cau 2: Tim 2 nha hang co luot like nhieu nhat
-- -------------------------------------------------------------
SELECT
    r.res_id,
    r.res_name,
    COUNT(lr.user_id) AS so_luot_like
FROM restaurant r
INNER JOIN like_res lr ON r.res_id = lr.res_id
GROUP BY r.res_id, r.res_name
ORDER BY so_luot_like DESC
LIMIT 2;

-- -------------------------------------------------------------
-- Cau 3: Tim nguoi da dat hang nhieu nhat
-- -------------------------------------------------------------
SELECT
    u.user_id,
    u.full_name,
    u.email,
    COUNT(o.food_id) AS so_don_hang,
    SUM(o.amount)    AS tong_so_luong
FROM `user` u
INNER JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name, u.email
ORDER BY so_don_hang DESC
LIMIT 1;

-- Cach viet lay ca truong hop bang diem (neu co nhieu nguoi cung dat nhieu nhat)
SELECT
    u.user_id,
    u.full_name,
    u.email,
    COUNT(o.food_id) AS so_don_hang
FROM `user` u
INNER JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name, u.email
HAVING COUNT(o.food_id) = (
    -- Luu y: COUNT(ten_cot) bo qua gia tri NULL, con COUNT(*) dem ca dong rong.
    -- Truy van nay khong co JOIN nen dung cach nao cung ra ket qua giong nhau,
    -- nhung ghi ro ten cot de thanh thoi quen an toan khi sau nay co LEFT JOIN.
    SELECT COUNT(food_id)
    FROM `order`
    GROUP BY user_id
    ORDER BY COUNT(food_id) DESC
    LIMIT 1
);

-- -------------------------------------------------------------
-- Cau 4: Tim nguoi dung khong hoat dong trong he thong
--        (khong dat hang, khong like, khong danh gia nha hang)
-- -------------------------------------------------------------
SELECT
    u.user_id,
    u.full_name,
    u.email
FROM `user` u
WHERE NOT EXISTS (SELECT 1 FROM `order`  o  WHERE o.user_id  = u.user_id)
  AND NOT EXISTS (SELECT 1 FROM like_res lr WHERE lr.user_id = u.user_id)
  AND NOT EXISTS (SELECT 1 FROM rate_res rr WHERE rr.user_id = u.user_id);

-- Cach viet 2: dung LEFT JOIN
SELECT
    u.user_id,
    u.full_name,
    u.email
FROM `user` u
LEFT JOIN `order`  o  ON u.user_id = o.user_id
LEFT JOIN like_res lr ON u.user_id = lr.user_id
LEFT JOIN rate_res rr ON u.user_id = rr.user_id
WHERE o.user_id  IS NULL
  AND lr.user_id IS NULL
  AND rr.user_id IS NULL;