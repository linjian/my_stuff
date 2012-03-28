# Put it in spec/support/one_association_stub.rb
module OneAssociationStub
  def stub(*args, &block)
    if is_mongo_mapper_model? && is_one_association? && self.respond_to?(:target)
      self.target.stub(*args, &block)
    else
      super
    end
  end

  alias_method :stub!, :stub

  private

  def is_mongo_mapper_model?
    self.is_a?(MongoMapper::Document) || self.is_a?(MongoMapper::EmbeddedDocument)
  end

  def is_one_association?
    self.respond_to?(:association) &&
      %w(BelongsToAssociation OneAssociation).include?(self.association.class.to_s.demodulize)
  end
end

# Put it in spec/models/one_association_stub_spec.rb
require 'spec_helper'

module OneAssociationStubSpec
  module TestMethods
    def do_something
      do_another_thing
    end

    def do_another_thing
      true
    end
  end

  class Account; end
  class Name; end

  class User
    include MongoMapper::Document
    include TestMethods

    one :account, :class => OneAssociationStubSpec::Account
    one :name,    :class => OneAssociationStubSpec::Name
  end

  class Account
    include MongoMapper::Document
    include TestMethods

    belongs_to :user, :class => OneAssociationStubSpec::User
  end

  class Name
    include MongoMapper::EmbeddedDocument
    include TestMethods
  end
end

describe "stub for association" do
  before(:each) do
    @user = OneAssociationStubSpec::User.create
    @user.create_account
    @user.build_name
    @user.save
  end

  it "one" do
    account = @user.account
    account.stub(:do_another_thing)
    account.do_something.should be_nil
  end

  it "belongs_to" do
    account = OneAssociationStubSpec::Account.find(@user.account.id)
    user = account.user
    user.stub(:do_another_thing)
    user.do_something.should be_nil
  end

  it "EmbeddedDocument one" do
    name = @user.name
    name.stub(:do_another_thing)
    name.do_something.should be_nil
  end
end

# Add the following line to spec/spec_helper.rb
RSpec.configure do |config|
  config.before(:each) do
    Object.class_eval { include OneAssociationStub }
  end
end
