require 'rspec'
require_relative 'pig_latin.rb'

describe String do
  context "simple cases" do
    it "opening consonant" do
      expect('cat'.pig_latinize).to eq('atcay')
    end

    it "opening vowel" do
      expect('ace'.pig_latinize).to eq('aceyay')
    end

    it "capital letter" do
      expect('Cat'.pig_latinize).to eq('Atcay')
    end

    it " capital vowel" do
      expect('Ace'.pig_latinize).to eq('Aceyay')
    end

    it "multiple consonants" do
      expect('true'.pig_latinize).to eq('uetray')
    end

    it "all caps" do
      expect('TRUE'.pig_latinize).to eq('UETRAY')
    end
  end

  context "multiple words" do
    it " two words" do
      expect('the cat'.pig_latinize).to eq('ethay atcay')
    end

    it "multiple words with vowels" do
      test_string = 'offer and acceptance makes a contract'
      correct_output = 'offeryay andyay acceptanceyay akesmay ayay ontractcay'
      expect(test_string.pig_latinize).to eq(correct_output)
    end
  end

  context "punctuation" do
    it "simple contraction" do
      expect("can't".pig_latinize).to eq('antcay')
    end

    it "dash" do
      expect("match-test".pig_latinize).to eq('atchmay-esttay')
    end
  end
end
