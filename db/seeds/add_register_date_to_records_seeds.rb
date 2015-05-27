def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

records = Record.all # Record == Registro
#update all records for 'May' with an random day
records.each do |record|
  rnd_date_time = time_rand Time.local(2015, 5, 1), Time.local(2015, 5, 31)
  record.register_date = rnd_date_time.to_date
  record.save(validate:false)
end