function pixel_neighbors = mxcv_getimagepixelneighborhood (input_image,...
                                                        r_i,...
                                                        c_i,...
                                                        mask_size)
    % pixel_neighbors = mxcv_getimagepixelneighborhood (input_image,...
    %                                                   r_i,...
    %                                                   c_i,...
    %                                                   mask_size)
    % Function that extracts neighborin
    % -g pixels in the vicinity of the central pixel.
    % Constraints: Always, size (conv_mask_array) < size (im_array)
    % Arguments
    % * input_image - A gray-valued input image
    % * r_i,c_i - pixel position in the image.
    % * mask_size - Size of convolution kernel passed as a 1x2 array.
    % Returns a sub-array of neighboring pixels in the vicinity of central
    % pixels at (r_i, c_i)
    
    if (mask_size (1) > size (input_image, 1)) || (mask_size (2) > size (input_image, 2))
        disp ('---------------------------------------------------------')
        disp ('Error: In function mxcv_getpixelneighborhood')
        disp ('Error: Size of the input argument mask_size should ')
        disp ('be less than the size of the input argument input_image.')
        disp ('~ size of mask_size: ')
        disp (size (mask_size))
        disp ('~ size of im_array: ')
        disp (size (input_image))
        disp ('Assigning a null matrix')
        pixel_neighbors = 0;
        disp ('---------------------------------------------------------')
    else
        s_r_i = r_i-floor(mask_size (1)/2); % start row index
        e_r_i = r_i+floor(mask_size (1)/2); % end row index
        s_c_i = c_i-floor(mask_size (2)/2); % start col index
        e_c_i = c_i+floor(mask_size (2)/2); % end col index
        pixel_neighbors = input_image(s_r_i:e_r_i, s_c_i:e_c_i);
    end
end