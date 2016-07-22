class Sector < ActiveRecord::Base
  def initialize(complicacy)
    @complicacy = complicacy
		@symbols = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'].first(complicacy)
		@numbers = (0..9).to_a.first(complicacy)
	end


  def correct_way(way = ['a0'])
    if way.size < @complicacy*2
      neyborhoods_steps = all_avaliable_sectors[way.last] - way
      way << neyborhoods_steps.sample
      correct_way(way)
    else
      way
    end
  end

  def method_name

  end

  private

  def all_avaliable_sectors
    @symbols.map do |symbol|
      @numbers.inject({}){|acc, number| acc.merge("#{symbol + number.to_s}" => sector_neyborhoods(symbol, number))}
    end.inject({}){|acc, symbol_group| acc.merge(symbol_group)}
  end

  def sector_neyborhoods(symbol, number)
    [
      current_symbol(symbol, :+) + number.to_s,
      current_symbol(symbol, :*) + (number + 1).to_s,
      current_symbol(symbol, :*) + (number - 1).to_s,
      current_symbol(symbol, :-) + number.to_s
    ].delete_if{|el| el.include?('none') || el.include?(@complicacy.to_s) || el.include?('-1')}
  end

  def current_symbol(symbol, action)
    current_index = @symbols.index(symbol)
    feature_index = current_index.send(action, 1)
    @numbers.include?(feature_index) ? @symbols[feature_index] : 'none'
  end
end
