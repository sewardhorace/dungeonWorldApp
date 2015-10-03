class Klass < ActiveRecord::Base

  def data
    KlassData.new(read_attribute(:klass_data))
  end

  class KlassData
    attr_accessor :abilities, :alignment, :looks

    def initialize(hash)
      @abilities = hash['abilities']
      @alignment = hash['alignment']
      @looks = hash['looks']
    end
  end
end
