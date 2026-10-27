-- INSTAGRAM MINI PROJECT USING MYSQL
-- Based on the uploaded Insta project SQL document.
-- Compatible with MySQL 8.0+
-- Run this complete script in MySQL Workbench.
-- WARNING: This script drops the existing instaproject database if it exists.

DROP DATABASE IF EXISTS instaproject;
CREATE DATABASE instaproject;
USE instaproject;

-- 1. CREATE TABLES
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(300) NOT NULL UNIQUE,
    email VARCHAR(250) NOT NULL,
    mobile VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_mobile_length CHECK (CHAR_LENGTH(mobile) = 10)
);

CREATE TABLE Photos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(250) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, photo_id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (photo_id) REFERENCES Photos(id)
);

CREATE TABLE Comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    c_text TEXT NOT NULL,
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (photo_id) REFERENCES Photos(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES Users(id),
    FOREIGN KEY (followee_id) REFERENCES Users(id),
    CONSTRAINT chk_no_self_follow CHECK (follower_id <> followee_id)
);

-- 2. SAMPLE USERS (fixed IDs keep all relationships consistent)
INSERT INTO Users (id, user_name, email, mobile) VALUES
(1, 'hacker_vasu', 'vasuhacker@gmail.com', '9988775544'),
(2, 'pra_bash_rebel', 'rebelbash@gmail.com', '8500075000'),
(3, 'kalapana_queen', 'unique_queen@gmail.com', '7569900800'),
(4, 'gowtham_mptc', 'powerstar_mptc@gmail.com', '9100560143'),
(5, 'rashmika_little_princess', 'princess_rashmika@gmail.com', '9700856956'),
(6, 'bapatla_prince', 'prince_bapatla@gmail.com', '9600075000'),
(7, 'prasad_harihara', 'veera_prasad@gmail.com', '8500074745'),
(8, 'pilli_venkata-simha', 'simhavenkat@gmail.com', '9640123143'),
(9, 'trendy_joel', 'hearthacker@gmail.com', '7500096000'),
(10, 'tiger_nayeem', 'juniortigernayeem@gmail.com', '9550950143');

-- 3. FOLLOW RELATIONSHIPS
INSERT INTO Follows (follower_id, followee_id) VALUES
(6,4), (6,3), (6,7), (6,2),
(4,10), (4,9), (4,5), (4,1), (4,7),
(1,4), (1,6),
(5,3), (5,6), (5,10),
(2,3), (2,5), (2,6), (2,9),
(9,6), (9,4), (9,5);

-- 4. PHOTOS
INSERT INTO Photos (image_url, user_id) VALUES
('1.com', 1), ('two.com', 2), ('thre.com', 3), ('foo.com', 4),
('ojbn.com', 7), ('hiio.com', 10), ('tjfwo.com', 1),
('twfkjno.com', 4), ('fjbn.com', 4), ('tkj.com', 4), ('khjb.com', 4);

-- 5. LIKES
INSERT INTO Likes (user_id, photo_id) VALUES
(1,2), (1,4), (1,5), (1,7), (1,8), (1,9), (1,11), (1,10),
(2,1), (2,3), (2,6), (2,7), (2,11),
(3,1), (3,2), (3,3), (3,4), (3,10), (3,11),
(4,3), (4,6), (4,9),
(7,3), (7,8), (7,9), (7,11),
(9,2), (9,4), (9,6), (9,9), (9,10), (9,11),
(10,1), (10,2), (10,3), (10,4), (10,5), (10,6), (10,7), (10,10);

