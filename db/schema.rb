# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160721011822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_levels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "allergies", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "allergy"
    t.string   "search"
    t.string   "severity"
    t.string   "reaction"
    t.string   "onset"
    t.datetime "date"
    t.string   "comment"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "allergies", ["doctor_id"], name: "index_allergies_on_doctor_id", using: :btree
  add_index "allergies", ["patient_id"], name: "index_allergies_on_patient_id", using: :btree

  create_table "allergy_searches", force: :cascade do |t|
    t.integer  "allergy_id"
    t.string   "allergy_name"
    t.string   "allergy_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "allergy_searches", ["allergy_id"], name: "index_allergy_searches_on_allergy_id", using: :btree

  create_table "appointment_patients", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "patient_name"
    t.string   "provider"
    t.string   "facility"
    t.text     "chief_complaint"
    t.integer  "appointment_type_id"
    t.integer  "duration"
    t.string   "duration_select"
    t.datetime "when_time"
    t.datetime "end_time"
    t.string   "repeat_val"
    t.string   "repeats"
    t.string   "occurs_on"
    t.string   "every_day"
    t.string   "ends_on"
    t.string   "string"
    t.integer  "after"
    t.string   "daily"
    t.string   "every_week"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "appointment_patients", ["appointment_type_id"], name: "index_appointment_patients_on_appointment_type_id", using: :btree
  add_index "appointment_patients", ["doctor_id"], name: "index_appointment_patients_on_doctor_id", using: :btree
  add_index "appointment_patients", ["patient_id"], name: "index_appointment_patients_on_patient_id", using: :btree

  create_table "appointment_types", force: :cascade do |t|
    t.string   "type"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calls", force: :cascade do |t|
    t.integer  "call_time"
    t.integer  "calls_col"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "customer"
    t.string   "card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chit_chats", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.integer  "encounter_id"
    t.string   "chit_chat"
    t.integer  "status"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "chit_chats", ["doctor_id"], name: "index_chit_chats_on_doctor_id", using: :btree
  add_index "chit_chats", ["encounter_id"], name: "index_chit_chats_on_encounter_id", using: :btree
  add_index "chit_chats", ["patient_id"], name: "index_chit_chats_on_patient_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "ios"
    t.string   "name"
    t.string   "nicename"
    t.string   "ios3"
    t.integer  "numcode"
    t.integer  "phonecode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ctp_codes", force: :cascade do |t|
    t.integer  "concept_id"
    t.integer  "code"
    t.string   "descriptor_id"
    t.string   "descriptor"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "diagnostics", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "diagnosis"
    t.string   "medication"
    t.integer  "charge"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "diagnostics", ["doctor_id"], name: "index_diagnostics_on_doctor_id", using: :btree
  add_index "diagnostics", ["request_id"], name: "index_diagnostics_on_request_id", using: :btree

  create_table "doctor_schedules", force: :cascade do |t|
    t.integer  "doctor_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.integer  "patient_id"
    t.integer  "facility_id"
  end

  add_index "doctor_schedules", ["doctor_id"], name: "index_doctor_schedules_on_doctor_id", using: :btree
  add_index "doctor_schedules", ["facility_id"], name: "index_doctor_schedules_on_facility_id", using: :btree
  add_index "doctor_schedules", ["patient_id"], name: "index_doctor_schedules_on_patient_id", using: :btree

  create_table "doctor_staffs", force: :cascade do |t|
    t.integer  "access_level_id"
    t.boolean  "is_admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "doctor_id"
  end

  add_index "doctor_staffs", ["access_level_id"], name: "index_doctor_staffs_on_access_level_id", using: :btree
  add_index "doctor_staffs", ["doctor_id"], name: "index_doctor_staffs_on_doctor_id", using: :btree

  create_table "doctor_types", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.float    "price"
    t.string   "extension"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "p_facility"
    t.integer  "access_level_id"
    t.boolean  "is_admin"
  end

  add_index "doctors", ["access_level_id"], name: "index_doctors_on_access_level_id", using: :btree

  create_table "encounters", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "encounter_type"
    t.string   "note_type"
    t.datetime "date"
    t.string   "seen_by"
    t.string   "facility"
    t.integer  "status"
    t.text     "chief"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "encounters", ["doctor_id"], name: "index_encounters_on_doctor_id", using: :btree
  add_index "encounters", ["patient_id"], name: "index_encounters_on_patient_id", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "state"
  end

  add_index "facilities", ["doctor_id"], name: "index_facilities_on_doctor_id", using: :btree

  create_table "fax_inboxes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "from"
    t.string   "file"
    t.boolean  "is_read"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "fax_date_utc"
    t.string   "json"
  end

  add_index "fax_inboxes", ["user_id"], name: "index_fax_inboxes_on_user_id", using: :btree

  create_table "fax_sents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "to"
    t.string   "file"
    t.string   "notes"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "queue_id"
    t.string   "message"
  end

  add_index "fax_sents", ["user_id"], name: "index_fax_sents_on_user_id", using: :btree

  create_table "health_exam_dates", force: :cascade do |t|
    t.integer  "patient_id"
    t.datetime "date1"
    t.datetime "date2"
    t.datetime "date3"
    t.datetime "date4"
    t.datetime "date5"
    t.datetime "date6"
    t.datetime "date7"
    t.datetime "date8"
    t.datetime "date9"
    t.datetime "date10"
    t.datetime "date11"
    t.datetime "date12"
    t.datetime "date13"
    t.datetime "date14"
    t.datetime "date15"
    t.datetime "date16"
    t.datetime "date17"
    t.datetime "date18"
    t.datetime "date19"
    t.datetime "date20"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "health_exam_dates", ["patient_id"], name: "index_health_exam_dates_on_patient_id", using: :btree

  create_table "mail_inboxes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "from"
    t.string   "title"
    t.string   "content"
    t.string   "file"
    t.boolean  "is_read"
    t.integer  "mail_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "mail_date_utc"
  end

  add_index "mail_inboxes", ["user_id"], name: "index_mail_inboxes_on_user_id", using: :btree

  create_table "mail_sents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "to"
    t.string   "title"
    t.string   "content"
    t.string   "file"
    t.integer  "status"
    t.integer  "mail_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mail_sents", ["user_id"], name: "index_mail_sents_on_user_id", using: :btree

  create_table "medical_histories", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.text     "major_history"
    t.text     "ongoing_history"
    t.text     "allergy_history"
    t.text     "family_history"
    t.text     "preventive_history"
    t.text     "social_history"
    t.text     "nutrition_history"
    t.text     "developmental_history"
    t.integer  "encounter_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "medical_histories", ["doctor_id"], name: "index_medical_histories_on_doctor_id", using: :btree
  add_index "medical_histories", ["encounter_id"], name: "index_medical_histories_on_encounter_id", using: :btree
  add_index "medical_histories", ["patient_id"], name: "index_medical_histories_on_patient_id", using: :btree

  create_table "medication_searches", force: :cascade do |t|
    t.string   "appl_no"
    t.string   "product_no"
    t.string   "form"
    t.string   "dosage"
    t.string   "product_mkt_status"
    t.string   "te_code"
    t.string   "reference_drug"
    t.string   "m_name"
    t.string   "active_ingred"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "medication_years", force: :cascade do |t|
    t.integer  "patient_id"
    t.datetime "date1"
    t.datetime "date2"
    t.datetime "date3"
    t.datetime "date4"
    t.datetime "date5"
    t.datetime "date6"
    t.datetime "date7"
    t.datetime "date8"
    t.datetime "date9"
    t.datetime "date10"
    t.datetime "date11"
    t.datetime "date12"
    t.datetime "date13"
    t.datetime "date14"
    t.datetime "date15"
    t.datetime "date16"
    t.datetime "date17"
    t.datetime "date18"
    t.datetime "date19"
    t.datetime "date20"
    t.datetime "date21"
    t.datetime "date22"
    t.datetime "date23"
    t.datetime "date24"
    t.datetime "date25"
    t.datetime "date26"
    t.datetime "date27"
    t.datetime "date28"
    t.datetime "date29"
    t.datetime "date30"
    t.datetime "date31"
    t.datetime "date32"
    t.datetime "date33"
    t.datetime "date34"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "medication_years", ["patient_id"], name: "index_medication_years_on_patient_id", using: :btree

  create_table "medications", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "search"
    t.string   "shorthand"
    t.string   "sig"
    t.string   "diagnosis"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "dis_reason"
    t.string   "comment"
    t.integer  "status"
    t.string   "form"
    t.string   "dosage"
    t.string   "product_no"
    t.string   "fev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "medications", ["doctor_id"], name: "index_medications_on_doctor_id", using: :btree
  add_index "medications", ["patient_id"], name: "index_medications_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "mobile_number"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "country"
    t.string   "no_mobile"
    t.string   "no_email"
    t.string   "send_mobile_text"
    t.string   "send_voice"
    t.string   "send_email"
    t.string   "work_ext"
    t.string   "method_of_communication"
    t.string   "suite"
    t.string   "status"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "f_name"
    t.string   "m_name"
    t.string   "l_name"
    t.string   "n_name"
    t.string   "email"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.string   "zip"
    t.date     "dob"
    t.string   "gender"
    t.string   "ssn"
    t.string   "insurance_company"
    t.integer  "insurance_id"
    t.string   "ign"
    t.string   "isn"
    t.date     "ins_subscriber_dob"
    t.string   "ins_subscriber_ssn"
    t.integer  "doctor_id"
    t.string   "sec_ssn"
    t.string   "sec_insurance_company"
    t.integer  "sec_insurance_id"
    t.string   "sec_ign"
    t.string   "sec_isn"
    t.date     "sec_ins_subscriber_dob"
    t.string   "sec_ins_subscriber_ssn"
    t.string   "avatar"
  end

  add_index "patients", ["doctor_id"], name: "index_patients_on_doctor_id", using: :btree

  create_table "pediatric_forms", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "pri_m"
    t.string   "pri_f"
    t.string   "pri_b"
    t.string   "pri_s"
    t.string   "pri_both"
    t.string   "pri_other"
    t.string   "sec_m"
    t.string   "sec_f"
    t.string   "sec_other"
    t.string   "rel"
    t.string   "ch_m"
    t.string   "ch_f"
    t.string   "ch_sibling"
    t.string   "ch_gra"
    t.string   "ch_nanny"
    t.string   "ch_day_care"
    t.string   "tobacco"
    t.string   "smokers"
    t.string   "cur_smokers"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "pediatric_forms", ["patient_id"], name: "index_pediatric_forms_on_patient_id", using: :btree

  create_table "practices", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "address"
    t.string   "suite"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.integer  "status"
    t.string   "time_zone"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "facility_name"
    t.string   "state"
  end

  add_index "practices", ["doctor_id"], name: "index_practices_on_doctor_id", using: :btree

  create_table "reactions", force: :cascade do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "creation_time"
    t.string   "symptoms"
    t.string   "allergy"
    t.integer  "complicated"
    t.string   "pharmacy_phone"
    t.boolean  "is_video"
    t.string   "charge_id"
    t.integer  "rating"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "requests", ["doctor_id"], name: "index_requests_on_doctor_id", using: :btree
  add_index "requests", ["patient_id"], name: "index_requests_on_patient_id", using: :btree

  create_table "short_hands", force: :cascade do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "soaps", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "note_subjective"
    t.string   "note_objective"
    t.string   "note_assessment"
    t.string   "note_plan"
    t.integer  "encounter_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "soaps", ["doctor_id"], name: "index_soaps_on_doctor_id", using: :btree
  add_index "soaps", ["encounter_id"], name: "index_soaps_on_encounter_id", using: :btree
  add_index "soaps", ["patient_id"], name: "index_soaps_on_patient_id", using: :btree

  create_table "social_adults", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "children"
    t.integer  "tobacco_no"
    t.integer  "tobacco_daily"
    t.integer  "tobacco_weekly"
    t.integer  "tobacco_former"
    t.integer  "alcohol_no"
    t.integer  "alcohol_daily"
    t.integer  "alcohol_weekly"
    t.integer  "alcohol_less"
    t.integer  "alcohol_former"
    t.integer  "ex_mod"
    t.integer  "ex_vig"
    t.integer  "sed"
    t.integer  "caff_no"
    t.integer  "caff_daily"
    t.integer  "caff_weekly"
    t.integer  "caff_less"
    t.integer  "caff_former"
    t.integer  "fm_che"
    t.integer  "fm_pipe"
    t.integer  "fm_cig"
    t.integer  "fm_cigarette"
    t.integer  "fm_beer"
    t.integer  "fm_liquor"
    t.integer  "fm_other"
    t.integer  "changes"
    t.integer  "chocolate"
    t.integer  "coffee"
    t.integer  "soda"
    t.integer  "tea"
    t.integer  "tablet"
    t.integer  "c_other"
    t.integer  "fm_smokeless"
    t.integer  "how_many"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "social_adults", ["patient_id"], name: "index_social_adults_on_patient_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supper_bills", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.integer  "encounter_id"
    t.string   "name"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "supper_bills", ["doctor_id"], name: "index_supper_bills_on_doctor_id", using: :btree
  add_index "supper_bills", ["encounter_id"], name: "index_supper_bills_on_encounter_id", using: :btree
  add_index "supper_bills", ["patient_id"], name: "index_supper_bills_on_patient_id", using: :btree

  create_table "sur_years", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "name1"
    t.string   "name2"
    t.string   "name3"
    t.string   "name4"
    t.string   "name5"
    t.string   "name6"
    t.string   "name7"
    t.string   "name8"
    t.string   "name9"
    t.string   "name10"
    t.string   "name11"
    t.string   "name12"
    t.string   "name13"
    t.string   "name14"
    t.string   "name15"
    t.string   "name16"
    t.string   "name17"
    t.string   "name18"
    t.string   "name19"
    t.string   "name20"
    t.string   "name21"
    t.string   "name22"
    t.string   "name23"
    t.string   "name24"
    t.string   "name25"
    t.string   "name26"
    t.string   "name27"
    t.string   "name28"
    t.string   "name29"
    t.string   "name30"
    t.string   "name31"
    t.string   "name32"
    t.string   "name33"
    t.string   "name34"
    t.string   "name35"
    t.string   "name36"
    t.string   "name37"
    t.string   "name38"
    t.string   "name39"
    t.string   "name40"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sur_years", ["patient_id"], name: "index_sur_years_on_patient_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "due_date"
    t.text     "desc"
    t.boolean  "active",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "provider_id"
  end

  add_index "tasks", ["doctor_id"], name: "index_tasks_on_doctor_id", using: :btree
  add_index "tasks", ["patient_id"], name: "index_tasks_on_patient_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "request_id"
    t.float    "price"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["request_id"], name: "index_transactions_on_request_id", using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.string   "personal_email"
    t.string   "office_phone"
    t.string   "fax"
    t.string   "degree"
    t.integer  "sex"
    t.string   "primary_specialty"
    t.integer  "access_level"
    t.integer  "facility_id"
    t.string   "city"
    t.string   "state"
    t.string   "practice_web_addr"
    t.string   "biography"
    t.string   "medical_license"
    t.date     "expiration"
    t.string   "state_practiced"
    t.string   "specialty_on_license"
    t.string   "dea_number"
    t.string   "upin"
    t.string   "ein_tin"
    t.string   "npi_number"
    t.string   "nadean_number"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "sfax_apikey"
    t.string   "sfax_username"
    t.string   "sfax_encryptionkey"
    t.string   "phimail_email"
    t.string   "phimail_password"
  end

  add_index "user_profiles", ["facility_id"], name: "index_user_profiles_on_facility_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "avatar"
    t.integer  "user_profile_id"
    t.string   "title"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["owner_id", "owner_type"], name: "index_users_on_owner_id_and_owner_type", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  add_index "users", ["user_profile_id"], name: "index_users_on_user_profile_id", using: :btree

  create_table "vitals", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.float    "height"
    t.float    "weight"
    t.float    "bmi"
    t.float    "bp"
    t.float    "temp"
    t.string   "route"
    t.float    "pulse"
    t.float    "rr"
    t.integer  "sat"
    t.string   "ra"
    t.string   "pain"
    t.datetime "date"
    t.integer  "encounter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "vitals", ["doctor_id"], name: "index_vitals_on_doctor_id", using: :btree
  add_index "vitals", ["encounter_id"], name: "index_vitals_on_encounter_id", using: :btree
  add_index "vitals", ["patient_id"], name: "index_vitals_on_patient_id", using: :btree

  add_foreign_key "allergies", "doctors"
  add_foreign_key "allergies", "patients"
  add_foreign_key "allergy_searches", "allergies"
  add_foreign_key "appointment_patients", "appointment_types"
  add_foreign_key "appointment_patients", "doctors"
  add_foreign_key "appointment_patients", "patients"
  add_foreign_key "chit_chats", "doctors"
  add_foreign_key "chit_chats", "encounters"
  add_foreign_key "chit_chats", "patients"
  add_foreign_key "diagnostics", "doctors"
  add_foreign_key "diagnostics", "requests"
  add_foreign_key "doctor_schedules", "doctors"
  add_foreign_key "doctor_schedules", "facilities"
  add_foreign_key "doctor_schedules", "patients"
  add_foreign_key "doctor_staffs", "access_levels"
  add_foreign_key "encounters", "doctors"
  add_foreign_key "encounters", "patients"
  add_foreign_key "facilities", "doctors"
  add_foreign_key "fax_inboxes", "users"
  add_foreign_key "fax_sents", "users"
  add_foreign_key "health_exam_dates", "patients"
  add_foreign_key "mail_inboxes", "users"
  add_foreign_key "mail_sents", "users"
  add_foreign_key "medical_histories", "doctors"
  add_foreign_key "medical_histories", "encounters"
  add_foreign_key "medical_histories", "patients"
  add_foreign_key "medication_years", "patients"
  add_foreign_key "medications", "doctors"
  add_foreign_key "medications", "patients"
  add_foreign_key "patients", "doctors"
  add_foreign_key "pediatric_forms", "patients"
  add_foreign_key "practices", "doctors"
  add_foreign_key "requests", "doctors"
  add_foreign_key "requests", "patients"
  add_foreign_key "soaps", "doctors"
  add_foreign_key "soaps", "encounters"
  add_foreign_key "soaps", "patients"
  add_foreign_key "social_adults", "patients"
  add_foreign_key "supper_bills", "doctors"
  add_foreign_key "supper_bills", "encounters"
  add_foreign_key "supper_bills", "patients"
  add_foreign_key "sur_years", "patients"
  add_foreign_key "tasks", "doctor_staffs", column: "provider_id"
  add_foreign_key "tasks", "doctors"
  add_foreign_key "tasks", "patients"
  add_foreign_key "transactions", "requests"
  add_foreign_key "user_profiles", "facilities"
  add_foreign_key "users", "user_profiles"
  add_foreign_key "vitals", "doctors"
  add_foreign_key "vitals", "encounters"
  add_foreign_key "vitals", "patients"
end
