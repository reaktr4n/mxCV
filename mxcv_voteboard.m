function r_board = mxcv_voteboard (range, num_of_scores)
% r_board = mxcv_voteboard (range, num_of_scores)
% Function that returns a voting board/matrix of size num_of_scoresx2 where every entry i 
% in [0,range], r_board (i,1) is a fraction of range:num_of_scores. For example: 
% If 100 has to be divided into 10 scores of 10 each, then the function 
% call would be: r_board = voteboard(100,10); then r_board would look like this:
%------------
%|10  |   0 | 
%|20  |   0 |
%|30  |   0 |
%|40  |   0 |
%|50  |   0 |
%|60  |   0 |
%|70  |   0 |
%|80  |   0 |
%|90  |   0 |
%|100 |   0 |
%------------
% Arguments
% * range - Range of image pixel values
% * num_of_scores - Number of buckets to count the pixel values that fall in each of the
% bucket
% Typical use cases:
% num_of_scores can be thought of to be as number of bins that one desires
% in a histogram, and every bin consisting a fraction of 
% range/num_of_scores.
% Returns a voteboard of size "num_of_scores x 2 array"

t_sum=0;
    
r_board = zeros (num_of_scores, 2);
    
for i=1:num_of_scores
    bin_ratio = range/num_of_scores;
    t_sum = t_sum + bin_ratio;
    r_board (i, 1) = t_sum;
end

end