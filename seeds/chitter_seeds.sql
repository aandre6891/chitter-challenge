-- (file: spec/seeds_{table_name}.sql)

TRUNCATE TABLE makers RESTART IDENTITY CASCADE;
TRUNCATE TABLE peeps RESTART IDENTITY CASCADE;

INSERT INTO makers (name, email, username, password) VALUES 
('Andrea', 'ruggieri6891@gmail.com', 'andre6891', 'graves86'),
('Ilaria', 'ilaria@fakemail.com', 'ilaria678', 'as89v89sdg98'),
('Chiara', 'chiara@fakemail.com', 'chiara6647', '778asd9svh'),
('Barbara', 'barbara@fakemail.com', 'barbara668', 'asd789sdf');

INSERT INTO peeps (title, content, time, maker_id) VALUES 
('Post 1', 'Hello, this is the first content.', '2023-01-08 04:05:06', '2'),
('Post 2', 'Hello, this is the content of the second post.', '2023-02-24 04:05:06', '1'),
('Post 3', 'Hello, this is the content of the third.', '2023-03-30 04:05:06', '3'),
('Post 4', 'Hello, this is the content of the fourth.', '2023-04-10 04:05:06', '4');