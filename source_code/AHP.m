% =====================================================================
% This is the program to compute AHP problems.
% Created by Dr. Jaeho H. BAE
% Assistant Professor
% Dept. of Logistics & Distribution Information at Hyechon University
% March, 2012.
% chillangri@gmail.com
% =====================================================================

%% Main Function - AHP
function AHP;
% =====================================================================
% Variable Description
% ---------------------------------------------------------------------
% rRI               : Random Index in Row Vector
% sWeight           : Weight Calculation Method (Arithmetic, Harmoic, Geometric)
% iAlter            : Total Alternatives Number
% iCriteria         : Total Criteria Number
% sAlter            : Cell of Alternatives' Name
% sCriteria         : Cell of Criteria's Name
% mAlter            : Matrix of Alternatives         (3-Dimensional Matrix)
% mCriteria         : Matrix of Criteria
% wgtAlter          : Priorities of each Alternatives(3-Dimensional Matrix)
% wgtAlterResult    : Priorities of each Alternatives(2-Dimensional Matrix)
% wgtTotAlterResult : Evaluation Value Matrix
% wgtCriteria       : Priorities of Criteria
% CI                : Consistency Index
% CR                : Consistency Ratio
% =====================================================================
% Sub-Function Description
% ---------------------------------------------------------------------
% function wVec=findWeight(mValue, sType)
%          - Priorities Calculation
%          --- mValue   : Source Matrix
%          --- sTyep    : Meaning Method
% function [CI, CR] = findCR(mValue, valRI)
%          - Calculation for CI, CR
%          --- valRI    : Random Index Vector
% function normalizedMatrix = normalizedM(mValue)
%          - function for Normalization
% =====================================================================

clc;

% Original RI Values
% rRI = [0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51 1.54 1.56 1.57 1.59];

% Alonso-Lamata RI values (100,000 matrices)
rRI = [0 0 0.5245 0.8815 1.1086 1.2479 1.3417 1.4056 1.4499 1.4854 1.5141 1.5365 1.5551 1.5713 1.5838];


% ====================
% Major Option Setting
% ====================

% Weight calculation method.

disp('================================')
disp('Weight Calculation Methods')
disp(' ')
disp('  A: Arithmetic Mean, 산술평균')
disp('  H: Harmonic Mean,   조화평균')
disp('  G: Geometric Mean,  기하평균')
disp('================================')

sWeight = input('==> Select your weight calculation method: ','s');
if isempty(sWeight)
    sWeight=' ';
end

iAlter = input('==> How many alternatives in your case? ');
iCriteria = input('==> How many criteria in your case? ');

fprintf('\n')
disp('=============================================')
disp('=======   Option Setting Results      =======')
disp('---------------------------------------------')
disp('Option 1. Weight Calculation Results')
if sWeight == 'a' || sWeight =='A'
    disp(' ')
    disp('     Your Selectioin is Arithmethic Mean.')
    sWeight = 'A';
elseif sWeight == 'h' || sWeight == 'H'
    disp(' ')
    disp('     Your Selectioin is Harmonic Mean.')
    sWeight = 'H';
elseif sWeight == 'g' || sWeight == 'G'
    disp(' ')
    disp('     Your Selectioin is Geometric Mean.')
    sWeight = 'G';
else
    disp(' ')
    disp('     Default Selectioin is Geometric Mean!!')
    sWeight = 'G';    
end
disp('---------------------------------------------')
if iAlter <= 2
    disp('You cannot use AHP in this case')
    disp('Minimum Alternative number is 3')
    iAlter =3;
elseif iAlter > max(size(rRI))
    disp('You cannot use AHP in this case')
    fprintf('Maximum Alternative number is %d.\n', max(size(rRI)))
    iAlter =10;    
end

disp('Option 2. Number of Alternatives (판단대상)')
fprintf('\n     There are %d alternatives.\n', iAlter)

%disp ('There are ', sAlter, ' alternatives.')
disp('---------------------------------------------')

if iCriteria <= 2
    disp('You cannot use AHP in this case')
    disp('Minimum Criteria number is 3')
    iCriteria =3;
elseif iCriteria > max(size(rRI))
    disp('You cannot use AHP in this case')
    fprintf('Maximum Criteria number is %d.\n', max(size(rRI)))
    iCriteria =10;    
end


disp('Option 3. Number of Criteria (판단근거)')
fprintf('\n     There are %d criteria.\n', iCriteria)

%disp ('There are ', sCriteria, ' criterias.')
disp('=============================================')
fprintf('\n')

% ======================
% Variable Name Setting
% ======================

% Step 1. Alternative Name Setting
disp('-------------------------------------------')
disp('-----        Alternative Name      --------')
sAlter={};
for count =1 : iAlter
    fprintf('Input Alternative %d name: ', count)
    sAlter{count} = input(' ', 's');
end
disp('-------------------------------------------')
disp('Your Alternatives are;')
disp(sAlter)

% Setp 2. Criteria Name Setting
disp('-------------------------------------------')
disp('-----        Criteria Name      --------')
sCriteria={};
for count =1 : iCriteria
    fprintf('Input Criteria %d name: ', count)
    sCriteria{count} = input(' ', 's');
end
disp('-------------------------------------------')
disp('Your Criteria are;')
disp(sCriteria)        
disp('-------------------------------------------')

% ======================
% Data Processing
% ======================

% Define Criteria
mCriteria = zeros(iCriteria, iCriteria);

