class Match < ApplicationRecord
	after_create :winner_have_3
	after_update :update_score , if: :saved_change_to_result?
	after_destroy :reduce_score
	belongs_to :tournament
	belongs_to :group
	belongs_to :venue
	validates :name, presence: true
	validates :player_id1 , presence: true
	validates :player_id2 , presence: true
	validates :result, presence: true

	def winner_have_3
		if self.result.include? "-"
			result = self.result.split("-")
			player1 = Player.find(self.player_id1)
			player2 = Player.find(self.player_id2)
			player1_score = result[0]
			player2_score = result[1]
			if player1_score > player2_score
				player1.score += 3
				player1.win += 1
				player2.lose += 1
				player1.save!
				player2.save!
			elsif player2_score > player1_score
				player2.score += 3
				player2.win += 1
				player1.lose += 1
				player1.save!
				player2.save!
			elsif player2_score == player1_score
				player1.score += 1
				player1.draw += 1
				player2.score += 1
				player2.draw += 1
				player1.save!
				player2.save!	
			end
		elsif self.result.include? " gave"
			result = self.result.split(" gave")
			player1 = Player.find(self.player_id1)
			player2 = Player.find(self.player_id2)
			if result[0] == player1.name
				player2.score += 3
				player2.win += 1
				player1.lose += 1
				player1.save!
				player2.save!
			elsif result[0] == player2.name
				player1.score += 3
				player1.win += 1
				player2.lose += 1
				player1.save!
				player2.save!
			end
		end
	end

	def update_score
		previous_result = self.result_before_last_save
		current_result  = self.result
		player1 = Player.find(self.player_id1)
		player2 = Player.find(self.player_id2)

		if previous_result.include? "-"
			previous_result = previous_result.split("-")
			if (previous_result[0] > previous_result[1])
				player1.score -= 3
				player1.win -= 1
				player2.lose -= 1
				player1.save!
				player2.save!
			elsif previous_result[0] < previous_result[1]
				player2.score -= 3
				player2.win -= 1
				player1.lose -= 1
				player1.save!
				player2.save!
			else
				player1.score -= 1
				player2.score -= 1
				player1.draw -= 1
				player2.draw -= 1
				player1.save!
				player2.save!
			end
		elsif previous_result.include? " gave"
			previous_result = previous_result.split(" gave")
			if player1.name == previous_result[0]
				player2.score -= 3
				player2.win -= 1
				player1.lose -= 1
				player1.save!
				player2.save!
			elsif player2.name == previous_result[0]
				player1.score -= 3
				player1.win -= 1
				player2.lose -= 1
				player1.save!
				player2.save!	
			end
			
		end

		if current_result.include? "-"
			current_result = current_result.split("-")
			if current_result[0] > current_result[1]
				player1.score += 3
				player1.win += 1
				player2.lose += 1
				player1.save!
				player2.save!
			elsif current_result[0] < current_result[1] 
				player2.score += 3
				player2.win += 1
				player1.lose += 1
				player1.save!
				player2.save!
			else
				player1.score += 1
				player1.draw += 1
				player2.score += 1
				player2.draw += 1
				player1.save!
				player2.save!
			end
		elsif current_result.include? " gave"
			current_result = current_result.split(" gave")
			if player1.name == current_result[0]
				player2.score += 3
				player2.win += 1
				player1.lose += 1
				player2.save!
				player1.save!
			elsif player2.name == current_result[0]
				player1.score += 3
				player1.win += 1
				player2.lose += 1
				player1.save!
				player2.save!
			end
		end
	end

	def reduce_score
		player1 = Player.find_by_id(self.player_id1)
		player2 = Player.find_by_id(self.player_id2)
		if !player1.nil? && !player2.nil?
			if self.result.include?("-")
				result = self.result.split("-")
				if result[0] > result[1]
					player1.score -= 3
					player1.win -= 1
					player2.lose -= 1
				elsif result[0] < result[1]
					player2.score -= 3
					player2.win -= 1
					player1.lose -= 1
				else
					player1.score -= 1
					player2.score -= 1
					player1.draw -= 1
					player2.draw -= 1
				end
				player1.save!
				player2.save!
			elsif self.result.include? " gave"
				result = self.result.split(" gave")
				if player1.name == result[0]
					player2.score -= 3
					player2.win -= 1
					player1.lose -= 1
				elsif player2.name == result[0]
					player1.score -= 3
					player1.win -= 1
					player2.lose -= 1
				end
				player1.save!
				player2.save!
			end
		end
	end
end
