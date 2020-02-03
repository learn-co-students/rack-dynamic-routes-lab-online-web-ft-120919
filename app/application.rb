class Application
    @@items = []

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path.match(/items/)
        item_name = req.path.split("/items/").last

        item = @@items.find{|i| i.name == item_name}

        if item.nil? #IF a user requests an item that is not available
          resp.write "Item not found"
          resp.status = 400
        else
          resp.write item.price #If user requests '/items/<Item Name>' it returns the price of that item.
        end
      else
        resp.write "Route not found" 
        resp.status = 404
      end

      resp.finish
    end
end