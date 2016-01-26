% Real-time classify the acquaintance
function str1 = RTface(center,net)

for k = 1:10
    cam = webcam(1);
    im = snapshot(cam);
    clear cam;
    % throw into face detector and return face position
    figure(1) ; clf ; imagesc(im) ; axis equal off ; hold on;
    face = py.mymod.facecap;
    if(size(face,2)~=0)
        face = double(py.array.array('d',py.numpy.nditer(face)));
        face = reshape(face, 4, numel(face)/4)';
    
       
      for i = 1:size(face,1) 
        im_ = single(im(face(i,2):face(i,2)+face(i,4),face(i,1):face(i,1)+face(i,3),:)) ; % note: 255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
        res = vl_simplenn(net, im_) ;
    
        facevector(1:4096) = res(35).x;
        dis = pdist2(double(facevector),center);
        [m,idx] = min(dis);
        if (idx==1 && m<400)
            str1 = 'Meng';
        elseif (idx==2 && m<400)
            str1 = 'Ching';
        else
            str1 = '?';
        end
        rectangle('Position',[face(i,1) face(i,2) face(i,3) face(i,4)],'EdgeColor','g','LineWidth',2);
        text(face(i,1),face(i,2)+10,str1,'FontSize',20,'color','g');
      end
    end
    
end
    
end    