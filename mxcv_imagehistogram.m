function [hist_vect] = mxcv_imagehistogram (im_array)
% [hist_vect] = mxcv_imagehistogram (im_array)
% Function that returns a vector of intensity distribution of a given image array 
% image_array.
% Arguments
% * im_array - A gray-valued input image.
% Constraints: 
% (1) The number of entries in the histogram is simply the number
% of intensity levels (L) in the image. Where L = 2^(bit-depth-image). 
% (2) To compute the bit-depth of the given image, mxcv_imhistogram uses 
% the mxcv_getimbitdepth function.
% Arguments
% im_array - graylevel image_array from imread function
% Returns a histogram vector, hist_vect
% Case (1): hist_vect is a 1xL vector in case of a grayscale iamge.
% Case (2): hist_vect is a 1xLx3 vector in case of a color image.

b_d = mxcv_getimbitdepth (im_array);

%disp (sz_v_r)

% max intensities in an image array give the bit depth
max = (2^b_d);

if (size (im_array, 3) == 1)
    % vectorize the image
    v_ia = im_array (:);
    % convert to 1 x #columns
    v_r = v_ia';
    % grayscale image
    % initialise a hist_vector of size max with 0s
    hist_vect = zeros (1, max);
    %size (im_array, 3)
    
    for i=1:size (v_r, 2)
        pix = v_r (i);
        hist_vect (pix+1) = hist_vect (pix+1) + 1;
    end
else
    % color image
    % initialise a hist_vector of size max with 0s
    hist_vect (:, :, 1) = zeros (1, max);
    hist_vect (:, :, 2) = zeros (1, max);
    hist_vect (:, :, 3) = zeros (1, max);
    
    % vector for each of the channels (r,g,b)
    r = im_array (:, :, 1);
    r = (r(:))'; % converts Lx1 to 1xL
    b = im_array (:, :, 2);
    b = (b(:))';
    g = im_array (:, :, 3);
    g = (g(:))';
    
    %size (r,2)
    %disp ('Color Image')
    
    for i = 1:size (r, 2)
        pix = r (:, i);
        hist_vect (:, pix+1, 1) = hist_vect (:, pix+1, 1) + 1;
    end
    
    for i = 1:size (g, 2)
        pix = g (:, i);
        hist_vect (:, pix+1, 3) = hist_vect (:, pix+1, 3) + 1;
    end
    
    for i = 1:size (b, 2)
        pix = b (:, i);
        hist_vect (:, pix+1, 2) = hist_vect (:, pix+1, 2) + 1;
    end

end
% TODO: binned histograms
% function [ hist_vect ] = mxcv_imhistogram (im_array, num_bins)