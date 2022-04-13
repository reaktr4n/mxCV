function corner_detected_image = mxcv_cornerdetection_szeliski (input_image,...
                                                                threshold_value,...
                                                                window_width)
% corner_detected_image = mxcv_cornerdetection_szeliski (input_image,...
%                                                        threshold_value,...
%                                                        window_width)
% A simple function to detect corner features in an input image input_image.
% Arguments
% * input_image - A gray-valued input image.
% * threshold_value - Value for considering a certain interest point that can be a potenti-
% -al corner point. The threshold value is compared to compute the local maxima in a windo-
% -w function.
% * threshold_value - Threshold value on corner response value. Governs the number of
% corner responses in the resultant image.
% * window_width - Width of the window function to compute the shift in intensity values.
% NOTE: The image gradient is computed using sobel kernels.

if isa (input_image, 'double') && ndims (input_image) == 2
    if window_width > 0
        image_rows = size (input_image, 1);
        image_cols = size (input_image, 2);
        window_width = floor (window_width);
        gradient_kernel = mxcv_createsobelkernel ();
        kernel_x = gradient_kernel (:,:,1);
        kernel_y = gradient_kernel (:,:,2);
        image_x = mxcv_imageconvolution2D_shape_shifted (input_image, kernel_x);
        image_y = mxcv_imageconvolution2D_shape_shifted (input_image, kernel_y);
        image_x_sq = image_x.*image_x;
        image_y_sq = image_y.*image_y;
        image_x_y = image_x.*image_y;
        % intensity shifted with a Gaussian kernel window
        shifted_image_x_sq = mxcv_imagegaussianblur_shape_shifted (image_x_sq,...
                                                                            window_width);
        shifted_image_y_sq = mxcv_imagegaussianblur_shape_shifted (image_y_sq,...
                                                                            window_width);
        shifted_image_x_y = mxcv_imagegaussianblur_shape_shifted (image_x_y,...
                                                                            window_width);
        for i=1:image_rows
            for j=1:image_cols
                M = [shifted_image_x_sq(i, j), shifted_image_x_y(i, j);...
                                       shifted_image_x_y(i, j), shifted_image_y_sq(i, j)];
                eigen_values = eig (M);
                % TODO 21
                lambda_1 = eigen_values (1);
                lambda_2 = eigen_values (2);
                determinant_value = lambda_1*lambda_2;
                trace_value = lambda_1+lambda_2;
                r_value = determinant_value/trace_value;
                if r_value > threshold_value
                    input_image (i, j) = 255;
                else
                    input_image (i,j) = input_image (i,j);
                end
            end
        end
        corner_detected_image = input_image;
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_cornerdetection_szeliski')
        disp ('Error: The input argument window_width must be a non-zero value. ')
        disp ('~ value of window_width: ')
        disp (window_width)
        disp ('----------------------------------------------------------------------------')
        corner_detected_image = double(0);
    end
else
    disp ('----------------------------------------------------------------------------')
    disp ('Error: In function mxcv_cornerdetection_szeliski')
    disp ('Error: The input argument input_image must be a grayscale image of class')
    disp ('double.')
    disp ('~ found class')
    disp (class (input_image))
    disp ('~ found dimensions')
    disp (ndims (input_image))
    disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
    disp ('----------------------------------------------------------------------------')
    corner_detected_image = double(0);
end