function avg_filter = mxcv_createmeankernel (mask_size)
    % avg_filter = mxcv_createmeankernel (mask_size)
    % A simple function that returns a mask_size x
    % mask_size (square) matrix kernel that aides in image convolution.
    % Constraints:
    % mask_size needs to be of integer value > 0.
    % Arguments
    % * mask_size - shape and size of the neighborhood to be sampled when 
    % calculating the average [1].
    % Returns avg_filter, a square matrix of size "mask_size x mask_size"
    % [1] https://homepages.inf.ed.ac.uk/rbf/HIPR2/mean.htm
    
    if (isa (mask_size, 'double') && (mask_size < 0))
        disp ('---------------------------------------------------------')
        disp ('Error: In function mxcv_generateavgmask')
        disp ('Error: Input argument mask_size needs to be of positive')
        disp ('integer value greater than zero.')
        disp ('Returning a null matrix. ')
        disp ('---------------------------------------------------------')
        avg_filter = 0;
    end
    
    if (isa (mask_size, 'double') && (mask_size > 0))
        mask_size = floor(mask_size);
    end
    avg_filter=(ones(mask_size)./mask_size^2);
end