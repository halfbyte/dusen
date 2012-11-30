# encoding: utf-8

require 'spec_helper'

describe ActiveRecord::Base do

  describe '.search' do

    it 'should find records by given words' do
      match = User.create!(:name => 'Abraham')
      no_match = User.create!(:name => 'Elizabath')
      User.search('Abraham').to_a.should == [match]
    end

    it 'should AND multiple words' do
      match = User.create!(:name => 'Abraham Lincoln')
      no_match = User.create!(:name => 'Abraham')
      User.search('Abraham Lincoln').to_a.should == [match]
    end

    it 'should find records by phrases' do
      match = User.create!(:name => 'Abraham Lincoln')
      no_match = User.create!(:name => 'Abraham John Lincoln')
      User.search('"Abraham Lincoln"').to_a.should == [match]
    end

    it 'should find records by qualified fields' do
      match = User.create!(:name => 'foo@bar.com', :email => 'foo@bar.com')
      no_match = User.create!(:name => 'foo@bar.com', :email => 'bam@baz.com')
      User.search('email:foo@bar.com').to_a.should == [match]
    end

    it 'should allow phrases as values for qualified field queries' do
      match = User.create!(:name => 'Foo Bar', :city => 'Foo Bar')
      no_match = User.create!(:name => 'Foo Bar', :city => 'Bar Foo')
      User.search('city:"Foo Bar"').to_a.should == [match]
    end

    it 'should allow to mix multiple types of tokens in a single query' do
      match = User.create!(:name => 'Foo', :city => 'Foohausen')
      no_match = User.create!(:name => 'Foo', :city => 'Barhausen')
      User.search('Foo city:Foohausen').to_a.should == [match]
    end

  end

  describe '.search_syntax' do

    it "should return the model's syntax definition when called without a block" do
      User.search_syntax.should be_a(Dusen::Syntax)
    end

  end

end
