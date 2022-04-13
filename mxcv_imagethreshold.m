function [thresh_image] = mxcv_imagethreshold (im_array, tau)
% [thresh_image] = mxcv_imagethreshold (im_array, tau)
% Function to threshold images.
% Arguments
% * im_array - gray-scale image array from the imread Matlab function.
% * tau - threshold value within the range [0,1]
% Constraints: The function uses the mxcv_convert2grayscale internally. 
% Hence, the value of tau must lie within the range [0,1].
% Returns thresh_image, a binary image.

if nargin == 1
    disp 'mxcv_error todo: not enough input arguments. required 2,' 
    disp 'provided 1'
    disp 'setting the result to 0'
    thresh_image = 0;

elseif nargin == 2
    if (tau < 0) || (tau > 1)
        disp 'mxcv_error: tau value out of bounds. require: tau:= [0,1]'
        disp 'setting the result to 0'
        thresh_image = 0;
    else
        im_array = mxcv_convert2grayscale (im_array);
        thresh_image = (im_array >= tau);
    end
else
    disp 'mxcv_error todo: too many input arguments. required 2.'
    disp 'setting the result to 0'
    thresh_image = 0;
end
end