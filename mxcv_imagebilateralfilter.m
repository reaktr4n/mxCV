function bilteral_filtered_image = mxcv_imagebilateralfilter (input_image, sigma_spatial, ...
                                                            sigma_range, border_treatment)
   % bilteral_filtered_image = mxcv_imagebilateralfilter (input_image, sigma_spatial, ...
   %                                                       sigma_range, border_treatment)
   % Function to perform bilateral filtering on input image.
   % Arguments
   % * input_image - A gray-valued input image.
   % * sigma_spatial - Spatial parameter, equivalent of standard deviation parameter in a 
   % gaussian blurring operation. Builds a spatial kernel of size 
   % (2*sigma_spatial+1)x(2*sigma_spatial+1).
   % * sigma_range - Range parameter, provided to a kernel that penalizes pixel values that
   % are not too similar to the central pixel value in the image. The size of the range
   % kernel is the same as that of the spatial kernel.
   % * border_treatment - One of the border treatment method - zeros, mirror or clamp. The
   % convolution kernel extends beyond the image boundaries. To rectify this boundary
   % effect, border_treatment argument is used.
   % Returns a bilateral filtered image
   
   if isa (input_image, 'double') && ndims (input_image) == 2
       spatial_kernel = mxcv_creategaussiankernel(sigma_spatial);
       mask_size = [2*sigma_spatial+1, 2*sigma_spatial+1];
       switch border_treatment
           case {'zeros','Zeros'}
               input_image = mxcv_imagepadding_zeros (input_image, mask_size);
           case {'mirror','Mirror'}
               input_image = mxcv_imagepadding_mirror (input_image, mask_size);
           case {'clamp','Clamp'}
               input_image = mxcv_imagepadding_clamp (input_image, mask_size);
           otherwise
               warning('Unexpected border treatment input. Using zero padding instead.')
               input_image = mxcv_imagepadding_zeros (input_image, kernel_size);
       end
       % compute the size of the image
       nr_rows = size (input_image, 1);
       nr_cols = size (input_image, 2);
       
       % compute offset of the row and column
       offset_rows = floor (size (spatial_kernel, 1)/2);
       offset_cols = floor (size (spatial_kernel, 2)/2);
       
       % rotate the spatial kernel by 180
       spatial_kernel_rot_180 = mxcv_rot180 (spatial_kernel);
       mask_size_spatial = size (spatial_kernel_rot_180);
       
       % perform the convolution operation
       for i = (1+offset_rows):(nr_rows-offset_rows)
           for j = (1+offset_cols):(nr_cols-offset_cols)
               % obtain the sub-image same as the size of the spatial kernel
               sub_image = mxcv_getimagepixelneighborhood (input_image, i, j,...
                                                            mask_size_spatial);
               % obtain the central image pixel
               central_pixel = input_image (i, j);
               % build the range kernel, same size as the spatial kernel
               % range kernel is central_pixel value - rest of the pixel values
               % in the sub-image matrix, squared and every element 
               range_kernel = exp ((central_pixel-sub_image).^2/(2*sigma_range^2));
               weighted_bilateral_function = spatial_kernel.*range_kernel;
               bilateral_filter_normalization = sum (weighted_bilateral_function(:));
               input_image(i, j) = sum ( sum (weighted_bilateral_function.*sub_image, 1))/...
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
       bilteral_filtered_image = double(0);
       disp ('----------------------------------------------------------------------------')
   end
end