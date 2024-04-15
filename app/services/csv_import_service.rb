require 'csv'

class CsvImportService < ApplicationService

  def initialize(file)
    @file = file
    @extension = File.extname(file.original_filename)
  end

  def call
    return failure('File should be csv.') unless ['.csv'].include?(@extension)
    insertion
    return success(message: 'Records were imported successfully.')
  rescue ActiveRecord::StatementInvalid
    return failure('Wrong data mapping.')
  rescue StandardError => e
    return failure(e.message)
  end

  private

  def insertion
    ActiveRecord::Base.transaction do
      Monster.insert_all(parsed_csv)
    rescue ActiveRecord::Rollback => e
      return failure(e.message)
    end
  end

  def parsed_csv
    csv = File.open(@file, encoding: "BOM|UTF-8")

    CSV.parse(
      csv,
      headers: true,
      header_converters: :symbol,
      skip_blanks: true,
      col_sep: ';'
    ).map(&:to_h)
  end
end
