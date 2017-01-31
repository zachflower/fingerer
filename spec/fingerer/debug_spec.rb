require 'spec_helper'

describe Fingerer::Debug do

  describe ".info" do
    context "given an empty string" do
      it "returns an empty INFO debug statement" do
        expect(STDOUT).to receive(:puts).with(/INFO $/)
        Fingerer::Debug.info("")
      end
    end

    context "given a non-empty string" do
      it "returns an empty INFO debug statement" do
        expect(STDOUT).to receive(:puts).with(/INFO hullabaloo$/)
        Fingerer::Debug.info("hullabaloo")
      end
    end
  end

  describe ".error" do
    context "given an empty string" do
      it "returns an empty ERROR debug statement" do
        expect(STDOUT).to receive(:puts).with(/ERROR $/)
        Fingerer::Debug.error("")
      end
    end

    context "given an empty string" do
      it "returns a non-empty ERROR debug statement" do
        expect(STDOUT).to receive(:puts).with(/ERROR hullabaloo$/)
        Fingerer::Debug.error("hullabaloo")
      end
    end
  end
end
