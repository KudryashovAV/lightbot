class Sector < ActiveRecord::Base
  # has_many :fields, through: :allocations
  # has_many :allocations
  #
  # has_one :option

  SYMBOLS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
  NUMBERS = (0..9).to_a
  AVALIABLE_SECTORS= all_avaliable_sectors

  private

  def all_avaliable_sectors
    SYMBOLS.map do |symbol|
      NUMBERS.inject({}){|acc, number| acc.merge("#{symbol + number.to_s}" => sector_neyborhoods(symbol, number))}
    end
  end

  def sector_neyborhoods(symbol, number)
    [
      current_symbol(symbol, :+) + number.to_s,
      current_symbol(symbol, :*) + (number + 1).to_s,
      current_symbol(symbol, :*) + (number - 1).to_s,
      current_symbol(symbol, :-) + number.to_s
    ].delete_if{|el| el.include?('none') || el.include?('10') || el.include?('-1')}
  end

  def current_symbol(symbol, action)
    current_index = SYMBOLS.index(symbol)
    feature_index = current_index.send(action, 1)
     NUMBERS.include?(feature_index) ? SYMBOLS[feature_index] : 'none'
  end

end
