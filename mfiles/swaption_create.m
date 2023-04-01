function swaption =swaption_create(strike, optiontype, expiry, start, tenor, freq, accr, libor)

swaption = struct('class', 'security', 'type', 'swaption', 'option', optiontype, 'strike', strike, ...
'expiry', expiry, 'swap', swap_create(start, tenor, freq, accr, libor));
