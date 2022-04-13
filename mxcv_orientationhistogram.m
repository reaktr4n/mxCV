function dir_histogram = mxcv_orientationhistogram (dir_matrix,...
                                                      range,...
                                                      num_of_bins)
% dir_histogram = mxcv_orientationhistogram (dir_matrix,...
%                                             range,...
%                                             num_of_bins)
% Function that computes the histogram of a resultant direction matrix (computed when find-
% -ing the image gradient). Given a direction matrix, the function computes a histogram 
% based on direction spread over 0 to 180 degrees or 0 to 360 degrees. The directions are 
% binned depending on the input num_of_bins. The output dir_histogram is an associated vec-
% -tor consisting of direction values dirValues and the number of pixel values that fall 
% into a particular direction dirValues. A viewer will be able to judge the entire 
% directional distribution.

    
    % construct a consensus board
    con_board = mxcv_voteboard (range, num_of_bins);
    
    % compute the size of the directionMatrix
    n_r = size (dir_matrix, 1);
    n_c = size (dir_matrix, 2);
    
    for ix = 1:n_r
        for iy = 1:n_c
                [min_diff, array_pos] =...
                                    min(abs(con_board-dir_matrix(ix,iy)));
                con_board(array_pos(1),2) =... 
                                        con_board(array_pos(1),2)+1;
        end
    end
    
    dir_histogram=con_board;
end