class Address < ApplicationRecord
  belongs_to :postal_code, class_name: 'Postcode',
             foreign_key: 'postcode',
             primary_key: 'code',
             inverse_of: :addresses

  validate :has_valid_postcode

  def has_valid_postcode
    if Postcode.where(code: self.postcode).count.zero?
      errors.add(:postcode, "is not valid")
    end
  end

  def self.all_locations
    output = ''
    output << '['
    Address.all
      .each_with_index
      .map do |a, i|
      output << "['#{a.firstline}', #{a.postal_code.location_string}, i]"
      output << ', ' if i < Address.count - 1
    end
    output << ']'
  end

  def self.bulk_text_import
    # multiple lines in following format
    # Lidl, Cavendish Street OL6 7PF

    # https://stackoverflow.com/questions/164979/uk-postcode-regex-comprehensive
    postcode_regex = /([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z]))))\s?[0-9][A-Za-z]{2})/
    fh = File.open(Rails.root.join 'import.txt')
    fh.readlines.each do |line|
      postcode_regex =~ line
      new_address = Address.create(firstline: $`, postcode: $~.to_s)
      p new_address
      p new_address.valid?
    end
  end
end
