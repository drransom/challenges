require 'rspec'
require_relative 'pig_latin.rb'

describe String do
  context "simple cases" do
    it "handles an opening consonant" do
      expect('cat'.pig_latinize).to eq('atcay')
    end

    it 'handles an opening vowel' do
      expect('ace'.pig_latinize).to eq('aceyay')
    end

    it "handles a capital letter" do
      expect('Cat'.pig_latinize).to eq('Atcay')
    end

    it "handles a capital vowel" do
      expect('Ace'.pig_latinize).to eq('Aceyay')
    end

    it "handles multiple consonants" do
      expect('true'.pig_latinize).to eq('uetray')
    end
  end

  context "multiple words" do
    it "handles two words" do
      expect('the cat'.pig_latinize).to eq('ethay atcay')
    end
  end
end