-- 6. COMMENTS
INSERT INTO Comments (c_text, photo_id, user_id, created_at) VALUES
('Awesome shot', 1, 2, '2025-09-08 16:05:00'),
('Love this click', 1, 3, '2025-09-08 16:25:00'),
('Nice one!', 2, 1, '2025-09-08 17:10:00'),
('Cool vibes', 3, 5, '2025-09-08 18:00:00'),
('Sharp details', 4, 6, '2025-09-08 18:45:00'),
('Creative angle', 6, 10, '2025-09-09 10:10:00'),
('Well framed', 7, 2, '2025-09-09 11:30:00'),
('Epic vibes', 8, 7, '2025-09-09 12:15:00'),
('Looks amazing', 9, 9, '2025-09-09 13:20:00'),
('Legendary shot', 10, 3, '2025-09-09 14:00:00'),
('This is cool', 1, 9, '2025-09-10 09:05:00'),
('Great capture', 2, 6, '2025-09-10 09:50:00'),
('Classic moment', 3, 1, '2025-09-10 10:40:00'),
('Really nice', 4, 2, '2025-09-10 11:30:00'),
('High quality', 6, 7, '2025-09-10 12:15:00'),
('Very creative', 7, 10, '2025-09-10 13:20:00'),
('Nice memory', 8, 5, '2025-09-10 14:10:00'),
('Perfect lighting', 9, 2, '2025-09-10 15:05:00'),
('Amazing shot', 10, 1, '2025-09-10 16:00:00'),
('So aesthetic', 1, 6, '2025-09-11 09:20:00'),
('Tiger mode', 2, 10, '2025-09-11 10:15:00'),
('Epic one', 3, 9, '2025-09-11 11:00:00'),
('Good vibes', 4, 5, '2025-09-11 11:40:00'),
('Beautiful pic', 6, 3, '2025-09-11 12:30:00'),
('Lovely shot', 7, 1, '2025-09-11 13:15:00'),
('Superb clarity', 8, 2, '2025-09-11 14:00:00'),
('Nice background', 9, 10, '2025-09-11 15:10:00'),
('Wonderful shot', 10, 7, '2025-09-11 16:20:00'),
('Cool style', 1, 5, '2025-09-12 09:30:00'),
('Elegant frame', 2, 3, '2025-09-12 10:10:00');

-- =====================================================
-- 7. ALL 22 QUERIES FROM THE UPLOADED DOCUMENT
-- =====================================================

-- Q1. Number of followers of all users
SELECT u.id, u.user_name, COUNT(f.follower_id) AS followers_count
FROM Users u
LEFT JOIN Follows f ON u.id = f.followee_id
GROUP BY u.id, u.user_name
ORDER BY followers_count DESC;

-- Q2. Number of people each user is following
SELECT u.id, u.user_name, COUNT(f.followee_id) AS following_count
FROM Users u
LEFT JOIN Follows f ON u.id = f.follower_id
GROUP BY u.id, u.user_name
ORDER BY following_count DESC;

-- Q3. Number of users with zero followers
SELECT COUNT(*) AS users_with_zero_followers
FROM Users u
LEFT JOIN Follows f ON u.id = f.followee_id
WHERE f.follower_id IS NULL;

-- Q4. Number of users having at least one follower
SELECT COUNT(DISTINCT u.id) AS users_with_at_least_one_follower
FROM Users u
INNER JOIN Follows f ON u.id = f.followee_id;

-- Q5. Number of users not following anyone
SELECT COUNT(*) AS users_not_following_anyone
FROM Users u
LEFT JOIN Follows f ON u.id = f.follower_id
WHERE f.follower_id IS NULL;

-- Q6. Number of users following at least one person
SELECT COUNT(DISTINCT u.id) AS users_following_at_least_one
FROM Users u
INNER JOIN Follows f ON u.id = f.follower_id;

-- Q7. Followers and following count for each user
SELECT u.id, u.user_name,
       COALESCE(fr.followers_count, 0) AS followers_count,
       COALESCE(fg.following_count, 0) AS following_count
