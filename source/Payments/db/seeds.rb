# 1 Company with 5 successful charges

company = Company.create("name"=>"Morar-Champlin", "zip_code"=>"66407")
[67.01, 36.49, 32.37, 20.98, 52.82].each do |amount|
  company.charges.create(amount: amount)
end

# 1 Company with 3 successful charges and 1 disputed charge and 1 failed charge
company = Company.create("name"=>"Kiehn-Dibbert", "zip_code"=>"28944")
[39.89, 35.77, 68.88].each do |amount|
  company.charges.create(amount: amount)
end
company.charges.create("amount"=>87.06, "paid"=>true, "refunded"=>true)
company.charges.create("amount"=>81.24, "paid"=>false)

# 5 Users with 1 successful charge each
[
  [ "Brandi",   "Cole",    34.12 ],
  [ "Dahlia",   "Boyle",   13.00 ],
  [ "Mike",     "Bernier", 14.30 ],
  [ "Keyshawn", "Feeney",  24.24 ],
  [ "Abbey",    "Durgan",  89.88 ]
].each do |f, l, a|
  user = User.create(first_name: f, last_name: l)
  user.charges.create(amount: a)
end

# 1 User with 2 disputed charges and 1 failed charge
user = User.create(first_name: "Onie", last_name: "Nitzsche")
[488.23, 99.23].each do |amount|
  user.charges.create(amount: amount, paid: true, refunded: true)
end
user.charges.create(amount: 77.00, paid: false)

# 1 User with 3 failed charges
user = User.create(first_name: "Bulah", last_name: "Schamberger")
[11.12, 32.67, 55.35].each do |amount|
  user.charges.create(amount: amount, paid: false)
end
