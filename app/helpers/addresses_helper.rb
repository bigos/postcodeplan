module AddressesHelper
  def location_info(addresses)
    output = '['
    addresses.each_with_index.map do |a, i|
      output << '['
      output << "'"
      output << link_to("see", a)
      output << a.firstline
      output << "'"
      output << ", #{a.postal_code.location_string}, #{i}"
      output << ']'
      output << ', ' if i < Address.count - 1
    end
    output << ']'
  end
end
