function prewitt_kernel = mxcv_createprewittkernel ()
% prewitt_kernel = mxcv_createprewittkernel ()
% Function to return a prewitt kernel for 
% image filtering. Returns prewitt_kernel, which contains kernels 
% for x and y directions respectively.
% http://www.hlevkin.com/articles/SobelScharrGradients5x5.pdf

prewitt_x = [1, 0, -1;1, 0, -1;1, 0, -1];
prewitt_y = rot90(rot90(rot90(prewitt_x)));
prewitt_kernel = prewitt_y;
prewitt_kernel (:,:,1) = prewitt_x;
prewitt_kernel (:,:,2) = prewitt_y;
prewitt_kernel = double (prewitt_kernel);