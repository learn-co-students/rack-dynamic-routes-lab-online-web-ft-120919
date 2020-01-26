class Application
  @@items = []

  def call(env)
    #Accepts only /items/<ITEM NAME> route. Everything else 404's.
    #Return the price of the item that the user requests, or a 400
    #with an error messsage if they request an item that we don't have
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      #binding.pry
      the_item = @@items.find{|i| i.name == item_name}
      #binding.pry
      if the_item != nil #item in @@items
        resp.write("#{the_item.price}")
        resp.status = 200
      else #item not in @@items
        resp.write("Item not found")
        resp.status = 400
      end #if

    else #path is something other than items
      resp.write("Route not found")
      resp.status = 404
    end #if

    resp.finish 
  end #call

end #class