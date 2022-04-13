function upscaledImage=mxcv_imageupscale(imageInput,scale)
% upscaledImage=imupscale(imageInput,scale)
% If the size of the input image "imageInput" is mxn, then the above 
% function returns an upscaled image which is of size 
% (m*scale)x(n*scale).
% Arguments
% * imageInput = grayscale input image
% * scale = number of columns and rows by which the image has to be expanded. scale is 
% a non-zero and negative number.
% Returns an upscaled image upscaledImage
    
    % scaled row and column count
    sr=size(imageInput,1)*scale;
    sc=size(imageInput,2)*scale;
    % fill in zeros, mostly viewed as holes in the image
    holes=zeros(sr,sc);
    % offset row and column counter
    cr=0;
    cc=0;
    % adjust scale to fill in the value every scale-1 position
    scale=scale-1;
    % start upscaling by filling zeros
    for i=1:size(imageInput,1)
        for j=1:size(imageInput,2)
            holes((cr+i),(cc+j))=imageInput(i,j);
            cc=cc+scale;
        end
        cc=0;
        cr=cr+scale;
    end
    % cut the right edge and bottom edge, as they are mere zeros
    newRow=size(holes,1)-1;
    newColumn=size(holes,2)-1;
    upscaledImage=holes(1:newRow,1:newColumn);
    % todo: bilinear interpolation
    % figure out a way to do this
%     upscaledImage=holes;
end