require 'spec_helper'

describe Gutentag do
  describe '.configure' do
    it 'yields self' do
      Gutentag.configure do |config|
        config.should == Gutentag
      end
    end
  end

  describe 'tag name delimiter' do
    it 'defaults to comma' do
      Gutentag.tag_name_delimiter.should == ','
    end

    it 'can be configured using .configure block' do
      Gutentag.configure { |config| config.tag_name_delimiter = '%' }
      Gutentag.tag_name_delimiter.should == '%'
    end
  end
end