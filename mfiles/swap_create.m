function swap = swap_create(start, tenor, freq, accr, libor)

end_ = start+tenor;
schedule = [end_ : -freq : start]';
if (schedule(end) > start) 
   schedule = [schedule; start];
end

schedule = schedule(end:-1:1);
coverage = [0; diff(schedule)];    % day count fraction

swap = struct('start', start, 'tenor', tenor, 'freq', freq, 'accr', accr, ...
'libor', libor, 'end', end_, 'schedule', schedule, 'coverage', coverage);
