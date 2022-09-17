# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Running seeds..."
users_data = [
    {
        email: "pierre@palenca.com",
        password_digest: BCrypt::Password.create("MyPwdChingon123"),
        platform: "uber",
        profile: {
            country: "mx",
            city_name: "Ciudad de Mexico",
            worker_id: "34dc0c89b16fd170eba320ab186d08ed",
            first_name: "Pierre",
            last_name: "Delarroqua",
            email: "pierre@palenca.com",
            phone_prefix: "+52",
            phone_number: "5576955981",
            rating: "4.8",
            lifetime_trips: 1254
        }
    },
    {
        email: "dante@palenca.com",
        password_digest: BCrypt::Password.create("MyPwdChingon123"),
        platform: "didi",
        profile: {
            country: "mx",
            city_name: "Monterrey",
            worker_id: "worker",
            first_name: "Dante",
            last_name: "Rangel",
            email: "dante@palenca.com",
            phone_prefix: "+52",
            phone_number: "5550838196",
            rating: "5",
            lifetime_trips: 12
        }
    }
]

data_added = 0
users_data.each do |data|
    next if User.find_by_email(data[:email])

    User.create(data)
    puts "User added ...#{data[:email]}"    
    data_added += 1
end

puts "Seeds ...#{data_added}"