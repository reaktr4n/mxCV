function padded_image = mxcv_imagepadding_mirror (input_image, mask_size)
% padded_image = mxcv_imagepadding_mirror (input_image, mask_size)
% Function that returns a mirror (boundary)padded image. This tech- 
% -nique is also referred to as mirroring.
% Arguments
% * im_array - grayscale input image
% * mask_size - A 1x2 array that contains the size of a kernel/mask. It determines the num-
% -ber of rows and columns to be padded on the image boundary. Pads the image with 
% floor(size (mask_size)/2) number of rows and "floor(size (mask_size)/2)" number of 
% columns.
% Returns a mirror (boundary) padded image array "padded_image"
    
    if size (mask_size,1) == 1 && size (mask_size,2) == 2
        if (mask_size > size (input_image))
            disp ('----------------------------------------------------------------------------')
            disp ('Error: In function mxcv_imagepadding_mirror')
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

            % create mirror padding top and bottom
            top_padding = input_image (1:rows_to_pad, 1:number_of_cols);
            bottom_padding = input_image ((number_of_rows-rows_to_pad)+1:number_of_rows,...
                             1:number_of_cols);
            % pad the bottom to the top and vice versa
            top_bottom_padding = cat (1, bottom_padding, input_image, top_padding);
            % create mirror padding left and right
            left_padding = top_bottom_padding (1:size (top_bottom_padding, 1),...
                           1:cols_to_pad);
            right_padding = top_bottom_padding (1:size (top_bottom_padding, 1),...
                           (number_of_cols-cols_to_pad)+1:size (top_bottom_padding, 2));
            % pad the left to the right and vice versa
            final_padding = cat (2, right_padding, top_bottom_padding,left_padding);
            padded_image = double(final_padding);
        end
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_imagepadding_mirror')
        disp ('Error: Size of the input argument mask_array should ')
        disp ('be of size 1x2.')
        disp ('~ found size of mask_size: ')
        disp (size (mask_size))
        disp ('----------------------------------------------------------------------------')
        padded_image = double(0);
    end
end