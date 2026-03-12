CREATE ROLE mmuser LOGIN PASSWORD 'mmuser';
   
IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'mattermost')
THEN
   CREATE DATABASE mattermost WITH ENCODING 'UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0;
   GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;
END IF;
