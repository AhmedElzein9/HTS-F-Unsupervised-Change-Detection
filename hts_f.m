function [change,All_Errors]=hts_f(img1,img2,gt,sws)
%% img1 and img2 SAR images, gt is ground truth image, sws is Search Window Size for Non-local means filtering of imag

%% Convert double
img1=double(img1(:,:,1));
img2=double(img2(:,:,1));
gt=double(gt(:,:,1));
[r,c,d]=size(img1);
tic;
%% Logaritmic Transform
X1=log10((img1+1));
X2=log10((img2+1));
%% Non-local means filtering of image
   XF1=imnlmfilt(X1./std(X1(:)),'SearchWindowSize', sws);
   XF2=imnlmfilt(X2./std(X2(:)),'SearchWindowSize', sws);

    
%% Hyperbolic tangent sigmoid-based Difference function
     Diffe=(tansig((XF2-XF1+1)./(XF2+XF1+1)));

%% Appling 2D-Median Filter 
  Diffe_m=medfilt2(real(Diffe),[3 3],'symmetric');

%   figure, imshow(Diffe_m(:,:,1),[]),title('2D-Median Filtered Image'), colormap jet

%% RE-Padding
w=3; %windows size
k=2; % number of cluster
k0=3; % number of selected PCA columns
w0=(w-1)/2;
Diffe_m=padarray(Diffe_m,[w0 w0], 'symmetric');
d1=double( im2col( Diffe_m (:,:, 1), [w w], 'sliding')' );
[a,b]=pca(d1);

%% Clustering with Kmeans++
K=kmeans( b(:, 1:k0), k); change=reshape(K, r, c) ;

if numel(change(change==1))>numel(change(change==2))
    change=change-1;
else
    change=(change*-1+2);
end


time=toc;
%% Computing of Error Values Using Ground Truth Image
[All_Errors]=goruntu_kalite(change+1,gt+1);
All_Errors.Time=time;

% figure,imshow(img1,[])
% figure,imshow(img2,[])
% figure,imshow(fark,[])
% figure,imshow(fark1,[])
% figure,imshow(fark2,[])
 figure,imshow(change,[]),title('Change Detection Map by HTS-F')
 close all



% Create folder if it doesn't exist
folder_name = 'saved_images';
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end


% Save img1
figure;
imshow((img1), [])
colormap jet
% title('X1')
saveas(gcf, fullfile(folder_name, 'img1.png'))
close


% Save img1
figure;
imshow((img2), [])
colormap jet
% title('X1')
saveas(gcf, fullfile(folder_name, 'img2.png'))
close


% Save X1
figure;
imshow(imgaussfilt(X1), [])
colormap jet
% title('X1')
saveas(gcf, fullfile(folder_name, 'X1.png'))
close

% Save X2
figure;
imshow(imgaussfilt(X2), [])
colormap jet
% title('X2')
saveas(gcf, fullfile(folder_name, 'X2.png'))
close

% Save img1
figure;
All_Errors.XF1=XF1;
imshow(imgaussfilt(All_Errors.XF1), [])
colormap jet
% title('Xf1')
saveas(gcf, fullfile(folder_name, 'Xf1.png'))
close

% Save img2
figure;
imshow(imgaussfilt(XF2), [])
colormap jet
% title('Xf2')
saveas(gcf, fullfile(folder_name, 'Xf2.png'))
close

% Save Diffe
figure;
imshow(Diffe, [])
colormap jet
% title('D')
saveas(gcf, fullfile(folder_name, 'D.png'))
close

% Save Diffe_m
figure;
imshow(Diffe_m, [])
colormap jet
% title('Dm')
saveas(gcf, fullfile(folder_name, 'Dm.png'))
close

figure;
imshow(change,[])
colormap jet
% title('Change Detection Map by HTS-F')
saveas(gcf, fullfile(folder_name, 'CD.png'))
close