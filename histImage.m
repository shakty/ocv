function[h] = histImage(img)
% This function calculates normalized histogram of image.
% Normalized histogram is histogram h, that has at
% each i place in it, value:
% (number of picture pixels with gray level i-1) / 
% (total num of pixels in picture).

sum = 0;

% Getting sizes of image.
[y,x] = size(img); 

% Creating output histogram array.
h = zeros(1,256);

% runing on rows and columns
for i = 1:1:y     
    for j = 1:1:x
        
        % Gray level is addtess to cell in output histogram array
        % We add there 1 (bacause of current pixel (y,x) has this gray level
        
        h(img(i,j)) = h(img(i,j)) + 1;
        % pay attention to fact, that we use here pixel value as index!
    end
end

h = h./(y*x);
end