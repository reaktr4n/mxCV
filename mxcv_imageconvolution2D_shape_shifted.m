function convolutioned_image=mxcv_imageconvolution2D_shape_shifted(input_image, ...
                                                                       convolution_kernel)
   % convolutioned_image=mxcv_imageconvolution2D_shape_shifted(input_image, ...
   %                                                                   convolution_kernel)
   % Function that performs convolution of a grayscale image with convolution 
   % kernel convolution_kernel.
   % Arguments
   % * input_image - A gray-valued input image.
   % The input image is padded image during the convolution process. 
   % * convolution_kernel - A convolution kernel of size MxM.
   % NOTE: The convolution operation implemented here do not require any padding. The
   % image kernel and the input image are shape shifted and reshaped depending on the
   % spatial arguments on the input image.
   % Returns a 2D convolutioned image.
   
   if isa (input_image, 'double') && ndims (input_image) == 2
       if size (convolution_kernel, 1) == size (convolution_kernel, 2) && ...
               size (convolution_kernel, 1) >= 2 && size (convolution_kernel, 2) >= 2
           mask_rows = size (convolution_kernel, 1);
           mask_cols = size (convolution_kernel, 2);
           padded_rows = floor (mask_rows/2);
           padded_cols = floor (mask_cols/2);
           convolution_kernel_180 = mxcv_rot180 (convolution_kernel);
           image_rows = size (input_image, 1);
           image_cols = size (input_image, 2);
           convolutioned_image = zeros (image_rows, image_cols);
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
                   
                   sub_conv_kernel = convolution_kernel_180 (j_1:j_2, k_1:k_2);
                   sub_image = input_image (p_1:p_2, q_1:q_2);
                   convolutioned_image (i, j) = sum ( sum (sub_conv_kernel.*sub_image, 1));        
               end
           end
       else
           disp ('----------------------------------------------------------------------------')
           disp ('Error: In function mxcv_imageconvolution2D_shape_shifted')
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
   else
       disp ('----------------------------------------------------------------------------')
       disp ('Error: In function mxcv_imageconvolution2D_shape_shifted')
       disp ('Error: The input argument input_image must be a grayscale image of class')
       disp ('double.')
       disp ('~ found class')
       disp (class (input_image))
       disp ('~ found dimensions')
       disp (ndims (input_image))
       disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
       disp ('----------------------------------------------------------------------------')
       convolutioned_image = double(0);
   end