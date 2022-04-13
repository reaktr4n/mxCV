function scharr_gradient_image = mxcv_imagegradient_scharr (input_image)
% scharr_gradient_image = mxcv_imagegradient_scharr (input_image)
% Function to compute the image gradient using the Scharr image mask.
% Arguments
% * input_image - A gray-valued input image.
% Returns magnitude and direction images.
% NOTE: The Scharr masks are convolutioned with input_image. 

if isa (input_image, 'double') && ndims (input_image) == 2
    scharr_kernel = mxcv_createscharrkernel ();
    scharr_x = scharr_kernel (:,:,1);
    scharr_y = scharr_kernel (:,:,2);
    
    scharr_gradient_x = mxcv_imageconvolution2D_shape_shifted (input_image, scharr_x);
    scharr_gradient_y = mxcv_imageconvolution2D_shape_shifted (input_image, scharr_y);
    scharr_magnitude_image = sqrt (abs (scharr_gradient_x) + abs (scharr_gradient_y));
    scharr_direction_image = atand (scharr_gradient_y./scharr_gradient_x);
    scharr_direction_image (isnan (scharr_direction_image)) = 0;
    scharr_gradient_image (:, :, 1) = scharr_magnitude_image;
    scharr_gradient_image (:, :, 2) = scharr_direction_image;
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_imagegradient_scharr')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    scharr_gradient_image (:,:,1) = double(0);
    scharr_gradient_image (:,:,2) = double(0);
end
end