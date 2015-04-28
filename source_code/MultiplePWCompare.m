% =====================================================================
% This is the program to find a result of Pairwise Comparison.
% Created by Dr. Jaeho H. BAE
% Assistant Professor
% Dept. of Logistics & Distribution Information at Hyechon University
% March, 2012.
% chillangri@gmail.com
% =====================================================================


function MultiplePWCompare;
%#codegen
clc;

% Original RI Values
% rRI = [0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51 1.54 1.56 1.57 1.59];

% Alonso-Lamata RI values (100,000 matrices)
rRI = [0 0 0.5245 0.8815 1.1086 1.2479 1.3417 1.4056 1.4499 1.4854 1.5141 1.5365 1.5551 1.5713 1.5838];

% ====================
% Major Option Setting
% ====================

% Weight calculation method.

sWeight = 'G'           % 기하평균 적용

%iCriteria = input('==> How many criteria in your case? ');

disp('CI, CR값 분석을 위한 파일을 data.xls로 만들어 저장하세요!')
tempData  = xlsread('data.xls','','','basic');

[row, col] = size(tempData);
iCriteria = tempData(:,1);
srcData   = tempData(:,2:col);
CRCI = zeros(row, 2);

for counter=1:row
    mCriteria = zeros(iCriteria(counter), iCriteria(counter));
    
    for rowLoop=1:iCriteria(counter)
        for colLoop=1:iCriteria(counter)
            if rowLoop == colLoop
                mCriteria(rowLoop, colLoop) =1;
            elseif rowLoop > colLoop
                mCriteria(rowLoop, colLoop) = 1/mCriteria(colLoop, rowLoop);
            else
                mCriteria(rowLoop, colLoop) = srcData(counter,(rowLoop+colLoop-2));
            end
        end
    end        
            [m, n] = size(mCriteria);
            [CI, CR] = findCR(mCriteria, rRI);
            CRCI(counter,:) = [CI, CR];
end     
            
CRCI


%% Subfunction 1. Priorities Calculation
function wVec=findWeight(mValue, sType)
% mValue: Weight를 구할 Matrix
% sType: 평균 계산 방법

if sType == 'A' %산술평균
    AVG = mean(mValue')';
elseif sType == 'H' %조화평균
    AVG = harmmean(mValue')';
else  %기하평균
    AVG = geomean(mValue')';
end

TOT = sum(AVG);

wVec=AVG./TOT;


%% Subfunction 2. Calculation of CI, CR
function [CI, CR] = findCR(mValue, valRI)
% mValue: CR을 구할 Matrix
% sizeM: Matrix의 사이즈
% valRI: RI values

tempLambda = max(eig(mValue));
tempSize = max(size(mValue));

%fprintf('== Lambda Max is %6.4f.\n', tempLambda)
CI = (tempLambda - tempSize)/(tempSize - 1);
CR = CI / valRI(tempSize);

if CI < 0.00001
    CI = 0;
end

if CR < 0.00001
    CR = 0;
end

%% Subfunction 3. Matrix Normalization
function normalizedMatrix = normalizedM(mValue)
% 입력된 Matrix의 column 기준 Normalize 값을 리턴
tempSum = sum(mValue);
tempSum = diag(tempSum);
normalizedMatrix = mValue * inv(tempSum);