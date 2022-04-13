function image_grayscale = mxcv_imageconverttograyscale (input_image)
% image_grayscale = mxcv_imageconverttograyscale (input_image)
% Function that converts an image array to grayscale image array of class type "double".
% Converts the image file filename in to double class, and converts the image into 
% grayscale.
% Constraints: input_image is an image array resultant from imread function.
% Use the imread function to read an image, and then pass the resultant
% image matrix to mxcv_imageconverttograyscale.
% Arguments
% * input_image  - image array from the imread Matlab function.
% Returns a grayscale image image_grayscale of class type "double".
    
    if size (input_image, 3) == 3
        % disp 'Not a Grayscale Image';
        image_grayscale = im2double (rgb2gray (input_image));
    else
        % disp 'Grayscale Image, nothing to do!';
        image_grayscale = input_image;
    end
end