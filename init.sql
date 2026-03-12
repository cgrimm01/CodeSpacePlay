CREATE ROLE mmuser LOGIN PASSWORD 'mmuser';
   
IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'mattermost')
THEN
  CREATE DATABASE mattermost OWNER mmuser;
  GRANT ALL PRIVILEGES ON DATABASE mattermost TO mmuser;
END IF;
