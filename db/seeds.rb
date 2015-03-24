# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cd_weekday = ConstraintDay.create( 
	avail_starting: '07:00', 
	avail_ending: '22:00', 
	name: 'standard weekday')

cd_fri_sat = ConstraintDay.create( 
	avail_starting: '07:00', 
	avail_ending: '23:59', 
	hold_for_perf_starts: '18:00', 
	hold_for_perf_ends: '23:59', 
	name: 'standard friday saturday')

cd_sun = ConstraintDay.create( 
	avail_starting: '09:00', 
	avail_ending: '21:00',  
	name: 'lazy sunday')

cd_avi_bday = ConstraintDay.create( 
	avail_starting: '07:00', 
	avail_ending: '21:00',  
	name: 'bday block whole', 
	block_whole_day: true, 
	special_hold_date: Date.new(2015,04,19) )

cwt = ConstraintWeekTemplate.create( 
	max_lookahead_for_reh: 90, 
	max_lookahead_for_perf: 120, 
	release_unbooked_perf_lookahead: 30, 
	monday: cd_weekday, 
	tuesday: cd_weekday, 
	wednesday: cd_weekday, 
	thursday: cd_weekday, 
	friday: cd_fri_sat, 
	saturday: cd_fri_sat, 
	sunday: cd_sun
)

p 'errors?'
p "#{cwt.errors.inspect}"

