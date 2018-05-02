--  What if we want to reward our 5 oldest users.How are we gonna find them?

SELECT username,created_at FROM users 
ORDER BY created_at ASC
LIMIT 5;

-- What day of the week do most users register on?

SELECT DAYNAME(created_at),Count(*) FROM users
GROUP BY DAYNAME(created_at)
ORDER BY Count(*) DESC;


-- We want to target our inactive users(never posted a photo aka Ghost accounts),so we can send them an email.

SELECT username, IFNULL(image_url,'nothing posted') AS 'photos'
FROM users
LEFT JOIN photos
 ON users.id=photos.user_id 
WHERE image_url IS NULL
;

-- OR

SELECT
    users.username AS 'Users without photos'
FROM users
LEFT JOIN photos
    ON photos.user_id = users.id
GROUP BY users.id
HAVING COUNT(photos.id) = 0
;

-- Identify most popular photo(and user who created it)

SELECT username,image_url,COUNT(*) AS 'total likes' FROM photos
 JOIN likes
 ON likes.photo_id =photos.id
 JOIN users
 ON users.id=photos.user_id
GROUP BY photos.id
ORDER BY COUNT(*) DESC
LIMIT 1; 

-- Calculate avg number of photos per user

SELECT ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users),2) AS 'avg photos/users' ;


-- What are the TOP 6 hashtags

SELECT tag_name,COUNT(*) AS 'Commonly used hashtags' FROM tags
INNER JOIN photo_tags
ON photo_tags.tag_id=tags.id
GROUP BY tags.id
ORDER BY COUNT(*) DESC
LIMIT 6;

-- Find users who have liked every single photo

SELECT username, COUNT(*) AS 'Likes' FROM users
JOIN likes
ON users.id=likes.user_id
GROUP BY users.id
HAVING Likes = (SELECT COUNT(*) FROM photos)
;

-- OR

SELECT * FROM (
    SELECT username, 
           COUNT(photo_id) AS likes_count
    FROM users JOIN likes 
        ON users.id = likes.user_id
    GROUP BY username
) AS T
WHERE likes_count = (SELECT COUNT(*) FROM photos);
