function facevector = deepface(net)
    dirname = [pwd,'\facedata\data\'];
    imgNames = dir([dirname '*.jpg']);
    imgNames={imgNames.name};
    N = length(imgNames);
    facevector = zeros(N,4096);
    for i = 1:N
        im = imread(imgNames{i});
        im_ = single(im);
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = bsxfun(@minus,im_,net.meta.normalization.averageImage) ;
        res = vl_simplenn(net, im_) ;
        facevector(i,:) = res(35).x;
    end
end
