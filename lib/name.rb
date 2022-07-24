require 'pry'
require 'csv'


class Name
  attr_reader :year, :bio_gender, :ethnicity, :name, :count, :rank
  @@filename = './lib/Popular_Baby_Names.csv'

  def initialize(data)
    @year = data[:year_of_birth]
    @bio_gender = data[:gender]
    @ethnicity = data[:ethnicity]
    @name = data[:childs_first_name]
    @count = data[:count]
    @rank = data[:rank]

  end

  def self.find_by_name(name)
    rows = CSV.read(@@filename, headers: true)
    result = []

    rows.each do |row|
      result << Name.new(row) if row["Child's First Name"] == name
    end
    result
  end

  def self.find_by_year(year)
    rows = CSV.read(@@filename, headers: true)

    rows.map do |row|
      Name.new(row) if row["Year of Birth"] == year
    end
  end

  def self.where(details) #hash
    rows = CSV.read(@@filename, headers: true, header_converters: :symbol)

    rows.select do |row|
      Name.new(row) if row[details.keys[0]] == details.values[0]
    end
  end

  def self.order(details) #hash
    rows = CSV.read(@@filename, headers: true, header_converters: :symbol)

    array = rows.map do |row|
      Name.new(row)
    end
    if details.values[0] == :asc
      array.sort_by do |element|
        element.send(details.keys[0]) #this is dynamic
        # element.year this isn't dynamic
      end
    elsif details.values[0] == :desc
      array.sort_by { |element| element.year }.reverse
    end
  end

end

p Name.order({ year: :asc})[-1]
p Name.order({ year: :desc})[-1]
p Name.order({ name: :desc})[0]



# p Name.where({rank: "25"}).count
# p Name.where({gender: "MALE"}).count
#
# p Name.where({gender: "FEMALE"}).count
# p Name.where({ethnicity: "BLACK NON HISPANIC"}).count


# p Name.find_by_name("Ian").count
# p Name.find_by_name("MEGAN").count
# p Name.find_by_name("Sal").count
# p Name.find_by_name("Omar").count
# p Name.find_by_name("Riley").count
# p Name.find_by_name("HUNTER").count


# p Name.find_by_year("2011").count
