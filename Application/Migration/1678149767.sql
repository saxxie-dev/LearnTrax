CREATE TABLE tracks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    track_name TEXT NOT NULL,
    segment_count INT NOT NULL,
    segment_offset INT NOT NULL,
    segment_progress INT NOT NULL,
    segment_name TEXT NOT NULL,
    base_url TEXT NOT NULL
);
ALTER TABLE tracks ADD CONSTRAINT tracks_track_name_key UNIQUE(track_name);
CREATE TABLE streaks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL
);
CREATE INDEX tracks_user_id_index ON tracks (user_id);
ALTER TABLE tracks ADD CONSTRAINT tracks_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
