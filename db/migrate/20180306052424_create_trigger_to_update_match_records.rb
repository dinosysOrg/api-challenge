class CreateTriggerToUpdateMatchRecords < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE FUNCTION update_match_records() RETURNS trigger AS $$
      DECLARE match_rule_id integer;
      BEGIN
        select id into match_rule_id from match_rules limit 1;
        IF (NEW.gave_up_player_id notnull) THEN
          insert into match_records(match_id, player_id, match_rule_id, win, loose, draw, created_at, updated_at)
          values(NEW.id, NEW.player_1_id, match_rule_id, NEW.gave_up_player_id <> NEW.player_1_id, NEW.gave_up_player_id = NEW.player_1_id, null, NEW.created_at, NEW.updated_at),
            (NEW.id, NEW.player_2_id, match_rule_id, NEW.gave_up_player_id <> NEW.player_2_id, NEW.gave_up_player_id = NEW.player_2_id, null, NEW.created_at, NEW.updated_at);
        ELSE
          insert into match_records(match_id, player_id, match_rule_id, win, loose, draw, created_at, updated_at)
          values(NEW.id, NEW.player_1_id, match_rule_id, (NEW.player_1_goals > NEW.player_2_goals), (NEW.player_1_goals < NEW.player_2_goals), (NEW.player_1_goals = NEW.player_2_goals), NEW.created_at, NEW.updated_at),
            (NEW.id, NEW.player_2_id, match_rule_id, (NEW.player_1_goals < NEW.player_2_goals), (NEW.player_1_goals > NEW.player_2_goals), (NEW.player_1_goals = NEW.player_2_goals), NEW.created_at, NEW.updated_at);
        END IF;
      RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;
      CREATE TRIGGER insert_match AFTER INSERT ON matches
        FOR EACH ROW EXECUTE PROCEDURE update_match_records();
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION update_match_records;
      DROP TRIGGER IF EXISTS insert_match on matches;
    SQL
  end
end
