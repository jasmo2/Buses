# == Schema Information
#
# Table name: buses
#
#  id            :integer          not null, primary key
#  create        :string
#  update        :string
#  plate_license :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Bus < ActiveRecord::Base
  belongs_to :user
  has_many :trips
  has_many :routes, through: :trips
  def self.add_routes(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      byebug
    end
  end

  private
  def self.open_spreadsheet(file)
    if file != nil
      case File.extname(file.original_filename)
        when ".csv" then Roo::Csv.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise ArgumentError, "Tipo de Archivo desconocido #{file.original_filename}"
      end
    else
     raise ArgumentError, "Tipo de Archivo vacio"
    end
  end
end
