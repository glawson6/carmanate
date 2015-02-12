#Carmanate

Functionality:

* CRUD CarProfile Car profile (Make,Model,Year)
* Search for car maintenance with car profile
* Get maintenance for found Car from Search
* Display maintenance as html
* Display maintenance as pdf
* Save Search object
* List search objects under user profile
* Display user profile
* Login User
* Logout user

Get all makes an year ids:
https://api.edmunds.com/api/vehicle/v2/makes?state=used&view=basic&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g


Get one make, model, year to get yearid:
https://api.edmunds.com/api/vehicle/v2/dodge?view=basic&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g
https://api.edmunds.com/api/vehicle/v2/honda/accord?year=2014&view=basic&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g

Once you have a yearid get maintenance:
https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=3279&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g

https://ancient-brushlands-6988.herokuapp.com