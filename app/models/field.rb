class Field < ActiveRecord::Base
  has_many :sectors

  def create
    start_sumbol = Sector::SYMBOLS.rand
    start_number = Sector::NUMBERS.rand
    start_sector = start_sumbol + start_number
    start_sector_name = AVALIABLE_SECTORS[start_sector.to_sym].key
    next_sector_name = AVALIABLE_SECTORS[start_sector.to_sym].value.rand
    field.complicacy == field.sectors.count
    Field.create(
      complicacy = (1..10),
      user_id

    )
    Field.sectors.create(
      field_id,
      name AVALIABLE_SECTORS[start_sector.to_sym].key || AVALIABLE_SECTORS[start_sector.to_sym].value
    )

  end

end
