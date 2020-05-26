require 'rails_helper'

describe Review, type: :model do

  describe "relationships" do
    it {should belong_to :item}
  end

end
