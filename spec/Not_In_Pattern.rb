
describe "GSUB semantics" do
  
  it "returns all non-matching sub-strings" do
    arr = Not_In_Pattern "Austria is the land of Austrians.", %r!Austria!
    arr.should ==  [" is the land of ", "ns."]
  end

  it "accepts a replacement String" do
    str = Not_In_Pattern "Run Mike Run", %r!\s*Run\s*!, "Spot"
    str.should == "Run Spot Run"
  end
  
  it "accepts a replacement block" do
    str = Not_In_Pattern "Tokyo Jones & Tokyo Mike", %r!\s*Tokyo\s*! do |replace|
      replace.split.map { |str|
        case str
        when 'Jones'
          'Jonesy'
        when 'Mike'
          'Mikey'
        else
          str
        end
      }.join ' '
    end
    str.should == "Tokyo Jonesy & Tokyo Mikey"
  end
  
end 

MAN_HERO = /[a-zA-Z]+man/
ONE_OR_TWO_WORDS = /\w+( +\w+)?/
describe "Replacement in different positions of line" do

  it "replaces words in middle + end" do
    Not_In_Pattern("Green Arrow, Superman, Batman, Green Lantern", MAN_HERO) { |piece|
      piece.gsub(ONE_OR_TWO_WORDS, '...')
    }.should.equal("..., Superman, Batman, ...")
  end

  it "replaces words in front + end" do
    Not_In_Pattern("Superman, Green Arrow, Batman", MAN_HERO) { |piece|
      piece.gsub(ONE_OR_TWO_WORDS, '...')
    }.should.equal('Superman, ..., Batman')
  end

  it "replaces nothing if not found" do
    Not_In_Pattern("Superman, Batman", MAN_HERO) { |piece|
      piece.gsub(ONE_OR_TWO_WORDS, '...')
    }.should.equal('Superman, Batman')
  end

  it "replaces all if everything matches" do
    Not_In_Pattern("Green Arrow", MAN_HERO) { |piece|
      piece.gsub(ONE_OR_TWO_WORDS, '...')
    }.should.equal('...')
  end

end

