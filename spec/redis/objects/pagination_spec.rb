require 'spec_helper'

describe Redis::Objects::Pagination do
  it 'has a version number' do
    expect(Redis::Objects::Pagination::VERSION).not_to be nil
  end
end
