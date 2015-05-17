function [ N ] = surf_countpoints( a, b )
%SURF_COUNTPOINTS Summary of this function goes here
%   Detailed explanation goes here

    points1 = detectSURFFeatures(a);
    points2 = detectSURFFeatures(b);

    f1 = extractFeatures(a, points1);
    f2 = extractFeatures(b, points2);

    indexPairs = matchFeatures(f1, f2);
    
    N = length(indexPairs);
end

