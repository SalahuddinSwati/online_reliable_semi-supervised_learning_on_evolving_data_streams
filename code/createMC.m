    function [ Model_temp ] = createMC( Model_temp,ex, r,currentTime)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    global maxMC;

    if size(Model_temp,1)>=maxMC
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ulabel_clu_cen=find(cell2mat(Model_temp(:,5))==0);
        if size(ulabel_clu_cen,1)>1
            [ Model_temp ] = mergMCul( Model_temp );
        else
            [ mxclabel, mxcfre ] = findMaxClass( Model_temp );

            label_clu_cen=find(cell2mat(Model_temp(:,4))==mxclabel);
            [ Model_temp ] = mergMC( label_clu_cen,Model_temp );
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end


    LS=sum(ex.data,1); %LS
    SS=sum(ex.data.^2,1); %SS
    sz=size(LS,2);
    LSC=zeros(1,sz);
    % clu_r=sqrt(sum(SS/N_pt)-sum((LS/N_pt).^2));
    micro_clu{1,1}=LS;
    micro_clu{1,2}=SS;
    micro_clu{1,3}=1; %total points in mc
    if ex.label_flg==1
        micro_clu{1,4}=ex.label; %mc label
        micro_clu{1,5}=1; % label flg
    else
        micro_clu{1,4}=0;
        micro_clu{1,5}=0;
    end
    micro_clu{1,6}=LS; %mc center

    micro_clu{1,7}=r; %mc radius
    micro_clu{1,8}=currentTime; %current time
    micro_clu{1,9}=1; %importance
    a=size(Model_temp,1);
    Model_temp(a+1,:)=micro_clu;

    end

