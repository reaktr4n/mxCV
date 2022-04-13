function sobel_kernel = mxcv_createsobelkernel ()
% sobel_kernel = mxcv_createsobelkernel ()
% Function to return a sobel kernel for image 
% filtering. Returns sobel_kernel, which contains kernels for x and y
% directions respectively.
% https://homepages.inf.ed.ac.uk/rbf/HIPR2/sobel.htm

sobel_x = [-1, 0, 1;-2, 0, 2;-1, 0, 1];
sobel_y = rot90 (rot90 (rot90 (sobel_x)));

sobel_kernel (:,:,1) = sobel_x;
sobel_kernel (:,:,2) = sobel_y;
sobel_kernel = double (sobel_kernel);