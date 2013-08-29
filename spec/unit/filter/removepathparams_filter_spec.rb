require 'spec_helper'

describe RequestLogAnalyzer::Filter::RemovePathParams, 'remove path params' do

  before(:each) do
    @filter = RequestLogAnalyzer::Filter::RemovePathParams.new(testing_format)
  end

  it "should remove mixed literal / numeric chains in a path" do
    @filter.filter(request(:path => '/document/15fad49c5692fdba2e6bc9c3d70a5eb4/partager/modifier'))[:path].should eql('/document/{param}/partager/modifier')
  end

  it "should remove mixed literal / numeric chains in a path, and preserve the querystring" do
    @filter.filter(request(:path => '/document/15fad49c5692fdba2e6bc9c3d70a5eb4/partager/modifier?foo=bar'))[:path].should eql('/document/{param}/partager/modifier?foo=bar')
  end

  it "should remove upper case strings in a path" do
    @filter.filter(request(:path => '/utilisateur/activation/ZHLVVOFW'))[:path].should eql('/utilisateur/activation/{param}')
  end

  it "should preserve the root path /" do
    @filter.filter(request(:path => '/'))[:path].should eql('/')
  end


end