# Machine Learning Study
## This is a series of studies on machine learning.

### The methods, lessons, and insights from each module are listed below.

## 1 - Iris Petal study
### A baseline study using iris petals from the R dataset and KNN to predict their values.
A confusion matrix was used and an accuracy of 96.67% was achieved. 
<code>
Confusion Matrix and Statistics

            Reference
Prediction   setosa versicolor virginica
  setosa         10          0         0
  versicolor      0         11         1
  virginica       0          0         8

Overall Statistics
                                          
               Accuracy : 0.9667          
                 95% CI : (0.8278, 0.9992)
    No Information Rate : 0.3667          
    P-Value [Acc > NIR] : 4.476e-12       
                                          
                  Kappa : 0.9497          
                                          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: setosa Class: versicolor Class: virginica
Sensitivity                 1.0000            1.0000           0.8889
Specificity                 1.0000            0.9474           1.0000
Pos Pred Value              1.0000            0.9167           1.0000
Neg Pred Value              1.0000            1.0000           0.9545
Prevalence                  0.3333            0.3667           0.3000
Detection Rate              0.3333            0.3667           0.2667
Detection Prevalence        0.3333            0.4000           0.2667
Balanced Accuracy           1.0000            0.9737           0.9444
</code>


## 2 - Breast Cancer Predict
### A study using KNN to predict breast cancer with 2 data sets, the first for training and test and the second with new data to see the prediction working on classification.
On 80% for tranning and 20% for testing was found a 95,71% accuracy.
<code>
Confusion Matrix and Statistics

           Reference
Prediction  benign malignant
  benign        86         2
  malignant      4        48
                                          
               Accuracy : 0.9571          
                 95% CI : (0.9091, 0.9841)
    No Information Rate : 0.6429          
    P-Value [Acc > NIR] : <2e-16          
                                          
                  Kappa : 0.9075          
                                          
 Mcnemar's Test P-Value : 0.6831          
                                          
            Sensitivity : 0.9556          
            Specificity : 0.9600          
         Pos Pred Value : 0.9773          
         Neg Pred Value : 0.9231          
             Prevalence : 0.6429          
         Detection Rate : 0.6143          
   Detection Prevalence : 0.6286          
      Balanced Accuracy : 0.9578          
                                          
       'Positive' Class : benign 
</code>

Now for the new 3 cases input dignosed them with benign.

## 3 - Tree Volume Prediction
### A study using KNN to predict volume from trees with 2 data sets, the first for training and test and the second with new data to see the prediction working on regression.


<code>
k-Nearest Neighbors 

246 samples
  5 predictor

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 246, 246, 246, 246, 246, 246, ... 
Resampling results across tuning parameters:

  k  RMSE      Rsquared   MAE     
  1  123.5028  0.6429593  89.26398
  3  112.5262  0.6899807  83.89845
  5  110.2912  0.7002208  84.26347
  7  107.9236  0.7124659  83.60382
  9  107.4121  0.7153338  83.73420

RMSE was used to select the optimal model using the smallest value.
The final value used for the model was k = 9.

> r2(predict.knn,teste$Volume)
[1] 0.71982
</code>

## 4 - Students Prediction
### A study using KNN to predict students grades with 2 data sets, the first for training and test and the second with new data to see the prediction working on regression.

<code>
k-Nearest Neighbors 

318 samples
 32 predictor

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 318, 318, 318, 318, 318, 318, ... 
Resampling results across tuning parameters:

  k  RMSE      Rsquared   MAE     
  1  2.351203  0.7450570  1.471464
  3  2.068055  0.7992926  1.352679
  5  1.925131  0.8265584  1.306500
  7  1.968520  0.8198420  1.344281
  9  1.968547  0.8214859  1.360183

RMSE was used to select the optimal model using the smallest value.
The final value used for the model was k = 5.

> r2(predict.knn,teste$G3)
[1] 0.8040666
</code>

## 5 - Bank Prediction
### A study using KNN to predict bank possible investors with 2 data sets, the first for training and test and the second with new data to see the prediction working on regression.

k-Nearest Neighbors 

240 samples
  8 predictor
  2 classes: 'no', 'yes' 

No pre-processing
Resampling: Bootstrapped (25 reps) 
Summary of sample sizes: 240, 240, 240, 240, 240, 240, ... 
Resampling results across tuning parameters:

  k  Accuracy   Kappa     
  1  0.8708621  0.23941128
  3  0.8694764  0.15256538
  5  0.8747770  0.08970842
  7  0.8834569  0.02979339
  9  0.8869363  0.01085942

Accuracy was used to select the optimal model using the largest value.
The final value used for the model was k = 9.