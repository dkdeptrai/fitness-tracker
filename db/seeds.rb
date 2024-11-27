# db/seeds.rb

puts "Starting seeding process..."

begin
  Exercise.destroy_all
  ExerciseCategory.destroy_all
  MuscleGroup.destroy_all
  User.destroy_all

  puts "Destroyed existing records"

  exercise_categories = [
    { name: 'Strength' },
    { name: 'Cardio' },
    { name: 'Flexibility' }
  ]

  users = [
    { email: 'admin@gmail.com', password: 'password', admin: true },
    { email: 'normaluser@gmail.com', password: 'password', admin: false }
  ]

  muscle_groups = [
    { name: 'Chest' },
    { name: 'Back' },
    { name: 'Legs' },
    { name: 'Shoulders' }
  ]

  exercises = [
    {
      name: 'Bench Press',
      description: 'Lift the barbell off your chest',
      exercise_category_name: 'Strength',
      muscle_group_names: ['Chest'],
      created_by_user: false
    },
    {
      name: 'Deadlift',
      description: 'Lift the barbell off the ground',
      exercise_category_name: 'Strength',
      muscle_group_names: ['Back'],
      created_by_user: false
    }
  ]

  puts "Creating ExerciseCategories..."
  ExerciseCategory.create!(exercise_categories)

  puts "Creating MuscleGroups..."
  MuscleGroup.create!(muscle_groups)

  puts "Creating Users..."
  User.create!(users)

  puts "Creating Exercises..."
  exercises.each do |exercise|
    user = User.first
    exercise_category = ExerciseCategory.find_or_create_by(name: exercise[:exercise_category_name])
    muscle_groups = exercise[:muscle_group_names].map { |name| MuscleGroup.find_or_create_by(name: name) }

    Exercise.create!(
      name: exercise[:name],
      description: exercise[:description],
      exercise_category: exercise_category,
      muscle_groups: muscle_groups,
      user: user,
      created_by_user: exercise[:created_by_user]
    )
  end

  puts "Seeding completed successfully"
rescue StandardError => e
  puts "An error occurred during seeding: #{e.message}"
  puts e.backtrace.join("\n")
ensure
  puts "Total Users: #{User.count}"
  puts "Total Exercises: #{Exercise.count}"
  puts "Total ExerciseCategories: #{ExerciseCategory.count}"
  puts "Total MuscleGroups: #{MuscleGroup.count}"
end
