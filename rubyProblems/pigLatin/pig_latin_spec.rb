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

    it "handles a word that is all caps" do
      expect('TRUE'.pig_latinize).to eq('UETRAY')
    end
  end

  context "multiple words" do
    it "handles two words" do
      expect('the cat'.pig_latinize).to eq('ethay atcay')
    end

    it "handles multiple words with vowels" do
      test_string = 'offer and acceptance makes a contract'
      correct_output = 'offeryay andyay acceptanceyay akesmay ayay ontractcay'
      expect(test_string.pig_latinize).to eq(correct_output)
    end
  end
end
