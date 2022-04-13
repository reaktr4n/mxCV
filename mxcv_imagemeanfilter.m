function mean_blurred_image = mxcv_imagemeanfilter (input_image, mean_width)
% mean_blurred_image = mxcv_imagemeanfilter (input_image, mean_width)                                                                            
% Function to apply Gaussian blur/smoothing to noisy images. 
% Arguments
% * input_image - A grayscale input image.
% A grayscale image of ndims(input_image) = 2. 
% * average_width - The standard deviation of the Gaussian distribution. sigma_value is a 
% double value, and builds a kernel/mask of size (2*mean_width+1)x(2*mean_width+1).
% The mean_width is assumed to have no fractional part. If the input involves a
% fractional part, it is dropped using the floor function.
% NOTE: The image convolution does not consider any image border treatment. It uses the
% shape-shifting image/kernels.

if isa (input_image, 'double') && ndims (input_image) == 2
    if mean_width > 0
        mean_width = double(floor (mean_width));
        mean_size = (2*mean_width)+1;
        mean_kernel = mxcv_createmeankernel (mean_size);
        mean_blurred_image = mxcv_imageconvolution2D_shape_shifted (input_image, ... 
                                                                             mean_kernel);
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_imagemeanfilter')
        disp ('Error: The input argument sigma_value must be a non-zero value. ')
        disp ('~ value of sigma_value: ')
        disp (mean_width)
        disp ('----------------------------------------------------------------------------')
        mean_blurred_image = double(0);
    end
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_imagemeanfilter')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    mean_blurred_image = double (0);
end
end
