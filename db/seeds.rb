# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
require 'pry'
  user =  User.create("first_name":"Moin","last_name":"Ahmed","email":"moinahmedptw@gmail.com","password":"Moin123456")  
  if user.persisted?
    user.create_member_detail("super_admin":true)
  end   

  Tag.create("title":"featured",description:" Dive into our finest featured content, spanning technology, culture, and more. Discover fresh perspectives and expert insights")
  Tag.create("title":"trending",description:" Dive into our trending featured content, spanning technology, culture, and more. Discover fresh perspectives and expert insights")
  Tag.create("title":"news",description:" Dive into our news  content, spanning technology, culture, and more. Discover fresh perspectives and expert insights")
  Tag.create("title":"events",description:" Dive into our events content, spanning technology, culture, and more. Discover fresh perspectives and expert insights")
  Tag.create("title":"Arunachal",description:"Arunachal Pradesh: The Land of the Dawn-Lit Mountains, Arunachal Pradesh, in northeastern India, mesmerizes with its diverse cultures, pristine landscapes, and spiritual sanctuaries, offering a unique blend of natural beauty and cultural richness.")
  Tag.create("title":"latest",description:" Dive into our latest tech content, spanning technology, culture, and more. Discover fresh perspectives and expert insights")


  