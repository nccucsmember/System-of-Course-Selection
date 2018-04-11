class CreateCoursedetails < ActiveRecord::Migration[5.1]
  def change
    create_table :coursedetails,:id => false, :primary_key => :course_id do |t|
        t.string :course_id, :null => false
        t.string :course_semester, :null => false
        t.string :course_subject_id, :null => false
        t.string :course_name_ch
        t.string :course_name_en
        t.string :course_teacher
        t.integer :course_credit
        t.time :course_begin_time
        t.time :course_end_time
        t.string :course_weekday
        t.string :location_id
        t.integer :course_maxnum
        t.string :course_grad
        t.string :general_category
        t.boolean :central_general
    end
  end
end
