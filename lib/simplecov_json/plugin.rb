module Danger
  # Report your Ruby app test suite code coverage.
  #
  # You can use [simplecov](https://github.com/colszowka/simplecov) to
  # gather code coverage data and a
  # [json formatter](https://github.com/vicentllongo/simplecov-json) so
  # this plugin can parse it.
  #
  # @example Report code coverage
  #
  #          simplecov.report_coverage('coverage/coverage.json')
  #
  # @see  marcelofabri/danger-simplecov_json
  # @tags ruby, code-coverage, simplecov
  #
  class DangerSimpleCovJson < Plugin
    # A method to parse and report code coverage information as a
    # message in Danger.
    # @return  [void]
    #
    def report(coverage_path, sticky: true)
      if File.exist? coverage_path
        coverage_json = JSON.parse(File.read(coverage_path), symbolize_names: true)
        metrics = coverage_json[:metrics]
        percentage = metrics[:covered_percent]
        lines = metrics[:covered_lines]
        total_lines = metrics[:total_lines]

        message("Code coverage is now at #{'%.02f' % percentage}% (#{lines}/#{total_lines} lines)", sticky: sticky)
      else
        fail('Code coverage data not found')
      end
    end

    def self.instance_name
      'simplecov'
    end
  end
end
