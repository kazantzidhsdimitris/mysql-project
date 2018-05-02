-- In this file, we'll create the tables for our fake IG accounts


-- creating table for users
CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) UNIQUE NOT NULL,
created_at TIMESTAMP DEFAULT NOW()
);

-- creating table for photos
CREATE TABLE photos(
id INT AUTO_INCREMENT PRIMARY KEY,
image_url VARCHAR(250) NOT NULL,
user_id INT NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id)
);

-- creating table for comments
CREATE TABLE comments(
id INT AUTO_INCREMENT PRIMARY KEY,
comment VARCHAR(255) NOT NULL,
user_id INT NOT NULL,
photo_id INT NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- creating table for likes (primary key at the end means that we have one unique combination of user & photo,prevents multiple likes.)
CREATE TABLE likes(
user_id INT NOT NULL,
photo_id INT NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(photo_id) REFERENCES photos(id),
PRIMARY KEY(user_id,photo_id)
);

-- creating table for follows
CREATE TABLE follows (
follower_id INT NOT NULL,
followee_id INT NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(follower_id) REFERENCES users(id),
FOREIGN KEY(followee_id) REFERENCES users(id),
PRIMARY KEY(follower_id,followee_id)
);

-- creating table for tags
CREATE TABLE tags(
id INT AUTO_INCREMENT PRIMARY KEY,
tag_name VARCHAR(255) UNIQUE,
created_at TIMESTAMP DEFAULT NOW()
);

-- creating table for tags in photos
CREATE TABLE photo_tags(
photo_id INT NOT NULL,
tag_id INT NOT NULL,
FOREIGN KEY(photo_id) REFERENCES photos(id),
FOREIGN KEY(tag_id) REFERENCES tags(id),
PRIMARY KEY(photo_id,tag_id)
);