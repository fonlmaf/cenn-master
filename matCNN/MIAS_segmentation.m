function [output] = MIAS_segmentation(inputfile)
cnn_setenv;

Atem_MIAS = [-0.3912 4.6618 4.9898 ;
              2.8552  7.1702 2.8552 ; 
              4.9898 4.6618 -0.3912];
Btem_MIAS = [2.5636 4.9664 -2.9539 ;
              2.5140 3.2211 2.5140; 
              -2.9539 4.9664 2.5636];
BIAS_MIAS = -6.3426;

Atem_SEG = [0.4650 0.5773 -0.6385 ;
              -0.3090  -2.8782 -0.3090 ; 
              -0.6385 0.5773 0.4650];
Btem_SEG = [2.8451 3.8326 -1.0681 ;
              1.4856 -0.9895 1.4856; 
              -1.0681 3.8326 2.8451];
BIAS_SEG = -4.9082;

input1 = lbmp2cnn(inputfile);
mCNN.INPUT1 = input1;
mCNN.STATE = input1;%zeros(size(input1));
mCNN.Boundary = -1;
mCNN.TimeStep = 0.1;
mCNN.IterNum = 15;%50
loadtem('EDGE');
mCNN.Atem = Atem_MIAS;
mCNN.Btem = Btem_MIAS;
mCNN.I = BIAS_MIAS;
%mCNN.TemType=0;
runtem;
output = mCNN.OUTPUT;
%cnnshow(mCNN.OUTPUT);
%scnn2bmp('roadout.bmp',mCNN.OUTPUT);
end