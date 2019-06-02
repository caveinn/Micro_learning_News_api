require 'date'
class MicroLearningApp < Sinatra::Base
    enable :sessions
    set :session_secret, "secret_secret"

    get "/" do
        erb :home
    end
  
    get "/signup" do
        erb :"users/signup"
    end

    post "/signup" do
        user = User.find_by(user_name: params["user_name"])
        if user
            @error = "Cannot register multiple users with the same name"
            return erb :"users/signup"
        end
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
        if not user
            @error = "wrong password or username"
            return erb :"users/login"
        end
        user_pass = BCrypt::Password.new(user.password)
        if user_pass == params["password"]
            session["user_id"] = user.id
            redirect "/categories"
        else
            @error = "wrong password or username"
            erb :"users/login"
        end
    end

    get "/categories" do 
        unless session.has_key?("user_id")  
            @error = "kindly log in"
            return erb :"users/login"
        end
        @categories = Category.all
        @user_categories = User.find(session["user_id"]).categories
        erb :"categories/show"
    end

    post "/categories" do
        unless session.has_key?("user_id")  
            @error = "kindly log in"
            return erb :"users/login"
        end
        categories = []
        params.keys.each do |key|
            category = Category.find_by(name: key)
            categories.append(category)
        end
        user = User.find(session["user_id"])
        user.categories = categories
        user.save
        redirect "/results"
    end

    get "/results" do 
        unless session.has_key?("user_id")  
            @error = "kindly log in"
            return erb :"users/login"
        end
        user = User.find(session["user_id"])
        results = []
        newsapi = News.new(ENV["API_KEY"])
        user.categories.each do |category|
            response = newsapi.get_everything(
                q: category.name,
                language: 'en',
                from: Date.today.strftime("%Y-%m-%d"),
                sortBy: 'relevancy'
                )
            results += response
        
        end

        @results = results
        erb :"results/show"
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end

end

