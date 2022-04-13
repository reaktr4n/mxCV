function bilteral_filtered_image = mxcv_imagebilateralfilter_shape_shifted (input_image, ...
                                                            sigma_spatial, sigma_range)
   % bilteral_filtered_image = mxcv_imagebilateralfilter_shape_shifted (input_image, ...
   %                                                           sigma_spatial, sigma_range)                                                         
   % Function to perform bilateral filtering on input image.
   % Arguments
   % * input_image - A gray-valued input image.
   % * sigma_spatial - Spatial parameter, equivalent of standard deviation parameter in a 
   % gaussian blurring operation. Builds a spatial kernel of size 
   % (2*sigma_spatial+1)x(2*sigma_spatial+1).
   % * sigma_range - Range parameter, provided to a kernel that penalizes pixel values that
   % are not too similar to the central pixel value in the image. The size of the range
   % kernel is the same as that of the spatial kernel.
   % NOTE: Uses the shape shifted image and kernel to perform bilateral fitlering.
   % Returns a bilateral filtered image
   
   if isa (input_image, 'double') && ndims (input_image) == 2
       
       spatial_kernel = mxcv_creategaussiankernel (sigma_spatial);       
       % compute the size of the image
       image_rows = size (input_image, 1);
       image_cols = size (input_image, 2);
       bilteral_filtered_image = zeros (image_rows, image_cols);
       % compute offset of the row and column
       padded_rows = floor (size (spatial_kernel, 1)/2);
       padded_cols = floor (size (spatial_kernel, 2)/2);
       
       % rotate the spatial kernel by 180
       spatial_kernel_rot_180 = mxcv_rot180 (spatial_kernel);
       mask_rows = size (spatial_kernel, 1);
       mask_cols = size (spatial_kernel, 2);
       
       % perform the convolution operation
       for i = 1:image_rows
           for j = 1:image_cols
               p_1 = (i - padded_rows)+((abs (i - padded_rows) + 1)*...
                                                                      (i <= padded_rows));
               p_2 = (i + padded_rows) - (((i + padded_rows) > image_rows)*...
                                                   (abs((i + padded_rows) - image_rows)));
               q_1 = (j - padded_cols)+((abs (j - padded_cols) + 1)*...
                                                                      (j <= padded_cols));         
               q_2 = (j + padded_cols) - (((j + padded_cols) > image_cols)*...
                                                   (abs((j + padded_cols) - image_cols)));
               j_1 = ((i > padded_rows) * 1)+((i <= padded_rows)*...
                                                                     ((padded_rows-i)+2));
               j_2 = mask_rows - (((i+padded_rows)>image_rows)*...
                                                      (abs ((i+padded_rows)-image_rows)));
               k_1 = ((j > padded_cols) * 1)+((j <= padded_cols)*...
                                                                   ((padded_cols-j) + 2));
               k_2 = mask_cols - (((j + padded_cols) > image_cols)*...
                                                  (abs ((j + padded_cols) - image_cols)));
               sub_image = input_image (p_1:p_2, q_1:q_2);
               sub_kernel = spatial_kernel_rot_180 (j_1:j_2, k_1:k_2);
               
               % obtain the central image pixel
               central_pixel = input_image (i, j);
               % build the range kernel, same size as the spatial kernel
               % range kernel is central_pixel value - rest of the pixel values
               % in the sub-image matrix, squared and every element 
               range_kernel = exp ((central_pixel-sub_image).^2/(2*sigma_range^2));
               weighted_bilateral_function = sub_kernel.*range_kernel;
               bilateral_filter_normalization = sum (weighted_bilateral_function(:));
               bilteral_filtered_image (i, j) =...
                                sum ( sum (weighted_bilateral_function.*sub_image, 1))/...
                                                           bilateral_filter_normalization;
           end
       end
       bilteral_filtered_image = input_image;
   else
       disp ('----------------------------------------------------------------------------')
       disp ('Error: In function mxcv_imagebilateralfilter')
       disp ('Error: The input argument input_image must be a grayscale image of class')
       disp ('double.')
       disp ('~ found class')
       disp (class (input_image))
       disp ('~ found dimensions')
       disp (ndims (input_image))
       disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
       disp ('----------------------------------------------------------------------------')
       bilteral_filtered_image = double(0);
   end
end