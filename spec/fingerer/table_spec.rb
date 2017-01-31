require 'spec_helper'

describe Fingerer::Table do

  describe ".row" do
    context "given no parameters" do
      it "returns an empty row statement" do
        response = Fingerer::Table.row

        expect(response).to eq("|#{" " * 76}|")
        expect(response.length).to be(78)
      end
    end

    context "given an empty string" do
      it "returns an empty row statement" do
        response = Fingerer::Table.row("")
        expect(response).to eq("|#{" " * 76}|")
        expect(response.length).to be(78)
      end
    end

    context "given one column" do
      it "returns a one-column row statement" do
        response = Fingerer::Table.row("one")
        expect(response).to eq("| one #{" " * 71}|")
        expect(response.length).to be(78)
      end

      it "truncates a long string" do
        response = Fingerer::Table.row("this is a really really really really really really really really really long string")
        expect(response).to eq("| this is a really really really really really really really really really l |")
        expect(response.length).to be(78)
      end
    end

    context "given two columns" do
      it "returns a two-column row statement" do
        response = Fingerer::Table.row("one", "two")
        expect(response).to eq("| one                                  two                                   |")
        expect(response.length).to be(78)
      end
    end

    context "given three columns" do
      it "returns a three-column row statement" do
        response = Fingerer::Table.row("one", "two", "three")
        expect(response).to eq("| one                      two                      three                    |")
        expect(response.length).to be(78)
      end
    end

    context "given four columns" do
      it "returns a four-column row statement" do
        response = Fingerer::Table.row("one", "two", "three", "four")
        expect(response).to eq("| one               two               three             four                 |")
        expect(response.length).to be(78)
      end
    end

  end

  describe ".header" do
    context "given no parameter" do
      it "returns an empty header line" do
        response = Fingerer::Table.header
        expect(response).to eq("+-[  ]-----------------------------------------------------------------------+")
        expect(response.length).to be(78)
      end
    end

    context "given an empty string" do
      it "returns an empty header line" do
        response = Fingerer::Table.header("")
        expect(response).to eq("+-[  ]-----------------------------------------------------------------------+")
        expect(response.length).to be(78)
      end
    end

    context "given a non-empty string" do
      it "returns a non-empty header line" do
        response = Fingerer::Table.header("header")
        expect(response).to eq("+-[ header ]-----------------------------------------------------------------+")
        expect(response.length).to be(78)
      end

      it "returns a truncated header line" do
        response = Fingerer::Table.header("this is a really really really really really really really really really long string")
        expect(response).to eq("+-[ this is a really really really really really really really really real ]-+")
        expect(response.length).to be(78)
      end
    end
  end

  describe ".line" do
    it "returns a line" do
      response = Fingerer::Table.line
      expect(response).to eq("+#{"-" * 76}+")
      expect(response.length).to be(78)
    end
  end
end
