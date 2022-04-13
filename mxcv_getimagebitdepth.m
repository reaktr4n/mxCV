function [bit_depth] = mxcv_getimbitdepth( im_array )
% [bit_depth] = mxcv_getimbitdepth( im_array )
% Function that returns the class type of the image array. The image_array is returned fro-
% -m the Matlab imread function. Use this enumeration to know the bit depth of the image.
% Arguments
% * im_array - image array as the input
% Returns an integer denoting the bit depth of the image

im_class = class (im_array);

switch im_class
    case 'uint8'
        bit_depth = 8;
    case 'uint16'
        bit_depth = 16;
    case 'uint32'
        bit_depth = 32;
    case 'uint64'
        bit_depth = 64;
    case 'double'
        bit_depth = 64;
    case 'single'
        bit_depth = 32;
end

end

