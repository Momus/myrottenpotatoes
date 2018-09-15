# Add the movie table to the database
class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string   'title'
      t.string   'rating'
      t.text     'description'
      t.datetime 'release_date'
      # Auto add fields that let Rails keep track of
      # creation/modification time.
      t.timestamps
    end
  end
end
