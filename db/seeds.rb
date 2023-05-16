# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user_one = User.create({full_name: 'oshie', email: 'oshie@mail.com', password: '123456'});



puts "Creating Houses"
houses = House.create(
    {
        name:"Ordinary house",
        city:"Dallas",
        image:"https://images.pexels.com/photos/2468773/pexels-photo-2468773.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        appartment_fee:20.0,
        description:"located outside of city, small and comfortable near the beach"

    });
houses = House.create({
        name:"Ordinary house",
        city:"Dallas",
        image:"https://images.pexels.com/photos/2468773/pexels-photo-2468773.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        appartment_fee:20.0,
        description:"located outside of city, small and comfortable near the beach"

    });
houses = House.create({
        name:"Ordinary house",
        city:"Dallas",
        image:"https://images.pexels.com/photos/2468773/pexels-photo-2468773.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        appartment_fee:20.0,
        description:"located outside of city, small and comfortable near the beach"

    });
houses = House.create({
        name:"Ordinary house",
        city:"Dallas",
        image:"https://images.pexels.com/photos/2468773/pexels-photo-2468773.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        appartment_fee:20.0,
        description:"located outside of city, small and comfortable near the beach"

    });

puts "Houses Created"
reservation_one = Reservation.create({reservation_date:"10/10/2023", user_id:user_one.id, house_id:houses[0].id})