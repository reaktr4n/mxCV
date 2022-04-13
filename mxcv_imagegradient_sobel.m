function sobel_gradient_image = mxcv_imagegradient_sobel (input_image)
% sobel_gradient_image = mxcv_imagegradient_sobel (input_image)
% Function to compute the image gradient using the Sobel image mask.
% Arguments
% * input_image - A gray-valued input image.
% Returns magnitude and direction images.
% NOTE: The Sobel masks are convolutioned with input_image. 

if isa (input_image, 'double') && ndims (input_image) == 2
    sobel_kernel = mxcv_createsobelkernel ();
    sobel_x = sobel_kernel (:,:,1);
    sobel_y = sobel_kernel (:,:,2);
    
    sobel_gradient_x = mxcv_imageconvolution2D_shape_shifted (input_image, sobel_x);
    sobel_gradient_y = mxcv_imageconvolution2D_shape_shifted (input_image, sobel_y);
    sobel_magnitude_image = sqrt (abs (sobel_gradient_x) + abs (sobel_gradient_y));
    sobel_direction_image = atand (sobel_gradient_y./sobel_gradient_x);
    sobel_direction_image (isnan (sobel_direction_image)) = 0;
    sobel_gradient_image (:, :, 1) = sobel_magnitude_image;
    sobel_gradient_image (:, :, 2) = sobel_direction_image;
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_imagegradient_sobel')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    sobel_gradient_image (:,:,1) = double(0);
    sobel_gradient_image (:,:,2) = double(0);
end
end