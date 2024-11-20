# app/models/admin.rb
class Admin < ApplicationRecord
    has_one :user
  end
  
