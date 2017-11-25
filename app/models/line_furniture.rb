class LineFurniture < ActiveRecord::Base
    belongs_to :sale
    belongs_to :furniture
end
