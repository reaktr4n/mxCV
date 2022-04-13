function prewitt_gradient_image = mxcv_imagegradient_prewitt (input_image)
% prewitt_gradient_image = mxcv_imagegradient_prewitt (input_image)
% Function to compute the image gradient using the Prewitt image mask.
% Arguments
% * input_image - A gray-valued input image.
% Returns magnitude and direction images.
% NOTE: The Prewitt masks are convolutioned with input_image. 

if isa (input_image, 'double') && ndims (input_image) == 2
    prewitt_kernel = mxcv_createprewittkernel ();
    prewitt_x = prewitt_kernel (:,:,1);
    prewitt_y = prewitt_kernel (:,:,2);
    
    prewitt_gradient_x = mxcv_imageconvolution2D_shape_shifted (input_image, prewitt_x);
    prewitt_gradient_y = mxcv_imageconvolution2D_shape_shifted (input_image, prewitt_y);
    prewitt_magnitude_image = sqrt (abs (prewitt_gradient_x) + abs (prewitt_gradient_y));
    prewitt_direction_image = atand (prewitt_gradient_y./prewitt_gradient_x);
    prewitt_direction_image (isnan (prewitt_direction_image)) = 0;
    prewitt_gradient_image (:, :, 1) = prewitt_magnitude_image;
    prewitt_gradient_image (:, :, 2) = prewitt_direction_image;
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_imagegradient_prewitt')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    prewitt_gradient_image (:,:,1) = double(0);
    prewitt_gradient_image (:,:,2) = double(0);
end
end