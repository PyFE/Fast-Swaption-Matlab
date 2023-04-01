function model = lgm_create(nfac, vol_ts, mrv_ts, volratio, mrvspread, corr)

  
  %%%% processing
  if isscalar(vol_ts)     %isscalar(A) returns logical 1 (true) if A is a 1-by-1 matrix, and logical 0 (false) otherwise
    vol_ts = [0 vol_ts];
  end

  if isscalar(mrv_ts)
    mrv_ts = [0 mrv_ts];
  end

  if isscalar(corr)
    corr = [1 corr; corr 1];
  end

  volratio = [1 volratio(:)'];
  mrvspread = [0 mrvspread(:)'];

  %%%% merge time
  time = unique( sort( [vol_ts(:,1); mrv_ts(:,1)] ) );  

  vol = pwc_val( vol_ts(:,1), vol_ts(:,2), time );
  mrv = pwc_val( mrv_ts(:,1), mrv_ts(:,2), time );
  
  %%%% output
  model = struct();

  model.class = 'model:ts';
  model.type = 'LGM';
  model.nfac = nfac;

  model.time = time;
  model.vol = vol;
  model.mrv = mrv;
  model.volratio = volratio;
  model.mrvspread = mrvspread;
  model.corr = corr;
