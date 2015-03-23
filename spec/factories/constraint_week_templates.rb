FactoryGirl.define do
  factory :constraint_week_template do
    max_lookahead_for_reh 1
max_lookahead_for_perf 1
release_unbooked_perf_lookahead 1
active_starting "2015-03-23"
monday nil
tuesday nil
wednesday nil
thursday nil
friday nil
saturday nil
sunday nil
  end

end
