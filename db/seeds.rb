
bob = User.create(name: "Bob")
steve = User.create(name: "Steve")
carl = User.create(name: "Carl")
marc = User.create(name: "Marc")
jane = User.create(name: "Jane")
sarah = User.create(name: "Sarah")
jenny = User.create(name: "Jenny")

forkeys = Publisher.create(name: Faker::Company.name)
calums = Publisher.create(name: Faker::Company.name)
taker = Publisher.create(name: Faker::Company.name)
footer = Publisher.create(name: Faker::Company.name)
carlisle = Publisher.create(name: Faker::Company.name)
southebys = Publisher.create(name: Faker::Company.name)


bob.books.create(publisher_id: forkeys.id, title: "An Idiot Abroud" )
steve.books.create(publisher_id: calums.id, title: "Dust in Wind")
carl.books.create(publisher_id: taker.id, title: "Around the World")
marc.books.create(publisher_id: footer.id, title: "I Browned My Pants")
jane.books.create(publisher_id: carlisle.id, title: "Eustace Sinclair")
sarah.books.create(publisher_id: southebys.id, title: "My Kicks Got Shit On")
