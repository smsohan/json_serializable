require 'json_serializable'

class Base
  def as_json(options = {})
    options
  end
end

class Model < Base
  include JsonSerializable

  attr_accessor :name, :description, :secret

  def greet
    "Hello there"
  end
end

describe JsonSerializable do

  before(:each) do
    @model = Model.new
  end

  it 'should use base.as_json by default' do
    @model.as_json(hello: "world").should == {hello: "world"}
  end

  describe 'custom serialization' do

    before(:each) do
      @model.name = "Sohan"
      @model.description = "Simple guy"
      @model.secret = "8789aasd7"
    end

    it 'should whitelist the fields' do
      Model.class_eval do
        json_serializable [:name, :description]
      end

      @model.as_json.should == {only: [:name, :description]}
    end

    it 'should whitelist with lambdas' do
      Model.class_eval do
        json_serializable [:name], :private => lambda {|model| model.secret}
      end

      @model.as_json.should == {only: [:name], :private => @model.secret}
    end

    it 'should allow methods with custom key' do
      Model.class_eval do
        json_serializable [:name], :greet => :welcome
      end

      @model.as_json.should == {only: [:name], :welcome => "Hello there"}
    end

    it 'should allow fields with custom key' do
      Model.class_eval do
        json_serializable [:name], :description => :summary
      end

      @model.as_json.should == {only: [:name], :summary => "Simple guy"}
    end
  end
end