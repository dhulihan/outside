require "spec_helper"

RSpec.describe Outside::AirNow do
  describe "observations" do
    it "raises error when no zip specified" do
      expect{ described_class.observations}.to raise_error(RuntimeError)
    end

    context "when using zipcode with local stations" do
      let(:options) {
        {zipcode: "84043"}
      }

      it "works properly" do
        expect{ described_class.observations(options)}.to_not raise_error
      end
    end

    context "when using zipcode with only O3 station nearby" do
      let(:options) {
        {zipcode: "84101"}
      }

      it "returns empty" do
        expect(described_class.observations(options).count).to be 1
      end      
    end   
  end  
end