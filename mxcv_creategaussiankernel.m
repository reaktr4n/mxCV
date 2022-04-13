function gaussian_kernel=mxcv_creategaussiankernel (sigma_value)
    % gaussian_kernel=mxcv_creategaussiankernel (sigma_value) 
    % Function that generates a low pass Gaussian mask with standard deviation sigma_value 
    % and size (2*sigma_value+1)x(2*sigma_value+1), a square matrix. The gaussian kernel 
    % "gaussian_kernel" is used for image convolution to achieve image smoothing. 
    % Constraints: sigma_value needs to be of integer value > 0.
    % Arguments
    % * sigma_value - value of standard deviation. The degree of smoothing is 
    % determined by sigma_value
    
    if (isa (sigma_value, 'double') && (sigma_value < 0))
        %disp ('Case 2')
        disp ('---------------------------------------------------------')
        disp ('Error: In function "mxcv_generategaussian"')
        disp ('Error: Input argument sigma_value needs to be of positive')
        disp ('integer value greater than zero.')
        disp ('Returning a null matrix. ')
        gaussian_kernel = 0;
        disp ('---------------------------------------------------------')
    end
   
     if (isa (sigma_value, 'double') && (sigma_value > 0))
        %disp (ne (isa (sigma_value, 'double'), 0))
        % round off to -ve infinity
        sigma_value = floor (sigma_value);
    end
    
    % decide the mask size
    mask_size=(2*sigma_value)+1;
    origin_middle = -floor(mask_size/2) : floor(mask_size/2);
    
    % generate a mesh
    [u,v] = meshgrid (origin_middle, origin_middle);
    
    % creating gaussian mask
    gaussian_kernel = exp(-(u.^2 + v.^2) / (2*sigma_value*sigma_value));
    gaussian_kernel = gaussian_kernel / sum(gaussian_kernel(:));
    
end