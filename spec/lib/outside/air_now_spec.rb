require "spec_helper"

RSpec.describe Outside::AirNow do
  describe "forecasts" do
    it "raises error when no zip specified" do
      expect{ described_class.forecasts}.to raise_error(RuntimeError)
    end

    context "when using zipcode with local stations" do
      let(:options) {
        {zipcode: "84043"}
      }
      it "works properly" do
        expect{ described_class.forecasts(options)}.to_not raise_error
      end
    end

    context "when using zipcode with only O3 station nearby" do
      let(:options) {
        {zipcode: "84101"}
      }

      it "returns empty" do
        expect(described_class.forecasts(options).count) == 1
      end      
    end   
  end 

  describe "forecast_today" do
    let(:options) {
      {zipcode: "84101"}
    }
    subject { described_class.forecast_today(options) }

    it "does not raise errors" do
      expect{ described_class.forecast_today(options)}.to_not raise_error
    end 

    it "is todays forecast" do
      expect(subject).to_not be_nil
      expect(subject["DateForecast"].strip).to eq(Time.now.strftime(described_class.date_fmt).to_s)
    end
  end
end