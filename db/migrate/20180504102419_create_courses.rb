class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, :id => false, :primary_key => :course_id do |t|
		  t.string :course_id, :null => false
	    t.string :semester, :null => false
	    t.string :subject_id, :null => false
		  t.string :num_semesters
    	t.string :course_name_ch
	    t.string :course_name_en
	    t.string :teacher
    	t.integer :credits
	    t.time :begin_time
    	t.time :end_time
	    t.string :weekday
    	t.string :location
	    t.string :department
    	t.string :course_type
	    t.string :general_type
    	t.boolean :central_general
	    t.integer :course_maxnum

		  t.string :TA_id, :null => false # foreign key to TA.TA_id
      t.timestamps
    end
  end
end
