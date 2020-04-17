namespace :db do
  task :populate_fake_data => :environment do
    # If you are curious, you may check out the file
    # RAILS_ROOT/test/factories.rb to see how fake
    # model data is created using the Faker and
    # FactoryBot gems.
    puts "Populating database"
    # 10 event venues is reasonable...
    create_list(:event_venue, 10)
    # 50 customers with orders should be alright
    create_list(:customer_with_orders, 50)
    # You may try increasing the number of events:
    create_list(:event_with_ticket_types_and_tickets, 3)
  end
  task :model_queries => :environment do
    # Sample query: Get the names of the events available and print them out.
    # Always print out a title for your query
    
    puts("Query 1")
    c = Customer.first
    result = c.tickets.count
    print("total tickets of given customer ")
    puts(result)
    #puts("EOQ") # End Of Query -- always add this line after a query.
    puts("EOQ")
    puts("Query 2")
    c = Customer.first
    r = c.tickets.joins(:ticket_type).select(:event_id).distinct.count
    print("diferent events of a given customer ")
    puts(r)
    puts("EOQ")
    puts("Query 3")
    res = Event.joins(ticket_types: {tickets: {order: :customer}}).where('customers.age'=> 18)
    puts(res.name)
    puts("EOQ")
    puts("Query 4")
    #eventstats is empty
    ret = EventStat.joins(:event).select(:ticket_sold).where('event_id'=>1)
    print("Ticketssold for event given event ")
    puts(ret)
    puts("EOQ")
    puts("Query 5")
    rr = Event.joins(ticket_types: :tickets).group("event_id").where('id'=>2).count
    print("total number of tickets sold for an event ")
    puts(rr)
    puts("EOQ")
    puts("Query 6")
    print("count of Females that atend the followin events ")
    ri = Event.joins(ticket_types: {tickets: {order: :customer}}).group("event_id").where('customers.gender'=>"f").count
    puts(ri)
    puts("EOQ")
    puts("Query 7")
    rii = Event.joins(ticket_types: {tickets: {order: :customer}}).group("event_id").where('customers.age >? AND customers.age<?',18,30).count
    print("Count of customers in between 18 and 30 years that went to an event ")
    puts(rii)
    puts("EOQ")
  end
end