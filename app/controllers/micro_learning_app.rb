class MicroLearningApp < Sinatra::Base
    enable :sessions
    set :session_secret, "secret_secret"
  
    get "/signup" do
        erb :"users/signup"
    end

    post "/signup" do
        user = ""
        if params["password"] == params["confirm_password"]
            params.delete("confirm_password")
            params["password"] = BCrypt::Password.create(params["password"])
            user = User.new(params)
            user.save
            redirect "/login"
        else
            @error = "password does not much confirm password"
            erb :"users/signup"
        end
    end

    get "/login" do
        erb :"users/login"
    end

    post "/login" do
        user = User.find_by(user_name: params["user_name"])
        user_pass = BCrypt::Password.new(user.password)
        if user_pass == params["password"]
            session["user_id"] = user.id
            puts session.inspect
            redirect "/categories"
        else
            flash[:warning] = "something went wrong"
            erb :"users/login"
        end
    end

    get "/categories" do 
        puts session.inspect
        @categories = Category.all
        erb :"categories/show"
    end

    post "/categories" do
        puts session.inspect
        unless session.has_key?("user_id")  
            @error = "kindly log in"
            redirect "/login"
        end
        categories = []
        params.keys.each do |key|
            category = Category.find_by(name: key)
            categories.append(category)
        end
        user = User.find(session["user_id"])
        user.categories = categories
        puts user.inspect
        user.save
    end

end

