function rotated_180_matrix = mxcv_rot180 (input_matrix)
% rotated_180_matrix = mxcv_rot180 (input_matrix)
% Function that rotates an input matrix by 180 degrees.
% Arguments
% * input_matrix - Input array that needs to be rotated by 180 degrees. Input 
% matrix of size mxn. 
% Returns a 180 degrees rotated array.

    rotated_180_matrix=rot90(rot90(input_matrix));
    
end