function [x,y,z,xm,ym,zm,U,V,W,nu_t] = read_field(fin)

  fid = fopen(fin,'r','b');

  n   = fread(fid,1,'int32','ieee-le');
  x   = fread(fid,n,'float64','ieee-le');

  n   = fread(fid,1,'int32','ieee-le');
  y   = fread(fid,n,'float64','ieee-le');

  n   = fread(fid,1,'int32','ieee-le');
  z   = fread(fid,n,'float64','ieee-le');

  n   = fread(fid,1,'int32','ieee-le');
  xm  = fread(fid,n,'float64','ieee-le');

  n   = fread(fid,1,'int32','ieee-le'); 
  ym  = fread(fid,n,'float64','ieee-le');

  n   = fread(fid,1,'int32','ieee-le');
  zm  = fread(fid,n,'float64','ieee-le');
  
  n   = fread(fid,3,'int32','ieee-le');
  U   = fread(fid,n(1)*n(2)*n(3),'float64','ieee-le');
  U   = reshape(U,n(1),n(2),n(3));

  n   = fread(fid,3,'int32','ieee-le');
  V   = fread(fid,n(1)*n(2)*n(3),'float64','ieee-le');
  V   = reshape(V,n(1),n(2),n(3));

  n   = fread(fid,3,'int32','ieee-le');
  W   = fread(fid,n(1)*n(2)*n(3),'float64','ieee-le');
  W   = reshape(W,n(1),n(2),n(3));		       

  n    = fread(fid,3,'int32','ieee-le');
  nu_t = fread(fid,n(1)*n(2)*n(3),'float64','ieee-le');
  nu_t = squeeze(reshape(nu_t,n(1),n(2),n(3)));

  fclose(fid);

end