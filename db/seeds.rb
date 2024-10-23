Exercise.destroy_all
ExerciseCategory.destroy_all
MuscleGroup.destroy_all

ExerciseCategory.create!(name: 'Strength')
ExerciseCategory.create!(name: 'Cardio')
ExerciseCategory.create!(name: 'Flexibility')
MuscleGroup.create!(name: 'Chest')
MuscleGroup.create!(name: 'Back')
MuscleGroup.create!(name: 'Legs')
MuscleGroup.create!(name: 'Shoulders')
Exercise.create(name: 'Bench Press', description: 'Lift the barbell off your chest', exercise_categories: [ExerciseCategory.find_by(name: 'Strength')], muscle_groups: [MuscleGroup.find_by(name: 'Chest')], created_by_user: false)
Exercise.create(name: 'Deadlift', description: 'Lift the barbell off the ground', exercise_categories: [ExerciseCategory.find_by(name: 'Strength')], muscle_groups: [MuscleGroup.find_by(name: 'Back')], created_by_user: false)
