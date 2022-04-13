function [ otsu_tau, sep_measure ] = mxcv_otsuthreshold (im_array)
% [ otsu_tau, sep_measure ] = mxcv_otsuthreshold (im_array)
% Function that computes an adaptive threshold otsu_tau by means of Otsu thresholding meth-
% -od [1][2] on the image array im_array. The function also computes the separability meas-
% -ure sep_measure to quantify the quality of the separation for otsu_tau.
% Arguments
% * im_array - graylevel image_array from imread function
% Returns an adaptive threshold level otsu_tau and separability measure
% sep_measure.
%
% [1] Otsu N. A Threshold Selection Method from Gray-Level Histograms. 
% IEEE Transactions on Systems, Man and Cybernetics. 1979;9 (1) :62-66.
% [2] Jianzhuang L., Wenqing L., Yupeng T. Automatic thresholding of 
% gray-level pictures using two-dimension Otsu method. International 
% Conference on Circuits and Systems, 1991. Conference Proceedings, China.,
% 1991, DOI: 10.1109/CICCAS.1991.184351


end

