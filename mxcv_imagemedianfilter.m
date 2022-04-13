function median_filtered_image = mxcv_imagemedianfilter (input_image, mask_size)
% median_filtered_image = mxcv_imagemedianfilter (input_image, mask_size)
% Function that performs median filtering on the input image 
% input_image.
% Constraints: mask_width should be either int8 or int16 or int32 or int64.
% Implicit(s): The mask_width is used to build an empty kernel of size
% (2*mask_width+1)x(2*mask_width+1).
% Arguments
% * input_image - input grayscale image.
% * mask_size - It determines the number of pixels to be considered around 
% the central pixel. If the mask_size is n, a "2n+1 x 2n+1" matrix will be 
% considered around the central pixel.
% Returns median filtered image.
    if isa (input_image, 'double') && ndims (input_image) == 2
       if mask_size > 0
           kernel_size = [(2*mask_size)+1,(2*mask_size)+1];
           padded_rows = floor (kernel_size(1)/2);
           padded_cols = floor (kernel_size(2)/2);
           image_rows = size (input_image, 1);
           image_cols = size (input_image, 2);
           mask_rows = kernel_size (1); 
           mask_cols = kernel_size (2);
           median_filtered_image = zeros (image_rows, image_cols);
           for i=1:image_rows
               for j=1:image_cols
                   p_1 = (i - padded_rows)+((abs (i - padded_rows) + 1)*...
                                   (i <= padded_rows));
                   p_2 = (i + padded_rows) - (((i + padded_rows) > image_rows)*...
                                   (abs((i + padded_rows) - image_rows)));
                   q_1 = (j - padded_cols)+((abs (j - padded_cols) + 1)*...
                                   (j <= padded_cols));         
                   q_2 = (j + padded_cols) - (((j + padded_cols) > image_cols)*...
                                               (abs((j + padded_cols) - image_cols)));
                   sub_image = input_image (p_1:p_2, q_1:q_2);
                   median_filtered_image (i, j) = median( sort (sub_image (:)));
               end
           end
       else
           disp ('----------------------------------------------------------------------------')
           disp ('Error: In function mxcv_imagemedianfilter')
           disp ('Error: The input argument mask_size must be a non-zero value. ')
           disp ('~ value of mask_size: ')
           disp (mask_size)
           disp ('----------------------------------------------------------------------------')
           median_filtered_image = double(0);
       end
    else
       disp ('----------------------------------------------------------------------------')
       disp ('Error: In function mxcv_imagemedianfilter')
       disp ('Error: The input argument input_image must be a grayscale image of class')
       disp ('double.')
       disp ('~ found class')
       disp (class (input_image))
       disp ('~ found dimensions')
       disp (ndims (input_image))
       disp ('Grayscale images have 2 dimensions, instead of 3 or more.')
       disp ('----------------------------------------------------------------------------')
       median_filtered_image = double(0);
    end
    
end