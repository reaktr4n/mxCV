function gaussian_blurred_image = mxcv_imagegaussianblur (input_image, sigma_value, ...
                                                          border_treatment)

% gaussian_blurred_image = mxcv_imagegaussianblur (input_image, sigma_value, ...
%                                                                        border_treatment)
% Function to apply Gaussian blur/smoothing to noisy images. 
% Arguments
% * input_image - A grayscale input image.
% A grayscale image of ndims(input_image) = 2. 
% * sigma_value - The standard deviation of the Gaussian distribution.
% sigma_value is an integer value, and builds a kernel/mask of size 
% (2*sigma_value+1)x(2*sigma_value+1).
% * border_treatment - One of the border treatment method - zeros, mirror or clamp. The
% convolution kernel extends beyond the image boundaries. To rectify this boundary
% effect, border_treatment argument is used.
% border_treatment is used in mxcv_imageconvolution2D function, which is used implicitly.
% Returns gaussian blurred image.

if ndims (input_image) == 2
    gaussian_kernel = mxcv_creategaussiankernel (sigma_value);
    gaussian_blurred_image = mxcv_imageconvolution2D (input_image, gaussian_kernel, ...
                                    border_treatment);    
else
   disp ('----------------------------------------------------------------------------')
   disp ('Error: In function mxcv_imagegaussianblur')
   disp ('Error: The input argument input_image should be a grayscale image.')
   disp ('~ found dimensions')
   disp (ndims (input_image))
   disp ('----------------------------------------------------------------------------')
   guassian_blurred_image = double(0);
end
end