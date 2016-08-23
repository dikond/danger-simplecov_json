require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerSimpleCovJson do
    it 'should be a plugin' do
      expect(Danger::DangerSimpleCovJson.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @simplecov = @dangerfile.simplecov
      end

      # Some examples for writing tests
      # You should replace these with your own.

      it 'Shows code coverage report' do
        monday_date = Date.parse('2016-07-11')
        allow(Date).to receive(:today).and_return monday_date

        @simplecov.report('spec/fixtures/coverage.json')

        expect(@dangerfile.status_report[:messages]).to eq(['Code coverage is now at 99.15% (1512/1525 lines)'])
      end

      it 'Fails if code coverage not found' do
        @simplecov.report('spec/fixtures/missing_file.json')

        expect(@dangerfile.status_report[:errors]).to eq(['Code coverage data not found'])
      end
    end
  end
end
