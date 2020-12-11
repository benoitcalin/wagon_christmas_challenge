puts "Destroy everything"
User.destroy_all
Batch.destroy_all
puts "Batches destoyed"


puts "Create Batches"
batch_names = ['Batch-16', 'Batch-19', 'Batch-31', 'Batch-40', 'Batch-51', 'Batch-67', 'Batch-85', 'Batch-102', 'Batch-127', 'Batch-140', 'Batch-166', 'Batch-191', 'Batch-213', 'Batch-246', 'Batch-276', 'Batch-325', 'Batch-343', 'Batch-411', 'Batch-435', 'Batch-478', 'Batch-484', 'Batch-516', 'Batch-pirate']

batch_names.each do |name|
  Batch.create!(name: name)
end
puts "Batches created"

puts "Create Users"
User.create!(pseudo: "Pilou-1", batch: Batch.find_by_name('Batch-343'), challenger_id: '1237086')
User.create!(pseudo: "Pilou-2", batch: Batch.find_by_name('Batch-343'), challenger_id: '1222761')
User.create!(pseudo: "ElGrincho", batch: Batch.find_by_name('Batch-213'), challenger_id: '1095582')
puts "Users created"

puts "Seeding scores from real data..."
Rake::Task["score:compute"].invoke

puts "Seed terminated"
