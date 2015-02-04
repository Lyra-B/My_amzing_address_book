MyAmazingAddressBook::App.controllers :person do	
	get '/' do #this is not the homepage!It's /person
		"Hello"
	end
end