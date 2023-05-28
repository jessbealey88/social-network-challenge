CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  username text,
  email text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views text,
  user_account_id int,
  constraint fk_artist foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);