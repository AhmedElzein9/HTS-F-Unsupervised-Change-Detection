Matlab Source Code: Unsupervised Change Detection from SAR Images via Non-Local Mean Filter and Hyperbolic Tangent Sigmoid Function 

Hts_f.m: Main code for change detection
goruntu_kalite.m , imageQualityIndex.m and kappaindex.m codes are for accuarcy asessment In Matlab:
%Suggested Windows size (sws in code) for non local means filter (11 for Bern dataset, 55 for Ottawa dataset, 73 for Yellow River dataset, and 127 for Farmland dataset);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[change,All_Errors]=hts_f(img1,img2,gt,sws)


----Inputs: “img1” and “img2” are SAR images, “gt” is ground truth image, “sws” is search window size for non-local means filtering of image
---Outputs: “change” is change map and “All_Errors” is error values computed using ground truth
___________________________________________________________________________________________
For Ottawa Application In Matlab

[1]	load('Ottawa_Dataset.mat')

[2]	[change,All_Errors]=hts_f(img1,img2,gt,55)
___________________________________________________________________________________________
For Bern Application In Matlab

[1]	load('Bern_Dataset.mat')

[2]	[change,All_Errors]=hts_f(img1,img2,gt,11)
___________________________________________________________________________________
For Yellow River Application

[1]	load('Yellow_River_Dataset.mat')

[2]	[change,All_Errors]=hts_f(img1,img2,gt,73)
___________________________________________________________________________________
For Farmland Application (Not included in our article)

[1]	load(FarmC.mat')

[2]	[change,All_Errors]=hts_f(img1,img2,gt,127)



How to Cite This Work

If you use this code or ideas from this repository in your research or project, please cite our related publication:

Atasever, Ü. H., Elzein, A., & Abbas, H. H. (2025). Unsupervised change detection in SAR images using a non-local mean filter and hyperbolic tangent sigmoid function. Remote Sensing Letters, 16(5), 483–493. https://doi.org/10.1080/2150704X.2025.2471592
