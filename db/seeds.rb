# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TicketType.create([
    {name: 'Petrean first pair standard', price: '350.00', max_number: '300', ticket_group: '1'},
    {name: 'Petrean first pair champagne', price: '400.00', max_number: '100', ticket_group: '1'},
    {name: 'Petrean first pair dining', price: '470.00', max_number: '19', ticket_group: '1'},

    {name: 'Past committee pair standard', price: '350.00', max_number: '15'},

    {name: 'General release pair standard', price: '370.00', max_number: '0', ticket_group: '2'},
    {name: 'General release pair champagne', price: '430.00', max_number: '0', ticket_group: '2'},
    {name: 'General release pair dining', price: '510.00', max_number: '0', ticket_group: '2'},

    {name: 'Alumni and staff pair standard', price: '370.00', max_number: '0', ticket_group: '3'},
    {name: 'Alumni and staff pair champagne', price: '430.00', max_number: '0', ticket_group: '3'},
    {name: 'Alumni and staff pair dining', price: '510.00', max_number: '0', ticket_group: '3'},
    
    {name: 'Free single', price: '0', max_number: '43', size: '1'},
    {name: 'VIP single', price: '300', max_number: '100', size: '1'},

    {name: 'Fellow single standard', price: '185.00', max_number: '90', size: '1'},
    {name: 'Fellow single champagne', price: '215.00', max_number: '27', size: '1'},
    {name: 'Fellow single dining', price: '255.00', max_number: '10', size: '1'},

    {name: 'Event staff single standard', price: '90', max_number: '10000', size: '1'},
    ])

User.create({email: 'gt319@cam.ac.uk', admin: true, password: Devise.friendly_token})
