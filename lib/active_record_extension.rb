module ActiveRecordExtension
  require 'csv'
  require 'iconv'
  require 'xml'

  extend ActiveSupport::Concern

  module ClassMethods
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |object|
          csv << object.attributes.values_at(*column_names)
        end
      end
    end

    def import(file)
      spreadsheet = CSV.read(file.path, {headers: true})
      headers = spreadsheet.headers

      spreadsheet.each do |row|
        object = find_by_id(row["id"]) || new(row.to_hash)
        object.save!
      end
    end

    def self.to_xml(options = {})
      XML.generate(options) do |xml|
        xml << column_names
        all.each do |object|
          xml << object.attributes.values_at(*column_names)
        end
      end
    end

    def import_xml(file)
      spreadsheet = XML.read(file.path, {headers: true})
      headers = spreadsheet.headers

      spreadsheet.each do |row|
        object = find_by_id(row["id"]) || new(row.to_hash)
        object.save!
      end
    end
  end
end


ActiveRecord::Base.send(:include, ActiveRecordExtension)