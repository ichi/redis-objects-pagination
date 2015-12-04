require 'spec_helper'

describe Redis::Objects::Pagination::Paginator do
  describe 'Redis::List#paginator' do
    let(:list){ Redis::List.new('list').tap{|r| r.push(*1..100) } }
    let(:paginator){ list.paginator(:range) }

    describe '#page' do
      subject{ paginator.page(page) }

      context 'page = 1 (first page)' do
        let(:page){ 1 }

        its(:current_page){ is_expected.to eq 1 }
        its(:first_page?) { is_expected.to eq true }
        its(:last_page?)  { is_expected.to eq false }
        its(:prev_page)   { is_expected.to be_nil }
        its(:next_page)   { is_expected.to eq 2 }
      end

      context 'page = 2' do
        let(:page){ 2 }

        its(:current_page){ is_expected.to eq 2 }
        its(:first_page?) { is_expected.to eq false }
        its(:last_page?)  { is_expected.to eq false }
        its(:prev_page)   { is_expected.to eq 1 }
        its(:next_page)   { is_expected.to eq 3 }
      end

      context 'page = 4 (last page)' do
        let(:page){ 4 }

        its(:current_page){ is_expected.to eq 4 }
        its(:first_page?) { is_expected.to eq false }
        its(:last_page?)  { is_expected.to eq true }
        its(:prev_page)   { is_expected.to eq 3 }
        its(:next_page)   { is_expected.to be_nil }
      end
    end

    describe '#per' do
      subject{ paginator.page(3).per(per) }

      context 'per = 5' do
        let(:per){ 5 }

        its(:current_page){ is_expected.to eq 3 }
        its(:total_pages) { is_expected.to eq 20 }
        its(:offset_value){ is_expected.to eq 10 }
        its(:limit_value) { is_expected.to eq 5 }
      end

      context 'per = 10' do
        let(:per){ 10 }

        its(:current_page){ is_expected.to eq 3 }
        its(:total_pages) { is_expected.to eq 10 }
        its(:offset_value){ is_expected.to eq 20 }
        its(:limit_value) { is_expected.to eq 10 }
      end

      context 'per = 33' do
        let(:per){ 33 }

        its(:current_page){ is_expected.to eq 3 }
        its(:total_pages) { is_expected.to eq 4 }
        its(:offset_value){ is_expected.to eq 66 }
        its(:limit_value) { is_expected.to eq 33 }
      end
    end

    describe '#limit' do
      subject{ paginator.page(3).limit(limit) }

      context 'limit = 5' do
        let(:limit){ 5 }

        its(:current_page){ is_expected.to eq 11 }
        its(:total_pages) { is_expected.to eq 20 }
        its(:offset_value){ is_expected.to eq 50 }
        its(:limit_value) { is_expected.to eq 5 }
      end

      context 'limit = 10' do
        let(:limit){ 10 }

        its(:current_page){ is_expected.to eq 6 }
        its(:total_pages) { is_expected.to eq 10 }
        its(:offset_value){ is_expected.to eq 50 }
        its(:limit_value) { is_expected.to eq 10 }
      end

      context 'limit = 33' do
        let(:limit){ 33 }

        its(:current_page){ is_expected.to eq 2 }
        its(:total_pages) { is_expected.to eq 4 }
        its(:offset_value){ is_expected.to eq 50 }
        its(:limit_value) { is_expected.to eq 33 }
      end
    end

    describe '#offset' do
      subject{ paginator.page(3).offset(offset) }

      context 'offset = 5' do
        let(:offset){ 5 }

        its(:current_page){ is_expected.to eq 1 }
        its(:total_pages) { is_expected.to eq 4 }
        its(:offset_value){ is_expected.to eq 5 }
        its(:limit_value) { is_expected.to eq 25 }
      end

      context 'offset = 10' do
        let(:offset){ 10 }

        its(:current_page){ is_expected.to eq 1 }
        its(:total_pages) { is_expected.to eq 4 }
        its(:offset_value){ is_expected.to eq 10 }
        its(:limit_value) { is_expected.to eq 25 }
      end

      context 'offset = 33' do
        let(:offset){ 33 }

        its(:current_page){ is_expected.to eq 2 }
        its(:total_pages) { is_expected.to eq 4 }
        its(:offset_value){ is_expected.to eq 33 }
        its(:limit_value) { is_expected.to eq 25 }
      end
    end

    describe '#total_count' do
      subject{ paginator.total_count }

      it{ is_expected.to eq 100 }
    end

    describe '#total_pages' do
      subject{ paginator.total_pages }

      it{ is_expected.to eq 4 }
    end

    describe '#current_page' do
      subject{ paginator.page(page).current_page }

      context 'page = 1' do
        let(:page){ 1 }

        it{ is_expected.to eq 1 }
      end

      context 'page = 2' do
        let(:page){ 2 }

        it{ is_expected.to eq 2 }
      end
    end

    describe '#next_page' do
      subject{ paginator.page(page).next_page }

      context 'page = 1' do
        let(:page){ 1 }

        it{ is_expected.to eq 2 }
      end

      context 'page = 4 (last page)' do
        let(:page){ 4 }

        it{ is_expected.to be_nil }
      end
    end

    describe '#prev_page' do
      subject{ paginator.page(page).prev_page }

      context 'page = 1' do
        let(:page){ 1 }

        it{ is_expected.to be_nil }
      end

      context 'page = 4 (last page)' do
        let(:page){ 4 }

        it{ is_expected.to eq 3 }
      end
    end

    describe '#first_page?' do
      subject{ paginator.page(page).first_page? }

      context 'page = 1' do
        let(:page){ 1 }

        it{ is_expected.to eq true }
      end

      context 'page = 4 (last page)' do
        let(:page){ 4 }

        it{ is_expected.to eq false }
      end
    end

    describe '#last_page?' do
      subject{ paginator.page(page).last_page? }

      context 'page = 1' do
        let(:page){ 1 }

        it{ is_expected.to eq false }
      end

      context 'page = 4 (last page)' do
        let(:page){ 4 }

        it{ is_expected.to eq true }
      end
    end

    describe '#offset_value' do
      subject{ paginator.offset_value }

      it{ is_expected.to eq 0 }
    end

    describe '#limit_value' do
      subject{ paginator.limit_value }

      it{ is_expected.to eq 25 }
    end

    describe '#paginate' do
      subject{ paginator.paginate }

      it{ is_expected.to be_a Array }
      it{ is_expected.to have(25).items }
    end


    context 'without options' do
      subject{ paginator }

      its(:total_count) { is_expected.to eq 100 }
      its(:total_pages) { is_expected.to eq 4 }
      its(:current_page){ is_expected.to eq 1 }
      its(:offset_value){ is_expected.to eq 0 }
      its(:limit_value) { is_expected.to eq 25 }
      its(:paginate)    { is_expected.to have(25).items }
    end

    context 'with options' do
      subject{ paginator }
      let(:paginator){ list.paginator(:range, offset: 20, limit: 20) }

      its(:total_count) { is_expected.to eq 100 }
      its(:total_pages) { is_expected.to eq 5 }
      its(:current_page){ is_expected.to eq 2 }
      its(:offset_value){ is_expected.to eq 20 }
      its(:limit_value) { is_expected.to eq 20 }
      its(:paginate)    { is_expected.to have(20).items }
    end

  end
end
