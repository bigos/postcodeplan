class Postcode < ApplicationRecord

  # takes about 15 minutes to import
  def self.seed_locations
    require 'csv'
    csv = Rails.root.join 'ukpostcodes.csv'
    arr_of_arrs = CSV.read(csv)
    puts arr_of_arrs[1..10].inspect

    columns = [:id, :code, :lat, :lon]

    start = 1
    finish = arr_of_arrs.length - 1
    batch = 1000
    while start < finish
      puts "seeding start #{start} of #{finish}"
      values = arr_of_arrs[start..(start + (batch-1))]
      Postcode.import columns, values
      start += batch
    end
  end
end
