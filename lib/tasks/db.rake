require 'csv'

namespace :db do
  desc 'import database from CSV file'
  task import_from_csv: :environment do

    #   import database from CSV here
    # tournament 9 ball.csv
    ['tournament 9 ball.csv', 'tournament 10 ball.csv'].each do |tnm|
      ImportCSVService.import(tnm)
    end
  end

end
