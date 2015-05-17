function [ errN, totErr ] = surf_dist( I1, I2, bestN )
%SURF_DIST Summary of this function goes here
%   Detailed explanation goes here

if nargin<3, bestN = 30; end

% Get the Key Points
  Options.upright=true;
  Options.tresh=0.0001;
  Ipts1=OpenSurf(I1,Options);
  Ipts2=OpenSurf(I2,Options);
  
% Put the landmark descriptors in a matrix
  D1 = reshape([Ipts1.descriptor],64,[]); 
  D2 = reshape([Ipts2.descriptor],64,[]); 
  
% Find the best matches
  err=zeros(1,length(Ipts1));
  cor2=zeros(1,length(Ipts1));
  
  for i=1:length(Ipts1),
      distance = sum((D2-repmat(D1(:,i),[1 length(Ipts2)])).^2,1);
      [err(i), cor2(i)] = min(distance);
  end
  
  
  % Sort matches on vector distance
  err = sort(err);
  
  if (bestN > length(err))
      bestN = length(err);
  end
  
  errN = sum(err(1:bestN));
  totErr = sum(err);

end

