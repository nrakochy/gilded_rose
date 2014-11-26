
AGED_BRIE = "Aged Brie"
SULFURAS = "Sulfuras, Hand of Ragnaros"
BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
CONJURED = "Conjured"

def decrease_days_relative_to_expiration_date(item)
    item.sell_in -= 1
end

def adjust_value_of_back_stage_passes back_stage_passes
end

def past_sell_by_date?(days_until_expiration)
  days_until_expiration == 0
end

def maximum_quality? back_stage_passes
  back_stage_passes.quality == 50
end

def depreciate_item_until_zero item
  item.sell_in > 0 ? rate_of_depreciation = 1 : rate_of_depreciation = 2
  item.quality -= rate_of_depreciation if item.quality > 0
end

def specialty_item? item
  item.name == AGED_BRIE || item.name == BACKSTAGE_PASSES || item.name == CONJURED
end


def back_stage_quality back_stage_passes
  case 
  when back_stage_passes.qua
  end
end

def update_quality(items)
  items.each do |item|
    return if item.name == SULFURAS
    if !specialty_item?(item)
      depreciate_item_until_zero(item)
    else
      if item.quality < 50
        item.quality += 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            if item.quality < 50
              item.quality += 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality += 1
            end
          end
        end
      end
    end
    decrease_days_relative_to_expiration_date(item)
    if item.sell_in < 0
      if item.name != AGED_BRIE
        if item.name == BACKSTAGE_PASSES
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
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

