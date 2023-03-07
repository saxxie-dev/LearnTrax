-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL
);
CREATE TABLE tracks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    track_name TEXT NOT NULL UNIQUE,
    segment_count INT NOT NULL,
    segment_offset INT NOT NULL,
    segment_progress INT NOT NULL,
    segment_name TEXT NOT NULL,
    base_url TEXT NOT NULL,
    is_paused BOOLEAN DEFAULT false NOT NULL
);
CREATE TABLE streaks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL
);
CREATE INDEX tracks_user_id_index ON tracks (user_id);
CREATE INDEX streaks_user_id_index ON streaks (user_id);
ALTER TABLE streaks ADD CONSTRAINT streaks_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE tracks ADD CONSTRAINT tracks_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
