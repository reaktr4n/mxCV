function padded_image = mxcv_imagepadding_clamp (input_image, mask_size)
    % padded_image = mxcv_imagepadding_clamp (input_image, mask_size)
    % Function that returns a replicated (boundary)padded image. This technique is also re-
    % -ferred to as clamping.
    % Arguments
    % * im_array - grayscale input image
    % * mask_size - A 1x2 array that contains the size of a kernel/mask. It determines the 
    % number of rows and columns to be padded on the image boundary.
    % Pads the image with floor(size (mask_size)/2) number of rows and 
    % floor(size (mask_size)/2) number of columns.
    % Returns a replicated (boundary) padded image array "padded_image"
    
    if size (mask_size,1) == 1 && size (mask_size,2) == 2
        if (mask_size > size (input_image))
            disp ('----------------------------------------------------------------------------')
            disp ('Error: In function mxcv_imagepadding_clamp')
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
            number_of_rows = size (input_image, 1);
            number_of_cols = size (input_image, 2);
        
            % Get the number of rows and columns to be padded
            rows_to_pad = floor (mask_size (1)/2);
            cols_to_pad = floor (mask_size (2)/2);

            % create padding to clamp
            padded_rows = input_image (1:rows_to_pad, 1:number_of_cols);
            padded_cols = input_image (1:number_of_rows, 1:cols_to_pad);

            % Concatenating zero paddings
            % Concatenating top padding and bottom padding
            top_bottom_padding = cat (1, padded_rows, input_image, padded_rows);
            left_right_padding = cat (1,...
                            input_image(1:rows_to_pad,1:cols_to_pad),...
                            padded_cols,input_image(1:rows_to_pad,1:cols_to_pad));
            final_padding = cat (2, left_right_padding, top_bottom_padding,...
                            left_right_padding);
            padded_image = double(final_padding);
        end
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_imagepadding_clamp')
        disp ('Error: Size of the input argument mask_array should ')
        disp ('be of size 1x2.')
        disp ('~ found size of mask_size: ')
        disp (size (mask_size))
        disp ('----------------------------------------------------------------------------')
        padded_image = double(0);
    end
end