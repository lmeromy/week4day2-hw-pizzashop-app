require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/pizza_order' )
also_reload( './models/*' )


# index route - gets all pizza orders
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end

# create route - takes in the input from new, enters into db
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
  # can also wrap an if statement over this code to add validation
  #  eg if quantity >= 1, etc. Or can do in new erb html
end

# new route - create. must be above route pizza-orders/:id
# otherwise it will think new is replacing :id
get '/pizza-orders/new' do
  erb(:new)
end

# edit route
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

# update route
post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
  @order.update()
  erb(:update)
  # or redirect! then you don't need the erb
end

# delete route
post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  erb(:delete) # or could use a redirect here!
end

# show route - show one pizza
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end
