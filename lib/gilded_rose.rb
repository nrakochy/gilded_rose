AGED_BRIE = "Aged Brie"
SULFURAS = "Sulfuras, Hand of Ragnaros"
BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
CONJURED = "Conjured"

def update_quality(items)
  items.each do |item|
    return if item.name == SULFURAS
    calculate_daily_quality_adjustment(item)
    decrease_days_relative_to_expiration_date(item)
  end
end

def calculate_daily_quality_adjustment(item)
  if item.name == BACKSTAGE_PASSES
    adjust_quality_of_backstage_passes(item)
  elsif item.name == AGED_BRIE
    adjust_quality_of_aged_brie(item)
  else
    rate = calculate_rate_of_depreciation(item)
    depreciate_item_quality_until_zero(item, rate)
  end
end

def decrease_days_relative_to_expiration_date(item)
 item.sell_in -= 1
end

def adjust_quality_of_backstage_passes(passes)
  if past_sell_by_date?(passes.sell_in)
    passes.quality = 0
  else
    rate_of_appreciation = calculate_rate_of_non_expired_backstage_passes_appreciation(passes)
    appreciate_quality_of_item_until_max_quality(passes, rate_of_appreciation)
  end
end

def adjust_quality_of_aged_brie(brie)
  brie_rate = calculate_rate_of_aged_brie_appreciation(brie)
  appreciate_quality_of_item_until_max_quality(brie, brie_rate)
end


def appreciate_quality_of_item_until_max_quality(item, rate_of_appreciation)
  item.quality + rate_of_appreciation <= 50 ? item.quality += rate_of_appreciation : item.quality = 50
end

def calculate_rate_of_non_expired_backstage_passes_appreciation(backstage_passes)
  case
  when backstage_passes.sell_in > 10
   rate = 1
  when backstage_passes.sell_in <= 5
    rate = 3
  else
    rate = 2
  end
end

def calculate_rate_of_aged_brie_appreciation(aged_brie)
  aged_brie.sell_in > 0 ? rate = 1 : rate = 2
end

def past_sell_by_date?(days_until_expiration)
  days_until_expiration <= 0
end

def adjust_depreciation_multiplier_for_conjured_items(item)
  conjured_item?(item) ? depreciation_multiplier = 2 : depreciation_multiplier = 1
end

def calculate_rate_of_depreciation(item)
  depreciation_multiplier = adjust_depreciation_multiplier_for_conjured_items(item)
  item.sell_in > 0 ? rate_of_depreciation = 1 : rate_of_depreciation = 2
  rate_of_depreciation * depreciation_multiplier
end

def depreciate_item_quality_until_zero(item, rate_of_depreciation)
  item.quality -= rate_of_depreciation if item.quality > 0
end

def conjured_item?(item)
  item.name.include?(CONJURED)
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

