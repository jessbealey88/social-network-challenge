TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO user_accounts (username, email) VALUES ('joebloggs99', 'joebloggs99@hotmail.com');
INSERT INTO user_accounts (username, email) VALUES ('jane_smith79', 'smith.jane@gmail.com');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_1', 'some text about stuff', '10', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_2', 'some celebrity gossip', '5', '2');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_2', 'Happy birthday message to a friend', '12', '1');