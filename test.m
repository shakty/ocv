path(path,'util/'); % Help functions

a = imread('imgs/com_rand_4_feb_2013/02_10.pgm'); %reading images as array to variable 'a' & 'b'. 
b = imread('imgs/com_rand_4_feb_2013/02_14.pgm');

c = xcorr2(double(a),double(b));          %finding the correlation btwn two images 

 
ssim(b,a)


K = [0.05 0.05];
window = ones(8);
L = 100;
[mssim, ssim_map] = ssim(a, b, K, window, L);


mssim                        %Gives the mssim value
imshow(max(0, ssim_map).^4)  %Shows the ssim index map

% img = [];     % some 2d grayscale image
% pts = detectSURFFeatures(img, 'MetricThreshold',200, ...
%       'NumOctaves',3, 'NumScaleLevels',4);

I = imread('pout.tif');
I = imread('A.pgm');
J = medfilt2(I);
R = corr2(I,J) 


surf_dist(a,b,30)

%



ssim_index(a,b)



h1 = histImage(a);
h2 = histImage(b);

hcompare_EMD(h1,h2)
%patDistMAp(h1,h2)

imshow(b)

detectSURFFeatures(a, 'MetricThreshold',200, ...
       'NumOctaves',3, 'NumScaleLevels',4)


points1 = detectSURFFeatures(a);
points2 = detectSURFFeatures(b);


points1 = detectSURFFeatures(a, 'MetricThreshold',200, ...
       'NumOctaves',3, 'NumScaleLevels',4);

points2 = detectSURFFeatures(b, 'MetricThreshold',200, ...
       'NumOctaves',3, 'NumScaleLevels',4);

[f1, vpts1] = extractFeatures(a, points1);
[f2, vpts2] = extractFeatures(b, points2);

indexPairs = matchFeatures(f1, f2);

matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

% figure; ax = axes;
% showMatchedFeatures(a,b,matchedPoints1,matchedPoints2,'Parent',ax);

cvexShowMatches(a,b,matchedPoints1,matchedPoints2);

% legend(ax,'Matched points 1','Matched points 2')




   


   
   
%%
c = imread('imgs/02_10.png'); %reading images as array to variable 'a' & 'b'.
d = imread('imgs/02_14.png');
d = imrotate(c,5,'bicubic','crop');
imgshowpair(c,d);
%%