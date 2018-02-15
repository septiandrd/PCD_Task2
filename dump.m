img = imread('icon.png');

% ZOOM IN
% imsize = size(img);
% zoomR = [];
% zoomG = [];
% zoomB = [];
% 
% for i = 1:imsize(1)
%     r = [];
%     g = [];
%     b = [];
%     for j = 1:imsize(2)
%         r = [r img(i,j,1) img(i,j,1)];
%         g = [g img(i,j,2) img(i,j,2)];
%         b = [b img(i,j,3) img(i,j,3)];
%     end
%     zoomR = [zoomR;r;r];
%     zoomG = [zoomG;g;g];
%     zoomB = [zoomB;b;b];
% end 
% 
% zoomImg = cat(3,zoomR,zoomG,zoomB);
% % imshow(zoomImg(100:100,100:100,3));
% imshow(zoomImg((imsize(1)/2):(imsize(1)+imsize(1)/2),(imsize(2)/2):(imsize(2)+imsize(2)/2),:));

% ZOOM IN

% ZOOM OUT
imsize = size(img);
height = imsize(1);
width = imsize(2);
zoomR = [];
zoomG = [];
zoomB = [];
h = 1;

while h<=height
    r = [];
    g = [];
    b = [];
    w = 1;
    while w<=width
        r = [r round(mean(mean(img(h:h+1,w:w+1,1))))];
        g = [g round(mean(mean(img(h:h+1,w:w+1,2))))];
        b = [b round(mean(mean(img(h:h+1,w:w+1,3))))];
        w = w+2;
    end
    zoomR = [zoomR;r];
    zoomG = [zoomG;g];
    zoomB = [zoomB;b];
    h = h+2;
end
zoomImg = cat(3,zoomR,zoomG,zoomB);
zoomImg = uint8(zoomImg);
imshow(zoomImg);
% ZOOM OUT