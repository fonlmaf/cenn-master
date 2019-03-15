%addpath('C:/matCNN');
cnn_setenv;
mCNN.TemGroup = 'temlib';

Atem_step1 = [291.6553 -118.9228 -106.4406; 
             -253.9071 -251.7907 -203.3817;
             -197.7633 -195.9248 273.83712];
Btem_step1 = [135.9598 139.5516 145.6166 ;
              229.4109 379.7530 212.4300 ; 
              160.3459 182.4772 153.2460];
BIAS_step1 = 223.3609;

Atem_step2 = [81.2522 -138.6389 -55.0413; 
             -64.4410 -1507432 -238.3880;
             -229.1651 -76.0652 60.3057];
Btem_step2 = [178.2492 142.5289 0.3584 ;
              -0.0220 294.5108 85.8291 ; 
              135.7233 95.3915 126.5357];
BIAS_step2 = 300.9400;

Atem_step3 = [0 0 0 ;0 3.9899 0; 0 0 0];
Btem_step3 = [-0.9804 -0.9804 -0.9804 ;
              -0.9804  8.0025 -0.9804 ; 
              -0.9804 -0.9804 -0.9804];
BIAS_step3 = -0.5387;

Atem_step4 = [0 0 0 ;0 4 0; 0 0 0];
Btem_step4 = [-1 -1 -1 ;
              -1  8 -1 ; 
              -1 -1 -1];
BIAS_step4 = -0.5;

Atem_cnn = [0.4650 0.5773 -0.6385;
-0.3090 -2.8782 -0.3090;
-0.6385 0.5773 0.4650];
Btem_cnn = [2.8451 3.8326 -1.0681
1.4856 -0.9895 1.4856
-1.0681 3.8326 2.8451];
BIAS_cnn = -4.9082;

Atem_mias = [-0.3912 4.6618 4.9898
2.8552 7.1702 2.8552
4.9898 4.6618 -0.3912];
Btem_mias = [2.5636 4.9664 -2.9539
2.5140 3.2211 2.5140
-2.9539 4.9664 2.5636];
BIAS_mias = -6.3426;


%cnnshow(mCNN.OUTPUT);
input = lbmp2cnn('mdb001.bmp');%('140context.bmp');
mCNN.STATE =  zeros(size(input));
mCNN.INPUT1 = input;
mCNN.Boundary = 1;
mCNN.TimeStep = 0.1;
mCNN.IterNum = 600;
loadtem('EDGE');
mCNN.Atem = Atem_mias;
mCNN.Btem = Btem_mias;
mCNN.I = BIAS_mias;
runtem;

cnnshow(mCNN.OUTPUT);
disp('done!');