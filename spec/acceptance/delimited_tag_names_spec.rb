require 'spec_helper'

describe "Managing tags via delimited names" do
  let(:article)   { Article.create }

  it "returns delimited tag names sorted alphabetically" do
    melbourne = Gutentag::Tag.create :name => 'melbourne'
    frankfurt = Gutentag::Tag.create :name => 'frankfurt'

    article.tags << melbourne
    article.tags << frankfurt

    article.delimited_tag_names.should == 'frankfurt,melbourne'
  end

  it "adds tags via their delimited names" do
    article.delimited_tag_names = 'melbourne,portland'
    article.save!

    article.tags.collect(&:name).should == ['melbourne', 'portland']
  end

  it "doesn't complain when adding the same tag twice" do
    article.delimited_tag_names = 'melbourne,melbourne'
    article.save!

    article.tags.collect(&:name).should == ['melbourne']
  end

  it "accepts a completely new set of tags" do
    article.delimited_tag_names = 'portland,oregon'
    article.save!

    article.tags.collect(&:name).should == ['portland', 'oregon']
  end

  it "does not allow duplication of tags" do
    existing = Article.create
    existing.tags << Gutentag::Tag.create(:name => 'portland')

    article.delimited_tag_names = 'portland'
    article.save!

    existing.tag_ids.should == article.tag_ids
  end

  it "matches tag names ignoring case" do
    article.delimited_tag_names = 'portland,Portland'
    article.save!

    article.tags.collect(&:name).should == ['portland']
  end

  it "matches tag names ignoring whitespace" do
    article.delimited_tag_names = 'portland , oregon'
    article.save!

    article.tags.collect(&:name).should == ['portland', 'oregon']
  end

  it "allows setting of tag names on unpersisted objects" do
    article = Article.new :delimited_tag_names => 'melbourne,pancakes'
    article.save!

    article.tag_names.should == ['melbourne', 'pancakes']
  end

  it "allows overriding of delimited_tag_names=" do
    Article.instance_methods(false).should_not include(:delimited_tag_names=)
  end
end
