CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    login_count INT DEFAULT 0 NOT NULL
);
CREATE TABLE tracks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    track_name TEXT NOT NULL,
    segment_count INT DEFAULT 1 NOT NULL,
    segment_offset INT NOT NULL,
    segment_progress INT NOT NULL,
    segment_name TEXT NOT NULL,
    base_url TEXT NOT NULL,
    is_paused BOOLEAN DEFAULT false NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE INDEX tracks_user_id_index ON tracks (user_id);
CREATE INDEX tracks_created_at_index ON tracks (created_at);
CREATE TRIGGER update_tracks_updated_at BEFORE UPDATE ON tracks FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
ALTER TABLE tracks ADD CONSTRAINT tracks_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