inputCase = menu('Select Criteria Input Way', 'Text (직접입력)', 'Dialogbox (대화상자)');
switch inputCase
    case 1
        mCriteria = input('Input Criteria Matrix\n')
    case 2
        for rowLoop=1:iCriteria
            for colLoop=1:iCriteria
                if rowLoop == colLoop
                    mCriteria(rowLoop, colLoop) =1;
                elseif rowLoop > colLoop
                    mCriteria(rowLoop, colLoop) = 1/mCriteria(colLoop, rowLoop);
                else
                    tempString = '';                    
                    tempString = [sCriteria{rowLoop} ' 와 ' sCriteria{colLoop} ' 의 비교값은?'];
                    tempString = inputdlg(tempString, 'Input Criteria Value');
                    mCriteria(rowLoop, colLoop) = str2num(char(tempString));
                end
            end
        end
end

[m, n] = size(mCriteria);

if m==iCriteria && n==iCriteria
    fprintf('Your Criteria Matrix is %d X %d Matrix.\n', m, n)
%    disp(sCriteria)
    [CI, CR] = findCR(mCriteria, rRI);
    fprintf('                   CI of Criteria is %6.4f.\n', CI)
    fprintf('                   CR of Criteria is %6.4f.\n', CR)
    if CI > 0.1
        disp('               ----CI is NOT in confidence level (CI>0.1).')
    end
    if CR > 0.1
        disp('               ----CR is NOT in confidence level (CR>0.1).')
    else
        disp('                   CR is in confidence level.')
    end
    disp(mCriteria)
    mCriteria = normalizedM(mCriteria);
    disp(mCriteria)
else
    disp('Your Criteria Matrix is not correct')
end

wgtCriteria = findWeight(mCriteria, sWeight);
%nmlCriteria = normalizedM(mCriteria);
disp('Priorities of this Matrix are following: ')
% disp(nmlCriteria);
disp(wgtCriteria);

% Evaluate each Alternatives
inputCase = menu('Select Alternatives Input Way', 'Text (직접입력)', 'Dialogbox (대화상자)');
switch inputCase
    case 1
        for pageLoop = 1:iCriteria
            tempString = '';
            tempString = [sCriteria{pageLoop} ' 에대한 평가결과를 입력하시오.'];
            disp(tempString)
            mAlter(:,:,pageLoop) = input('Input Alternative Valuation Matrix\n');
        end
    case 2
        for pageLoop=1:iCriteria
            for rowLoop=1:iAlter
                for colLoop=1:iAlter
                    if rowLoop == colLoop
                        mAlter(rowLoop, colLoop, pageLoop) =1;
                    elseif rowLoop > colLoop
                        mAlter(rowLoop, colLoop, pageLoop) = 1/mAlter(colLoop, rowLoop, pageLoop);
                    else
                        tempString = '';
                        tempString = [sCriteria{pageLoop} ' 에서  '];
                        tempString = [tempString sAlter{rowLoop} ' 와 ' sAlter{colLoop} ' 의 비교값은?'];
                        tempString = inputdlg(tempString, 'Input Alternatives Valuation Result');
                        mAlter(rowLoop, colLoop, pageLoop) = str2num(char(tempString));
                    end
                end
            end
        end
end

[m, n, l] = size(mAlter);

if l == iCriteria && m==iAlter && n==iAlter
    disp('-------------------------------------------')
    fprintf('Your Alternatives Matrix is %d X %d X %d Matrix.\n', l, m, n)
%    disp(sCriteria)

    for pageLoop=1:iCriteria
        fprintf('%s에 대한 평가 결과\n', sCriteria{pageLoop})
        [CI, CR] = findCR(mAlter(:,:,pageLoop), rRI);
        fprintf('                   CI of Criteria is %6.4f.\n', CI)
        fprintf('                   CR of Criteria is %6.4f.\n', CR)
        if CI > 0.1
            disp('               ----CI is NOT in confidence level (CI>0.1).')
        end
        if CR > 0.1
            disp('               ----CR is NOT in confidence level (CR>0.1).')
        else
            disp('                   CR is in confidence level.')
        end
        disp(mAlter(:,:,pageLoop))
        mAlter(:,:,pageLoop) = normalizedM(mAlter(:,:,pageLoop));
        disp(mAlter(:,:,pageLoop))
        wgtAlter(:,:,pageLoop) = findWeight(mAlter(:,:,pageLoop), sWeight);
        disp('Priorities of this Matrix are following: ')
        disp(wgtAlter(:,:,pageLoop));
    end
%    disp(wgtAlter);
else
    disp('Your Alternatives Valuation Result is not correct')
end

wgtAlterResult = wgtAlter(:,:,1);

for pageLoop=2:iCriteria
    wgtAlterResult = [wgtAlterResult, wgtAlter(:,:,pageLoop)];
end

% 결과 출력

disp(' ')
disp('=============================================')
disp('=======       평가         결과         ======')
for pageLoop=1:iAlter
    fprintf('%s에 대한 종합평가---\n', sAlter{pageLoop})
    disp(wgtAlter(pageLoop,:))
    %wgtAlterResult % = wgtAlterResult'
end
%display = [wgtCriteria; wgtAlterResult]
%dip(display)
wgtTotAlterResult = wgtAlterResult * wgtCriteria;

disp('---------------------------------------------')
disp('------       최종     평가      결과     ------')
for pageLoop=1:iAlter
    fprintf('%s:     %6.4f\n', sAlter{pageLoop}, wgtTotAlterResult(pageLoop,:))
    %disp(wgtTotAlterResult(pageLoop,:))
    %disp(wgtAlterResult(pageLoop,:), rank(wgtAlterResult))
    %wgtAlterResult % = wgtAlterResult'
end

%disp(wgtAlterResult * wgtCriteria)
        


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