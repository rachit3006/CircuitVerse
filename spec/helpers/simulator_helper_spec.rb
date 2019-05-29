# frozen_string_literal: true

require "rails_helper"

describe SimulatorHelper do
  include SimulatorHelper

  def data_url(image_str)
    "data:image/jpeg;base64,#{image_str}"
  end

  describe "#check_to_delete" do
    it "give true for non empty images" do
      expect(check_to_delete(data_url(""))).to be false
      expect(check_to_delete(data_url(Faker::Alphanumeric.alpha(20)))).to be true
    end
  end

  describe "#return_image_url" do
    before do
    end

    context "circuit is empty" do
      it "returns image url" do
        expect(return_image_file(data_url("")).path).to end_with("default.png")
      end
    end

    context "circuit has elements" do
      before do
        allow(File).to receive(:new).and_return(file_like_object)
      end

      it "creates new preview file" do
        expect(File).to receive(:new).with(/^preview_.*\.jpeg$/, "wb")
        return_image_file(data_url(Faker::Alphanumeric.alpha))
      end
    end
  end
end
