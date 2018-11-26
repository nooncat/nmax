require 'spec_helper'

RSpec.describe Nmax::Finder do # rubocop:disable Metrics/BlockLength
  let(:object) { described_class }
  let(:lines) { ['test line with numbers 234 234234', '4433 34 another test line with numbers'] }
  let(:numbers_count) { 3 }

  describe 'call' do
    let(:subject) { object.new(lines, numbers_count).call }

    it 'return array' do
      expect(subject).to be_a(Array)
    end

    it 'return sorted array' do
      expect(subject).to eq([234_234, 4433, 234])
    end

    context 'when count of finded numbers in passed lines is equal or bigger than numbers_count' do
      it 'return array with size equal to passed value of numbers_count' do
        expect(subject.size).to eq(numbers_count)
      end
    end

    context 'when count of finded numbers in passed lines is smaller than numbers_count' do
      let(:numbers_count) { 6 }
      let(:finded_numbers) { object.new(lines, numbers_count).send(:all_numbers).size }

      it 'return array with size equal to finded numbers in passed lines' do
        expect(subject.size).to eq(finded_numbers)
      end
    end
  end

  describe '#all_numbers' do
    let(:subject) { object.new(lines, numbers_count).send(:all_numbers) }

    it 'return array' do
      expect(subject).to be_a(Array)
    end

    it 'return array with size equal to count of numbers in passed lines' do
      expect(subject.size).to eq(4)
    end
  end

  describe '#find_numbers' do
    let(:line) { 'test234 088 76.75 line with numbers 234234 34' }
    let(:subject) { object.new(lines, numbers_count).send(:find_numbers, line) }

    it 'return array' do
      expect(subject).to be_a(Array)
    end

    it 'return array with matched numbers in passed line' do
      expect(subject).to eq([234_234, 34])
    end
  end
end
