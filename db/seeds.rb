# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(username: 'chh',
            name:     'Ching-Han Ho',
            email:    'chh@cizoo.com',
            password: '12345678',
            password_confirmation: '12345678')

shop = Shop.create(name: '50 嵐',
                   address: '台北市濟南路二段60-2號',
                   tel: '0223915189')

drink = shop.drinks.create(name: '四季春茶')
