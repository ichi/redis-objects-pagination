require 'spec_helper'

describe Redis::Objects::Pagination do
  it 'has a version number' do
    expect(Redis::Objects::Pagination::VERSION).not_to be nil
  end

  describe '.config' do
    subject{ Redis::Objects::Pagination.config }

    it{ is_expected.to be_a Redis::Objects::Pagination::Configuration }
    its(:default_per_page){ is_expected.to eq 25 }
  end

  describe 'Redis::Objects' do
    describe 'Redis::Counter' do
      subject{ Redis::Counter.new('counter_name') }

      it{ is_expected.to_not respond_to :paginator }
    end

    describe 'Redis::Lock' do
      subject{ Redis::Lock.new('serialize_stuff', :expiration => 15, :timeout => 0.1) }

      it{ is_expected.to_not respond_to :paginator }
    end

    describe 'Redis::Value' do
      subject{ Redis::Value.new('value_name') }

      it{ is_expected.to_not respond_to :paginator }
    end

    describe 'Redis::List' do
      subject{ Redis::List.new('list_name') }

      it{ is_expected.to respond_to :paginator }
    end

    describe 'Redis::HashKey' do
      subject{ Redis::HashKey.new('hash_name') }

      it{ is_expected.to_not respond_to :paginator }
    end

    describe 'Redis::Set' do
      subject{ Redis::Set.new('set_name') }

      it{ is_expected.to_not respond_to :paginator }
    end

    describe 'Redis::SortedSet' do
      subject{ Redis::SortedSet.new('number_of_posts') }

      it{ is_expected.to respond_to :paginator }
    end

  end
end
