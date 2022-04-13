function gaussian_blurred_image = mxcv_imagegaussianblur_shape_shifted (input_image, ...
                                                                              sigma_value)
% gaussian_blurred_image = mxcv_imagegaussianblur_shape_shifted (input_image,...
%                                                                             sigma_value)
% Function to apply Gaussian blur/smoothing to noisy images. 
% Arguments
% * input_image - A grayscale input image.
% A grayscale image of ndims(input_image) = 2. 
% * sigma_value - The standard deviation of the Gaussian distribution. sigma_value is a 
% double value, and builds a kernel/mask of size (2*sigma_value+1)x(2*sigma_value+1).
% The sigma_value is assumed to have no fractional part. If the input involves a
% fractional part, it is dropped using the floor function.

if isa (input_image, 'double') && ndims (input_image) == 2
    if sigma_value > 0
        sigma_value = double(floor (sigma_value));
        gaussian_kernel = mxcv_creategaussiankernel (sigma_value);
        gaussian_blurred_image = mxcv_imageconvolution2D_shape_shifted (input_image, ... 
                                                                         gaussian_kernel);
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_imagegaussianblur_shape_shifted')
        disp ('Error: The input argument sigma_value must be a non-zero value. ')
        disp ('~ value of sigma_value: ')
        disp (sigma_value)
        disp ('----------------------------------------------------------------------------')
        gaussian_blurred_image = double(0);
    end
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_imagegaussianblur_shape_shifted')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    gaussian_blurred_image = double (0);
end
end
