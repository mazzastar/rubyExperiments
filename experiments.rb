require 'csv'

COHORT_COUNT = 19 
names = [["Alex", ""], ["Sroop", ""], ["Shelly", ""],["Scott", ""],["Stefania", ""],["Appo", ""],
		["Rob", ""],["Nico", ""],["Dan", ""],["Robin", ""],["Josh", ""],["Louise", ""],["Muhanad", ""],
		["Will", ""],["Oli", ""],["Emma", ""],["Julie", ""],["Joey", ""],["Steve", ""]]

object_collection=[[1], {r:5}, ""]

def shuffled_methods(object)
	object.shuffle
end

def methods_of(object)
	object.methods
end

def print_methods_count(object) 
	methods_of(object).count/COHORT_COUNT
end

def fill file, type, data_entries, names
	number_users=names.length
	tasks_per_user= data_entries.count/number_users
	task_slices= data_entries.each_slice(tasks_per_user).to_a
	names_and_tasks=names.zip(task_slices)

	names_and_tasks.each do |datarow|
		# file << [datarow[1], type, datarow[0]]
		fill_entry(file, datarow[1], type, datarow[0])
	end
end

def fill_entry file, data, type, name
	data.each do |data_row|
		file <<[data_row, type, name[0]]
	end
end

def print_method_count(object)
	puts "#{object.class.name} : #{print_methods_count(object)}"
end

def print_all_methods(collection)
	collection.each do |object|
		print_method_count(object)
	end
end


def writeFile(file, object_collection, users)
CSV.open(file, "w") do |csv|
	csv << ["Method", "Class", "Name"]
	object_collection.each do |collection_class|
		fill csv, collection_class.class.name, methods_of(collection_class).shuffle, users
	end
end

end

def printStats(object_collection, names)
	total =  print_methods_count([])+print_methods_count({})+print_methods_count("")
	print_all_methods(object_collection)
	puts "total methods each: #{total}"
end

writeFile("Methods_assignment.csv", object_collection, names)
puts "Correct no_of names? #{names.count==COHORT_COUNT}"
printStats(object_collection, names)



