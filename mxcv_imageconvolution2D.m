function convolutioned_image=mxcv_imageconvolution2D(input_image, convolution_kernel, ...
                                                                         border_treatment)
   % convolutioned_image=mxcv_imageconvolution2D(input_image, convolution_kernel, ...
   %                                                                     border_treatment)
   % Function that performs convolution of padded grayscale image with convolutio-
   % -n kernel convolution_kernel.
   % Arguments
   % * input_image - A gray-valued input image.
   % The input image is padded image during the convolution process. 
   % * convolution_kernel - A convolution kernel of size MxM.
   % border_treatment - One of the border treatment method - zeros, mirror or clamp. The
   % * convolution kernel extends beyond the image boundaries. To rectify this boundary
   % effect, border_treatment argument is used.
   % Returns a 2D convolutioned image.
   if size (convolution_kernel, 1) == size (convolution_kernel, 2) &&...
           (size (convolution_kernel, 1) > 2 && size (convolution_kernel, 2) > 2)
       kernel_size = [size(convolution_kernel, 1), size(convolution_kernel, 2)];
       switch border_treatment
           case {'zeros','Zeros'} 
               input_image = mxcv_imagepadding_zeros (input_image, kernel_size);
           case {'mirror','Mirror'}
               input_image = mxcv_imagepadding_mirror (input_image, kernel_size);
           case {'clamp','Clamp'}
               input_image = mxcv_imagepadding_clamp (input_image, kernel_size);
           otherwise
               warning('Unexpected border treatment input. Using zero padding instead.')
               input_image = mxcv_imagepadding_zeros (input_image, kernel_size);
       end
       if isa (input_image, 'double') && ndims (input_image) == 2
           % compute the size of the image
           nr_rows = size (input_image, 1);
           nr_cols = size (input_image, 2);
    
           % compute offset of the row and column
           offset_rows = floor (size (convolution_kernel, 1)/2);
           offset_cols = floor (size (convolution_kernel, 2)/2);
    
           % rotate the convolution kernel by 180
           convolution_kernel_rot_180 = mxcv_rot180 (convolution_kernel);
    
           % perform the convolution operation
           for i = (1+offset_rows):(nr_rows-offset_rows)
               for j = (1+offset_cols):(nr_cols-offset_cols)
                   sub_image = mxcv_getimagepixelneighborhood (input_image, i, j, ...
                                                    kernel_size);
                   input_image(i, j) = sum ( sum (convolution_kernel_rot_180.*sub_image,...
                                       1));
               end
           end
           convolutioned_image = input_image;
       else
           disp ('Error: In function mxcv_imageconvolution2D')
           disp ('Error: The input argument input_image must be a grayscale image of class')
           disp ('double.')
           disp ('~ found class')
           disp (class (input_image))
           disp ('~ found dimensions')
           disp (ndims (input_image))
           disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
           convolutioned_image = double(0);
       end
   else
       disp ('----------------------------------------------------------------------------')
       disp ('Error: In function mxcv_imageconvolution2D')
       disp ('Error: The input argument convolution_kernel must be: ')
       disp ('Error: (1) non-empty, (2)two-dimensional, (3) square matrix and (4) size of')
       disp ('Error: convolution_kernel > 2')
       disp ('~ contents of convolution_kernel: ')
       disp (convolution_kernel)
       disp ('~ size of convolution_kernel: ')
       disp (size (convolution_kernel))
       disp ('~ dimension of convolution_kernel: ')
       disp (ndims (convolution_kernel))
       disp ('----------------------------------------------------------------------------')
       convolutioned_image = double(0);
   end
end