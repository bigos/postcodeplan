class Address < ApplicationRecord
  belongs_to :postal_code, class_name: 'Postcode',
             foreign_key: 'postcode',
             primary_key: 'code',
             inverse_of: :addresses

  validate :has_valid_postcode

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

  def has_valid_postcode
    if Postcode.where(code: self.postcode).count.zero?
      errors.add(:postcode, "is not valid")
    end
  end
end
