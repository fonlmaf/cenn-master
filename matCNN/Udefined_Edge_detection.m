function [output] = Udefined_Edge_detection(inputfile)  
cnn_setenv;
% Atem_step1 = [291.6553 -118.9228 -106.4406; 
%              -253.9071 -251.7907 -203.3817;
%              -197.7633 -195.9248 273.83712];
% Btem_step1 = [135.9598 139.5516 145.6166 ;
%               229.4109 379.7530 212.4300 ; 
%               160.3459 182.4772 153.2460];
% BIAS_step1 = 223.3609;
% 
% Atem_step2 = [81.2522 -138.6389 -55.0413; 
%              -64.4410 -1507432 -238.3880;
%              -229.1651 -76.0652 60.3057];
% Btem_step2 = [178.2492 142.5289 0.3584 ;
%               -0.0220 294.5108 85.8291 ; 
%               135.7233 95.3915 126.5357];
% BIAS_step2 = 300.9400;

% Atem_step3 = [0 0 0 ;0 3.9899 0; 0 0 0];
% Btem_step3 = [-0.9804 -0.9804 -0.9804 ;
%               -0.9804  8.0025 -0.9804 ; 
%               -0.9804 -0.9804 -0.9804];
% BIAS_step3 = -0.5387;

% Atem_step4 = [0 0 0 ;0 4 0; 0 0 0];
% Btem_step4 = [-1 -1 -1 ;
%               -1  8 -1 ; 
%               -1 -1 -1];
% BIAS_step4 = -0.5;


input1 = lbmp2cnn(inputfile);
mCNN.INPUT1 = input1;
mCNN.STATE = input1;%zeros(size(input1));
mCNN.Boundary = -1;
mCNN.TimeStep = 0.1;
mCNN.IterNum = 50;
loadtem('EDGE');
mCNN.Atem = Atem_step3;
mCNN.Btem = Btem_step3;
mCNN.I = BIAS_step3;
%mCNN.TemType=0;
runtem;
%cnnshow(mCNN.OUTPUT);
output = mCNN.OUTPUT;
%scnn2bmp('roadout.bmp',mCNN.OUTPUT);
end