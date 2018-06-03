# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180603142429) do

  create_table "chooses", primary_key: "cs_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "course_id", null: false
    t.string "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "is_chosen"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "content"
    t.integer "good"
    t.float "score", limit: 24
    t.string "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coursedetails", primary_key: "course_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "course_semester", null: false
    t.string "course_subject_id", null: false
    t.string "course_name_ch"
    t.string "course_name_en"
    t.string "course_teacher"
    t.integer "course_credit"
    t.time "course_begin_time"
    t.time "course_end_time"
    t.string "course_weekday"
    t.string "location_id"
    t.string "course_dept"
    t.string "course_type", limit: 1
    t.string "general_category"
    t.boolean "central_general"
    t.integer "course_maxnum"
    t.index ["course_id"], name: "coursedetails_course_id_index"
  end

  create_table "courses", primary_key: "subject_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "course_id", null: false
    t.string "semester", null: false
    t.string "num_semesters"
    t.string "course_name_ch"
    t.string "course_name_en"
    t.string "teacher"
    t.integer "credits"
    t.time "begin_time"
    t.time "end_time"
    t.string "weekday"
    t.string "location"
    t.string "department"
    t.string "course_type"
    t.string "is_general"
    t.string "general_type"
    t.string "central_general"
    t.integer "course_maxnum"
    t.string "TA_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_infors", primary_key: "schoolid", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schoolid"], name: "index_personal_infors_on_schoolid"
  end

  create_table "students", primary_key: "student_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tas", primary_key: "TA_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thumbups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "auth_token", null: false
    t.integer "comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "schoolid", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["schoolid"], name: "users_schoolid_pk", unique: true
  end

end
