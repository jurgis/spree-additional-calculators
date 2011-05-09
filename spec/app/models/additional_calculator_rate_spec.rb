require 'spec_helper'

describe AdditionalCalculatorRate do
  before(:all) do
    @shipping_method = Factory(:shipping_method)
    @calculator = Factory(:weight_and_quantity_calculator)
  end

  before(:each) do
    @rate = Factory.build(:additional_calculator_rate_for_weight, :from_value => 0, :to_value => 100, :rate => 100)
    @rate2 = Factory.build(:additional_calculator_rate_for_weight, :from_value => 100.1, :to_value => 500, :rate => 500)
  end


  context "without validation errors" do
    it "should not have validation errors with valid attributes" do
      @rate.should be_valid
      @rate.save!
    end

    it "should allow equal from_value and to_value" do
      @rate.from_value = @rate.to_value = 30.1
      @rate.should be_valid
      @rate.save!
    end
  end

  context "with validation errors" do
    context "from_value" do
      it "should be entered" do
        @rate.from_value = nil
        @rate.should_not be_valid
        @rate.errors_on(:from_value).should_not be_blank
      end

      it "should be numeric" do
        @rate.from_value = 'foo'
        @rate.should_not be_valid
        @rate.errors_on(:from_value).should_not be_blank
      end

      it "should be less or equal than to_value" do
        @rate.from_value = 21.1
        @rate.to_value = 20.2
        @rate.should_not be_valid
        @rate.errors_on(:base).should_not be_blank
      end
    end

    context "to_value" do
      it "should be entered" do
        @rate.to_value = nil
        @rate.should_not be_valid
        @rate.errors_on(:to_value).should_not be_blank
      end

      it "should be numeric" do
        @rate.to_value = 'foo'
        @rate.should_not be_valid
        @rate.errors_on(:to_value).should_not be_blank
      end
    end

    context "rate" do
      it "should be entered" do
        @rate.rate = nil
        @rate.should_not be_valid
        @rate.errors_on(:rate).should_not be_blank
      end

      it "should be numeric" do
        @rate.rate = 'foo'
        @rate.should_not be_valid
        @rate.errors_on(:rate).should_not be_blank
      end
    end
  end

  context "find_rate" do
    it "should find nothing when there are no rates" do
      AdditionalCalculatorRate.all.should have(0).records
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should be_nil
    end

    it "should find a valid rate (from a single entry)" do
      @rate.save!

      AdditionalCalculatorRate.all.should have(1).records
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0.1).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 1).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 50).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99.9).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100.1).should be_nil
    end

    it "should find a valid rate (from two entries)" do
      @rate.save!
      @rate2.save!

      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0.1).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 1).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 50).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99.9).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100).should == 100
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100.1).should == 500
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 101).should == 500
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 499).should == 500
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 499.9).should == 500
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 500).should == 500
      AdditionalCalculatorRate.find_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 500.1).should be_nil
    end
  end

  context "find_previous_rate" do
    it "should find nothing when there are no rates" do
      AdditionalCalculatorRate.all.should have(0).records
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should be_nil
    end

    it "should find nothing when there is a single rate entry" do
      @rate.save!

      AdditionalCalculatorRate.all.should have(1).records
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 50).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99.9).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100.1).should == 100
    end

    it "should find a valid rate (from two entries)" do
      @rate.save!
      @rate2.save!

      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 0).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 99.9).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100).should be_nil
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 100.1).should == 100
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 101).should == 100
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 499).should == 100
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 499.9).should == 100
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 500).should == 100
      AdditionalCalculatorRate.find_previous_rate(@calculator.id, AdditionalCalculatorRate::WEIGHT, 500.1).should == 500
    end
  end

end
