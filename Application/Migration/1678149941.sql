ALTER TABLE streaks ADD COLUMN user_id UUID NOT NULL;
ALTER TABLE streaks ADD COLUMN start_date DATE NOT NULL;
ALTER TABLE tracks ADD COLUMN is_paused BOOLEAN DEFAULT false NOT NULL;
CREATE INDEX streaks_user_id_index ON streaks (user_id);
ALTER TABLE streaks ADD CONSTRAINT streaks_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
