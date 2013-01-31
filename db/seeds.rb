# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(:email => 'alexnext@hotmail.fr', :password => '123456')
v = User.create(:email => 'toto@hotmail.fr', :password => '123456')

Article.populate(10..150) do |person|
  person.user_id = [v.id, u.id]
  person.title = ['lol', 'lol1', 'lol2']
  person.description = ['yep', 'yuy', 'yasy']
  person.tags = ['asdasd, asdasd, asd', 'es, dasd, da']
  person.like_nb = [ Random.rand(50)]
  person.dislike_nb = [ Random.rand(50) ]
end

#a = Article.create(:title => 'test1', :description => 'yoyo', :tags => 'asd, asd, asd', :user => u)

# b = Article.create(:title => 'test2', :description => 'yoyo', :tags => 'asd, asd, asd', :user => u)
# c = Article.create(:title => 'test3', :description => 'yoyo', :tags => 'asd, asd, asd', :user => v)
# d = Article.create(:title => 'test4', :description => 'yoyo', :tags => 'asd, asd, asd', :user => v)


