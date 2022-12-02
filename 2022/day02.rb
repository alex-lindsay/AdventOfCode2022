class Day02
  attr_reader :rounds

  ITEM_VALUE = {
    A: 1,
    B: 2,
    C: 3,
    X: 1,
    Y: 2,
    Z: 3,
  }

  OUTCOME_VALUE = {
    LOSS: 0,
    TIE: 3,
    WIN: 6,
  }

  OUTCOMES = {
    AX: "TIE",
    AY: "WIN",
    AZ: "LOSS",
    BY: "TIE",
    BZ: "WIN",
    BX: "LOSS",
    CZ: "TIE",
    CX: "WIN",
    CY: "LOSS",
  }

  PLANNED_OUTCOMES = {
    X: "LOSS",
    Y: "TIE",
    Z: "WIN",
  }

  STRATEGIES = {
    AX: "C",
    AY: "A",
    AZ: "B",
    BX: "A",
    BY: "B",
    BZ: "C",
    CX: "B",
    CY: "C",
    CZ: "A",
  }

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @rounds = []
    data.split("\n").each do |round|
      round.gsub!(/\W/, "")
      object = round[1].to_sym
      object_value = ITEM_VALUE[object]
      outcome = OUTCOMES[round.to_sym].to_sym
      outcome_value = OUTCOME_VALUE[outcome]
      # p [round, object, object_value, outcome, outcome_value, object_value+outcome_value] #part1
      strategy = round[1].to_sym
      strategy_object = STRATEGIES[round.to_sym].to_sym
      strategy_object_value = ITEM_VALUE[strategy_object]
      strategy_outcome = PLANNED_OUTCOMES[strategy].to_sym
      strategy_outcome_value = OUTCOME_VALUE[strategy_outcome]
      # p [round, strategy, strategy_object, strategy_object_value, strategy_outcome, strategy_outcome_value] #part2
      @rounds << [round, object_value+outcome_value, strategy_object_value+strategy_outcome_value]
    end
    # p @rounds
  end

  def total_score
    @rounds.reduce(0) {|acc, val| acc + val[1]}
  end

  def total_strategy_score
    @rounds.reduce(0) {|acc, val| acc + val[2]}
  end
end