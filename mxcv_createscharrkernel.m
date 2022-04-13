function scharr_kernel = mxcv_createscharrkernel ()
% scharr_kernel = mxcv_createscharrkernel ()
% Function to return a scharr kernel for 
% image filtering. Returns scharr_kernel, which contains kernels 
% for x and y directions respectively.
% http://www.hlevkin.com/articles/SobelScharrGradients5x5.pdf

scharr_x = [3, 0, -3;10, 0, -10;3, 0, -3];
scharr_y = rot90(rot90(rot90(scharr_x)));
scharr_kernel = scharr_y;
scharr_kernel (:,:,1) = scharr_x;
scharr_kernel (:,:,2) = scharr_y;
scharr_kernel = double (scharr_kernel);