FROM Users u
LEFT JOIN (
    SELECT followee_id, COUNT(*) AS followers_count
    FROM Follows GROUP BY followee_id
) fr ON u.id = fr.followee_id
LEFT JOIN (
    SELECT follower_id, COUNT(*) AS following_count
    FROM Follows GROUP BY follower_id
) fg ON u.id = fg.follower_id
ORDER BY u.id;

-- Q8. Number of photos uploaded by each user
SELECT u.id, u.user_name, COUNT(p.id) AS photo_count
FROM Users u
LEFT JOIN Photos p ON u.id = p.user_id
GROUP BY u.id, u.user_name
ORDER BY photo_count DESC;

-- Q9. Users who uploaded at least one photo
SELECT u.id, u.user_name
FROM Users u
WHERE EXISTS (SELECT 1 FROM Photos p WHERE p.user_id = u.id);

-- Q10. Users who have not uploaded any photos
SELECT u.id, u.user_name
FROM Users u
LEFT JOIN Photos p ON u.id = p.user_id
WHERE p.id IS NULL;

-- Q11. Number of likes for each photo
SELECT p.id AS photo_id, p.image_url, COUNT(l.user_id) AS likes_count
FROM Photos p
LEFT JOIN Likes l ON p.id = l.photo_id
GROUP BY p.id, p.image_url
ORDER BY likes_count DESC;

-- Q12. Photos having zero likes
SELECT p.id AS photo_id, p.image_url
FROM Photos p
LEFT JOIN Likes l ON p.id = l.photo_id
WHERE l.photo_id IS NULL;

-- Q13. Photos having at least one like
SELECT p.id AS photo_id, p.image_url, COUNT(l.user_id) AS likes_count
FROM Photos p
INNER JOIN Likes l ON p.id = l.photo_id
GROUP BY p.id, p.image_url;

-- Q14. Number of likes given by each user
SELECT u.id, u.user_name, COUNT(l.photo_id) AS likes_given
FROM Users u
LEFT JOIN Likes l ON u.id = l.user_id
GROUP BY u.id, u.user_name
ORDER BY likes_given DESC;

-- Q15. Users who did not like any photo
SELECT u.id, u.user_name
FROM Users u
LEFT JOIN Likes l ON u.id = l.user_id
WHERE l.photo_id IS NULL;

-- Q16. Users who liked at least one photo
SELECT DISTINCT u.id, u.user_name
FROM Users u
INNER JOIN Likes l ON u.id = l.user_id;

-- Q17. Number of comments posted by each user
SELECT u.id, u.user_name, COUNT(c.id) AS comments_count
FROM Users u
LEFT JOIN Comments c ON u.id = c.user_id
GROUP BY u.id, u.user_name
ORDER BY comments_count DESC;

-- Q18. Number of comments received by each photo
SELECT p.id AS photo_id, p.image_url, COUNT(c.id) AS comments_count
FROM Photos p
LEFT JOIN Comments c ON p.id = c.photo_id
GROUP BY p.id, p.image_url
ORDER BY comments_count DESC;

-- Q19. Users who have not commented
SELECT u.id, u.user_name
FROM Users u
LEFT JOIN Comments c ON u.id = c.user_id
WHERE c.id IS NULL;

-- Q20. Photos that have not received any comments
SELECT p.id AS photo_id, p.image_url
FROM Photos p
LEFT JOIN Comments c ON p.id = c.photo_id
WHERE c.id IS NULL;

-- Q21. Photos that received at least 3 comments
SELECT p.id AS photo_id, p.image_url, COUNT(c.id) AS comments_count
FROM Photos p
INNER JOIN Comments c ON p.id = c.photo_id
GROUP BY p.id, p.image_url
HAVING COUNT(c.id) >= 3;

-- Q22. Users who commented at least twice
SELECT u.id, u.user_name, COUNT(c.id) AS comments_count
FROM Users u
INNER JOIN Comments c ON u.id = c.user_id
GROUP BY u.id, u.user_name
HAVING COUNT(c.id) >= 2;

-- END OF PROJECT
