-- createuser -s -U myuser -p 5050 bernaddwiki
-- createuser -P -U myuser -p 5050 test
CREATE USER koda PASSWORD 'dako' VALID UNTIL '2026-05-07 00:00';
ALTER USER koda VALID UNTIL '2026-05-07 00:00:00+07';

CREATE DATABASE koda OWNER koda; -- psql -U koda -h localhost -p 5050
CREATE DATABASE test OWNER test;