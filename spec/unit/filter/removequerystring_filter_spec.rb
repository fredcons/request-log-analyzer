require 'spec_helper'

describe RequestLogAnalyzer::Filter::RemoveQueryString, 'remove query string' do

  before(:each) do
    @filter = RequestLogAnalyzer::Filter::RemoveQueryString.new(testing_format)
  end

  it "should remove a querystring in a path" do
    @filter.filter(request(:path => '/employees?foo=bar&baz=qux'))[:path].should eql('/employees?{query}')
  end


end