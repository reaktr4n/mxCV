function padded_image = mxcv_imagepadding_zeros (input_image, mask_size)
%
% A simple function that returns a zero (boundary)padded image. This techni-
% -que is also referred to as "zero-padding".
% Arguments
% * im_array - grayscale input image
% * mask_size - A 1x2 array that contains the size of a kernel/mask. It determines the numbe-
% -r of rows and columns to be padded on the image boundary.
% Pads the image with floor(size (mask_size)/2) number of rows and floor(size (mask_size)/2) 
% number of columns.
% Returns a zero (boundary) padded image array "padded_image"
    
    if size (mask_size,1) == 1 && size (mask_size,2) == 2
        if (mask_size > size (input_image))
            disp ('----------------------------------------------------------------------------')
            disp ('Error: In function mxcv_imagepadding_zeros')
            disp ('Error: The input argument mask_size contains mask size')
            disp ('greater than the size of the input argument input_image.')
            disp ('~ contents of mask_array: ')
            disp (mask_size)
            disp ('~ size of im_array: ')
            disp (size (input_image))
            disp ('Assigning a null matrix')
            padded_image = double(0);
            disp ('----------------------------------------------------------------------------')
        else
            % Get size of image
            number_of_cols = size (input_image, 2);
        
            % Get the number of rows and columns to be padded
            rows_to_pad = floor (mask_size (1)/2);
            cols_to_pad = floor (mask_size (2)/2);

            % create zero paddings
            padded_rows = zeros (rows_to_pad, number_of_cols);
            
            % Concatenating top padding and bottom padding
            top_bottom_padding = cat (1, padded_rows, input_image, padded_rows);
            padded_cols = zeros (size (top_bottom_padding, 1), cols_to_pad);
            left_right_padding = cat (2, padded_cols, top_bottom_padding, padded_cols);
            padded_image = double(left_right_padding);
        end
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_imagepadding_zeros')
        disp ('Error: Size of the input argument mask_array should ')
        disp ('be of size 1x2.')
        disp ('~ found size of mask_size: ')
        disp (size (mask_size))
        disp ('----------------------------------------------------------------------------')
        padded_image = double(0);
    end
end