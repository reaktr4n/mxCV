function upscaledImage=mxcv_imageupscale2(imageInput)
% upscaledImage = imup2scale(imageInput)
% If the size of the input image "imageInput" is mxn, then the above 
% function returns an upscaled image which is of size 
% (m*2)x(n*2).
% Arguments
% * imageInput = grayscale input image
% Returns an upscaled image upscaledImage
    
    scale=2;
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
%     newRow=size(holes,1)-1;
%     newColumn=size(holes,2)-1;
    
    % fill columns
    for i=1:2:size(holes,2)-2
        for j=2:2:size(holes,1)-2
            holes(j,i)=(holes(j-1,i)+holes(j+1,i))/2;
        end
    end
    
    % fill rows
    for i=1:2:size(holes,1)-1
        for j=2:2:size(holes,2)-1
            holes(i,j)=(holes(i,j-1)+holes(i,j+1))/2;
        end
    end

    % filling in-betweens
    for i=2:2:size(holes,1)-1
        for j=2:2:size(holes,2)-1
            holes(i,j)=(holes(i-1,j)+holes(i+1,j)+holes(i,j-1)+holes(i,j+1))/4;
        end
    end

    % fill the last row
    i=size(holes,1)-1;
    for j=2:2:size(holes,2)-1
        holes(i,j)=(holes(i-1,j)+holes(i+1,j)+holes(i,j-1)+holes(i,j+1))/2;
    end
    
    % fill the last column and prune the zero pixels
    j=size(holes,2)-1;
    for i=2:2:size(holes,1)-1
        holes(i,j)=(holes(i-1,j)+holes(i+1,j)+holes(i,j-1)+holes(i,j+1))/2;
    end
    % holes=holes(1:size(holes,1)-1,1:size(holes,2)-1);
    
    upscaledImage=holes;
end