function image_filepath = mxcv_fetchimage (image_filename)
    % image_filepath = mxcv_fetchimage (image_filename)
    % A simple function to fetch the full path for test images on a particular
    % terminal. The function uses the OS environment variable "IMAGEDS".
    % Arguments
    % * image_filename - Input image filename passed as a string.
    % NOTE: 
    % (1) An environment variable IMAGEDS can be created on your Windows PC.
    % You can find out how to create and set a value to an environment variable 
    % here:
    % https://docs.microsoft.com/en-us/windows/win32/procthread/environment-variables
    % (2) To create an environment variable on a Linux terminal, you could sim-
    % -ply create the IMAGEDS environment in your .bashrc (if using bash), and
    % save it. To create an environment variable on Ubuntu (for instance), plea-
    % -se read:
    % https://help.ubuntu.com/community/EnvironmentVariables
    % (3) To know more about creating an image dataset-base, run the "init_mxcv.m"
    % script.
    
    if ispc
        slash_char = '\';
    else
        slash_char = '/';
    end
    
    if size (getenv ('IMAGEDS')) > 0
        IMAGEDS_LOCATION = getenv ('IMAGEDS');
        image_filepath = strcat (IMAGEDS_LOCATION, slash_char, 'image_all', slash_char, ...
                        image_filename);
    else
        disp ('----------------------------------------------------------------------------')
        disp ('Error: In function mxcv_fetchimage')
        disp ('Error: The environment variable IMAGEDS is not set on your terminal.')
        disp ('NOTE: type mxcv_fetchimage and hit F1 to see a detailed help section on thi-')
        disp ('-s function.')
        disp ('----------------------------------------------------------------------------')
        image_filepath = '';
    end
end